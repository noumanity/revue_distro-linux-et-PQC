#!/usr/bin/env texlua
-- render_slide.lua - convertit content.md en frame LaTeX Beamer
-- Usage: texlua render_slide.lua <content.md> <config.yaml> <output.tex> <templates_dir> <workdir_assets>
-- Stack: texlua (TeX Live), tinyyaml (TeX Live), etlua (scripts/lib/), Markdown maison
-- Conforme ADR-001 : ni Python ni pandoc.

-- Chemins des bibliotheques
local script_dir = (arg[0] or ""):match("(.*[/\\])") or "./"
local texmf_luatex = "/usr/share/texlive/texmf-dist/tex/luatex/markdown/"
package.path = script_dir .. "lib/?.lua;"
             .. script_dir .. "?.lua;"
             .. texmf_luatex .. "?.lua;"
             .. package.path

local etlua    = require("etlua")
local tinyyaml = require("markdown-tinyyaml")

-- Correspondances noms de champs francais -> anglais canonique
local FIELD_MAP = {
  ["Titre"]        = "title",
  ["Auteurs"]      = "authors",
  ["Demo"]         = "demo",
  ["Preparefor"]   = "event",   -- apres normalisation des espaces (voir normalize_keys)
  ["Date"]         = "date",
  ["Lieu"]         = "location",
}

-- Escape LaTeX caractere par caractere (safe UTF-8 : les octets > 127 passent sans changement)
local TEX_ESCAPES = {
  ["\\"] = "\\textbackslash{}",
  ["{"]  = "\\{",
  ["}"]  = "\\}",
  ["&"]  = "\\&",
  ["%"]  = "\\%",
  ["$"]  = "\\$",
  ["#"]  = "\\#",
  ["_"]  = "\\_",
  ["~"]  = "\\textasciitilde{}",
  ["^"]  = "\\^{}",
}

local function tex_escape(s)
  if type(s) ~= "string" then s = tostring(s or "") end
  return (s:gsub(".", function(c) return TEX_ESCAPES[c] or c end))
end

-- Rendu inline Markdown -> LaTeX (**gras**, *italic*, `code`)
-- Appele APRES tex_escape sur la partie texte brut.
local function inline_md(s)
  -- Gras: **text** -> \textbf{text}
  s = s:gsub("%*%*(.-)%*%*", "\\textbf{%1}")
  -- Italique: *text* -> \emph{text}
  s = s:gsub("%*(.-)%*", "\\emph{%1}")
  -- Code: `text` -> \texttt{text}
  s = s:gsub("`(.-)`", "\\texttt{%1}")
  return s
end

local function process_line(raw)
  return inline_md(tex_escape(raw))
end

-- Rendu du corps Markdown (blocs : paragraphes, listes a 2 niveaux)
local function render_body(text)
  if not text or text:match("^%s*$") then return "" end

  local lines = {}
  for line in (text .. "\n"):gmatch("([^\n]*)\n") do
    lines[#lines+1] = line
  end

  local out   = {}
  local state = "para"   -- "para" | "item1" | "item2"
  local para  = {}

  local function flush_para()
    if #para > 0 then
      out[#out+1] = table.concat(para, " ")
      out[#out+1] = ""
      para = {}
    end
  end

  local function close_item2()
    if state == "item2" then
      out[#out+1] = "  \\end{itemize}"
      state = "item1"
    end
  end

  local function close_items()
    close_item2()
    if state == "item1" then
      out[#out+1] = "\\end{itemize}"
      state = "para"
    end
  end

  for _, line in ipairs(lines) do
    local nested = line:match("^%s%s+[%-*]%s+(.*)")
    local top    = line:match("^[%-*]%s+(.*)")

    if nested then
      flush_para()
      if state == "para" then
        out[#out+1] = "\\begin{itemize}\\setlength{\\itemsep}{2pt}"
        state = "item1"
      end
      if state == "item1" then
        out[#out+1] = "  \\begin{itemize}\\setlength{\\itemsep}{1pt}"
        state = "item2"
      end
      out[#out+1] = "    \\item " .. process_line(nested)
    elseif top then
      flush_para()
      close_item2()
      if state == "para" then
        out[#out+1] = "\\begin{itemize}\\setlength{\\itemsep}{2pt}"
        state = "item1"
      end
      out[#out+1] = "  \\item " .. process_line(top)
    elseif line == "" then
      close_items()
      flush_para()
    else
      close_items()
      para[#para+1] = process_line(line)
    end
  end

  close_items()
  flush_para()
  return table.concat(out, "\n")
end

-- Lecture du front matter YAML et du corps d'un content.md
local function parse_frontmatter(path)
  local fh = assert(io.open(path, "r"), "Impossible d'ouvrir : " .. path)
  local raw = fh:read("*a")
  fh:close()

  if not raw:match("^%-%-%-") then return {}, raw end

  local front_end = raw:find("\n%-%-%-", 4)
  if not front_end then return {}, raw end

  local front_str = raw:sub(4, front_end - 1)
  local body      = raw:sub(front_end + 4):match("^%s*(.*%S)%s*$") or ""

  -- Neutraliser le prefixe @ (notation IDE, invalide en YAML)
  front_str = front_str:gsub("@([./])", "%1")
  -- Denormaliser les espaces echappes shell (\ ) en espaces reels
  front_str = front_str:gsub("\\ ", " ")

  local ok, meta = pcall(tinyyaml.parse, front_str)
  if not ok then
    io.stderr:write("[WARN] YAML parse error : " .. tostring(meta) .. "\n")
    return {}, body
  end
  return meta or {}, body
end

-- Normalisation des cles (suppression espaces, accents courants, puis FIELD_MAP)
local function normalize_key(k)
  -- Retirer espaces et accents pour un matching robuste
  local plain = k:gsub(" ", ""):gsub("\195\169", "e"):gsub("\195\168", "e")
                  :gsub("\195\160", "a"):gsub("\195\180", "o"):gsub("\195\170", "e")
  return FIELD_MAP[plain] or FIELD_MAP[k] or k:lower()
end

local function normalize_fields(meta)
  local out = {}
  for k, v in pairs(meta) do
    out[normalize_key(k)] = v
  end
  return out
end

-- Resolution d'un chemin d'asset (strip @, normalise, fallback, convertit si besoin)
local function resolve_asset(raw, root, workdir_assets)
  if type(raw) ~= "string" then return nil end
  raw = raw:gsub("^@", ""):gsub("\\ ", " ")

  local function exists(p)
    local fh = io.open(p, "r")
    if fh then fh:close() return true end
    return false
  end

  local candidate = root .. "/" .. raw
  if not exists(candidate) then
    -- Repli : .dev/assets/ -> assets/branding/
    local alt = raw:gsub("%.dev/assets/", "assets/branding/")
    local alt_candidate = root .. "/" .. alt
    if exists(alt_candidate) then
      candidate = alt_candidate
    else
      io.stderr:write("[WARN] Asset introuvable : " .. raw .. "\n")
      return nil
    end
  end

  local ext  = candidate:match("%.(%w+)$"):lower()
  local stem = candidate:match("([^/\\]+)%.[^%.]+$"):gsub("[^%w%.%-]", "_")

  if ext == "svg" then
    local target = workdir_assets .. "/" .. stem .. ".pdf"
    if not exists(target) then
      local cmd = string.format(
        "inkscape --export-type=pdf --export-filename=%q %q 2>/dev/null",
        target, candidate)
      os.execute(cmd)
    end
    return target
  end

  if ext == "webp" then
    local target = workdir_assets .. "/" .. stem .. ".png"
    if not exists(target) then
      os.execute(string.format("convert %q %q 2>/dev/null", candidate, target))
    end
    return target
  end

  return candidate
end

local function format_logos(paths)
  if not paths or #paths == 0 then return "" end
  local items = {}
  for _, p in ipairs(paths) do
    items[#items+1] = string.format("\\includegraphics[height=1.1cm]{%s}", p)
  end
  return table.concat(items, "\\hspace{1.5em}")
end

-- Point d'entree
local function main()
  if #arg < 5 then
    print("Usage: texlua render_slide.lua <content.md> <config.yaml> <output.tex> <templates_dir> <workdir_assets>")
    os.exit(1)
  end

  local content_md, config_yaml, output_tex, templates_dir, workdir_assets =
    arg[1], arg[2], arg[3], arg[4], arg[5]

  local root = os.getenv("PRESENTATION_ROOT") or "."

  -- Creer workdir_assets si absent
  os.execute("mkdir -p " .. workdir_assets)

  -- Lire le slide
  local meta, body = parse_frontmatter(content_md)
  meta = normalize_fields(meta)

  -- Lire config.yaml
  local fh = assert(io.open(config_yaml, "r"))
  local config_str = fh:read("*a"); fh:close()
  local ok, config = pcall(tinyyaml.parse, config_str)
  if not ok then config = {} end
  config = config or {}

  -- Determiner le modele
  local model = meta["model"]
  if not model then
    model = meta["authors"] and "title" or (config["default_model"] or "plain")
  end

  -- Charger le gabarit etlua
  local tpl_path = templates_dir .. "/models/" .. model .. ".tex"
  local fh2 = assert(io.open(tpl_path, "r"), "Gabarit introuvable : " .. tpl_path)
  local template = fh2:read("*a"); fh2:close()

  -- Construire le contexte (config d'abord, slide par-dessus)
  local ctx = {}
  for k, v in pairs(config) do ctx[k] = v end
  for k, v in pairs(meta)   do ctx[k] = v end

  -- Background
  local bg_raw = ctx["background"]
  if bg_raw and bg_raw ~= "" then
    local bg_path = resolve_asset(bg_raw, root, workdir_assets)
    if bg_path then
      ctx["background_block"] =
        "\\begin{tikzpicture}[remember picture, overlay]\n"
        .. "  \\node[at=(current page.center)] {%\n"
        .. "    \\includegraphics[width=\\paperwidth,height=\\paperheight]{"
        .. bg_path .. "}};\n"
        .. "\\end{tikzpicture}"
    else
      ctx["background_block"] = ""
    end
  else
    ctx["background_block"] = ""
  end

  -- Auteurs
  local authors = ctx["authors"] or {}
  if type(authors) == "string" then authors = { authors } end
  local auth_parts = {}
  for _, a in ipairs(authors) do auth_parts[#auth_parts+1] = tex_escape(a) end
  ctx["authors_formatted"] = table.concat(auth_parts, " \\\\ ")

  -- Champs texte
  ctx["title_tex"]    = tex_escape(tostring(ctx["title"]    or ""))
  ctx["subtitle_tex"] = tex_escape(tostring(ctx["subtitle"] or ""))
  ctx["event_tex"]    = tex_escape(tostring(ctx["event"]    or ""))
  ctx["date_tex"]     = tex_escape(tostring(ctx["date"]     or ""))
  ctx["demo_tex"]     = tex_escape(tostring(ctx["demo"]     or ""))

  -- Logos
  local logos_raw = ctx["logos"] or {}
  local logo_paths = {}
  for _, lr in ipairs(logos_raw) do
    local p = resolve_asset(lr, root, workdir_assets)
    if p then logo_paths[#logo_paths+1] = p end
  end
  ctx["logos_formatted"] = format_logos(logo_paths)

  -- Corps Markdown
  ctx["content"] = render_body(body)

  -- Rendre le gabarit avec etlua
  local compiled = assert(etlua.compile(template))
  local rendered = compiled(ctx)

  -- Ecrire le .tex de sortie
  os.execute("mkdir -p " .. output_tex:match("(.*[/\\])"))
  local fh3 = assert(io.open(output_tex, "w"))
  fh3:write(rendered)
  fh3:close()
  io.write("[OK] " .. output_tex .. "\n")
end

main()
