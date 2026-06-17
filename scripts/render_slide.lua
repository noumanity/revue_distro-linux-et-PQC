#!/usr/bin/env texlua
-- render_slide.lua - convertit content.md en frame(s) LaTeX Beamer
-- Usage: texlua render_slide.lua <content.md> <config.yaml> <output.tex> <templates_dir> <workdir_assets>
-- Stack: texlua (TeX Live), tinyyaml (TeX Live), etlua (scripts/lib/), Markdown maison
-- Conforme ADR-001 : ni Python ni pandoc.

local script_dir   = (arg[0] or ""):match("(.*[/\\])") or "./"
local texmf_luatex = "/usr/share/texlive/texmf-dist/tex/luatex/markdown/"
package.path = script_dir .. "lib/?.lua;"
             .. script_dir .. "?.lua;"
             .. texmf_luatex .. "?.lua;"
             .. package.path

local etlua    = require("etlua")
local tinyyaml = require("markdown-tinyyaml")

-- Correspondances noms de champs francais -> anglais canonique (format ancien)
local FIELD_MAP = {
  ["Titre"]      = "title",
  ["Auteurs"]    = "authors",
  ["Demo"]       = "demo",
  ["Preparefor"] = "event",
  ["Date"]       = "date",
  ["Lieu"]       = "location",
}

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
  -- yaml.null de tinyyaml est une table ; nil et tables -> chaine vide
  if type(s) == "table" then s = ""
  elseif type(s) ~= "string" then s = tostring(s or "") end
  return (s:gsub(".", function(c) return TEX_ESCAPES[c] or c end))
end

local function inline_md(s)
  s = s:gsub("%*%*(.-)%*%*", "\\textbf{%1}")
  s = s:gsub("%*(.-)%*",     "\\emph{%1}")
  s = s:gsub("`(.-)`",       "\\texttt{%1}")
  return s
end

local function process_line(raw)
  return inline_md(tex_escape(raw))
end

local function render_body(text)
  if not text or text:match("^%s*$") then return "" end

  local lines = {}
  for line in (text .. "\n"):gmatch("([^\n]*)\n") do
    lines[#lines+1] = line
  end

  local out      = {}
  local state    = "para"
  local para     = {}
  local tbl_rows = {}

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

  local function parse_cells(line)
    local inner = line:match("^%s*|(.+)|%s*$") or line:match("^%s*|(.+)")
    if not inner then return {} end
    local cells = {}
    for cell in (inner .. "|"):gmatch("([^|]*)|") do
      cells[#cells+1] = cell:match("^%s*(.-)%s*$") or ""
    end
    return cells
  end

  local function flush_table()
    if #tbl_rows == 0 then return end
    local header = tbl_rows[1]
    local ncols  = #header
    if ncols == 0 then tbl_rows = {}; return end
    local result = {}
    result[#result+1] = "\\begin{tabular}{" .. string.rep("l", ncols) .. "}"
    result[#result+1] = "\\toprule"
    local hcells = {}
    for _, c in ipairs(header) do hcells[#hcells+1] = process_line(c) end
    result[#result+1] = table.concat(hcells, " & ") .. " \\\\"
    result[#result+1] = "\\midrule"
    -- tbl_rows[2] est la ligne séparatrice (---|---), on la saute
    for i = 3, #tbl_rows do
      local row    = tbl_rows[i]
      local dcells = {}
      for ci = 1, ncols do
        dcells[#dcells+1] = process_line(row[ci] or "")
      end
      result[#result+1] = table.concat(dcells, " & ") .. " \\\\"
    end
    result[#result+1] = "\\bottomrule"
    result[#result+1] = "\\end{tabular}"
    out[#out+1] = table.concat(result, "\n")
    out[#out+1] = ""
    tbl_rows = {}
  end

  for _, line in ipairs(lines) do
    if line:match("^%s*|") then
      -- Ligne de tableau
      flush_para()
      close_items()
      tbl_rows[#tbl_rows+1] = parse_cells(line)
    else
      flush_table()
      local hashes, htxt = line:match("^(#+)%s+(.*)")
      local nested        = line:match("^%s%s+[%-*]%s+(.*)")
      local top           = line:match("^[%-*]%s+(.*)")

      if hashes then
        flush_para(); close_items()
        local lvl = #hashes
        local t   = process_line(htxt)
        if     lvl == 1 then out[#out+1] = "{\\large\\textbf{\\structure{" .. t .. "}}\\par\\vspace{0.2em}}"
        elseif lvl == 2 then out[#out+1] = "{\\textbf{\\structure{" .. t .. "}}\\par\\vspace{0.1em}}"
        elseif lvl == 3 then out[#out+1] = "{\\textbf{" .. t .. "}\\par}"
        else              out[#out+1] = "{\\textit{" .. t .. "}\\par}"
        end
      elseif nested then
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
        flush_para(); close_item2()
        if state == "para" then
          out[#out+1] = "\\begin{itemize}\\setlength{\\itemsep}{2pt}"
          state = "item1"
        end
        out[#out+1] = "  \\item " .. process_line(top)
      elseif line == "" then
        close_items(); flush_para()
      else
        close_items()
        para[#para+1] = process_line(line)
      end
    end
  end

  flush_table()
  close_items()
  flush_para()
  return table.concat(out, "\n")
end

-- Decouper un texte en blocs markdown separes par ligne vide.
local function split_markdown_blocks(text)
  local blocks = {}
  local current = {}
  for line in (text .. "\n"):gmatch("([^\n]*)\n") do
    if line:match("^%s*$") then
      if #current > 0 then
        blocks[#blocks+1] = table.concat(current, "\n")
        current = {}
      end
    else
      current[#current+1] = line
    end
  end
  if #current > 0 then
    blocks[#blocks+1] = table.concat(current, "\n")
  end
  return blocks
end

-- Organiser des blocs markdown en pages verbatim 2 colonnes.
-- Heuristique conservative pour eviter le clipping en PDF.
local function paginate_verbatim_blocks(text)
  local COL_WRAP_CHARS = 48
  local MAX_COL_LINES = 14

  local function estimate_line_cost(line)
    local raw = line:gsub("^%s+", ""):gsub("%s+$", "")
    if raw == "" then return 1 end
    local extra = 0
    if raw:match("^%s*[%-%*]%s+") then extra = extra + 1 end
    if raw:match("^%s*#+%s+") then extra = extra + 1 end
    if raw:match("^\\textbf%b{}%s*$") then extra = extra + 1 end
    local chars = #raw
    local wraps = math.max(1, math.ceil(chars / COL_WRAP_CHARS))
    return wraps + extra
  end

  local function estimate_block_cost(block)
    local cost = 0
    for line in (block .. "\n"):gmatch("([^\n]*)\n") do
      cost = cost + estimate_line_cost(line)
    end
    return cost
  end

  local function split_long_line(line)
    local words = {}
    for w in line:gmatch("%S+") do words[#words+1] = w end
    if #words == 0 then return {""} end
    local out = {}
    local cur = ""
    for _, w in ipairs(words) do
      local candidate = (cur == "") and w or (cur .. " " .. w)
      if #candidate > COL_WRAP_CHARS and cur ~= "" then
        out[#out+1] = cur
        cur = w
      else
        cur = candidate
      end
    end
    if cur ~= "" then out[#out+1] = cur end
    return out
  end

  local function split_block_to_fit(block)
    local chunks = {}
    local cur_lines = {}
    local cur_cost = 0

    local function flush_chunk()
      if #cur_lines > 0 then
        chunks[#chunks+1] = table.concat(cur_lines, "\n")
        cur_lines = {}
        cur_cost = 0
      end
    end

    for line in (block .. "\n"):gmatch("([^\n]*)\n") do
      local split_lines = split_long_line(line)
      for _, sl in ipairs(split_lines) do
        local lc = estimate_line_cost(sl)
        if cur_cost > 0 and (cur_cost + lc) > MAX_COL_LINES then
          flush_chunk()
        end
        cur_lines[#cur_lines+1] = sl
        cur_cost = cur_cost + lc
      end
    end
    flush_chunk()

    if #chunks == 0 then return {""} end
    return chunks
  end

  local blocks = split_markdown_blocks(text)
  if #blocks == 0 then return { { left = "", right = "" } } end

  -- Aplatir les blocs pour qu'aucun bloc ne puisse depasser une colonne.
  local fitted_blocks = {}
  for _, b in ipairs(blocks) do
    if estimate_block_cost(b) > MAX_COL_LINES then
      local pieces = split_block_to_fit(b)
      for _, p in ipairs(pieces) do fitted_blocks[#fitted_blocks+1] = p end
    else
      fitted_blocks[#fitted_blocks+1] = b
    end
  end

  local pages = {}
  local current_page = {
    left_parts = {}, right_parts = {}, left_cost = 0, right_cost = 0, side = "left"
  }

  local function flush_page()
    if #current_page.left_parts == 0 and #current_page.right_parts == 0 then return end
    pages[#pages+1] = {
      left = table.concat(current_page.left_parts, "\n\n"),
      right = table.concat(current_page.right_parts, "\n\n"),
    }
    current_page = {
      left_parts = {}, right_parts = {}, left_cost = 0, right_cost = 0, side = "left"
    }
  end

  local function push_left(block, cost)
    current_page.left_parts[#current_page.left_parts+1] = block
    current_page.left_cost = current_page.left_cost + cost
  end

  local function push_right(block, cost)
    current_page.right_parts[#current_page.right_parts+1] = block
    current_page.right_cost = current_page.right_cost + cost
  end

  for _, block in ipairs(fitted_blocks) do
    local cost = estimate_block_cost(block)
    local placed = false

    if current_page.side == "left" and (current_page.left_cost + cost) <= MAX_COL_LINES then
      push_left(block, cost)
      placed = true
    elseif current_page.side == "left" then
      current_page.side = "right"
    end

    if not placed and current_page.side == "right" and (current_page.right_cost + cost) <= MAX_COL_LINES then
      push_right(block, cost)
      placed = true
    end

    if not placed then
      flush_page()
      push_left(block, cost)
      current_page.side = "left"
    end
  end

  flush_page()
  if #pages == 0 then return { { left = "", right = "" } } end
  return pages
end

-- Fusion profonde de deux tables (override ecrase base)
local function deep_merge(base, override)
  if type(base) ~= "table" or type(override) ~= "table" then
    return override
  end
  local result = {}
  for k, v in pairs(base) do result[k] = v end
  for k, v in pairs(override) do
    if type(v) == "table" and type(result[k]) == "table" then
      result[k] = deep_merge(result[k], v)
    else
      result[k] = v
    end
  end
  return result
end

-- Detecter si un segment ressemble a du YAML
local function is_yaml_like(s)
  return s:match("^%s*[%a][%a%d%-_]*%s*:") ~= nil
end

-- Normaliser un code couleur hex : enlever le # et étendre les codes courts (3->6)
local function normalize_hex(raw)
  local hex = (raw or ""):gsub("^#", "")
  if #hex == 3 then
    hex = hex:sub(1,1):rep(2) .. hex:sub(2,2):rep(2) .. hex:sub(3,3):rep(2)
  end
  return hex
end

-- Determiner si un fond hex est sombre (utile pour la lisibilite du titre).
local function is_dark_hex(raw)
  local hex = normalize_hex(raw)
  if #hex ~= 6 then return false end
  local r = tonumber(hex:sub(1,2), 16) or 0
  local g = tonumber(hex:sub(3,4), 16) or 0
  local b = tonumber(hex:sub(5,6), 16) or 0
  -- Luminance percue (BT.601), seuil empirique.
  local y = (299 * r + 587 * g + 114 * b) / 1000
  return y < 140
end

-- Nettoyer la valeur brute d'un champ de chemin (prefixe @, espaces echappes)
local function clean_path_str(s)
  if type(s) ~= "string" then return s end
  return s:gsub("^@", ""):gsub("\\ ", " ")
end

-- Parser un YAML brut (apres nettoyage des artefacts IDE)
local function parse_yaml_str(s)
  s = s:gsub("@([./])", "%1"):gsub("\\ ", " ")
  local ok, data = pcall(tinyyaml.parse, s)
  if ok and type(data) == "table" then return data end
  return nil
end

-- Lire content.md et retourner la liste des variations
-- Chaque variation : { meta={}, body="" }
-- Le meta de la variation N est la fusion de tous les metas precedents.
local function parse_content_file(path)
  local fh  = assert(io.open(path, "r"), "Impossible d'ouvrir : " .. path)
  local raw = fh:read("*a")
  fh:close()

  -- Couper sur les lignes "---" seules
  local segments = {}
  local buf      = {}
  for line in (raw .. "\n"):gmatch("([^\n]*)\n") do
    if line == "---" then
      segments[#segments+1] = table.concat(buf, "\n")
      buf = {}
    else
      buf[#buf+1] = line
    end
  end
  if #buf > 0 then segments[#segments+1] = table.concat(buf, "\n") end

  -- Format ancien : pas de clé "diapo" => une seule variation, YAML flat
  -- Detecter en parsant le premier segment non-vide (segments[2])
  local first_yaml = segments[2] or ""
  local first_meta = parse_yaml_str(first_yaml) or {}

  if first_meta.diapo == nil then
    -- Format ancien : compatibilite
    local body = ""
    -- Le corps est tout ce qui suit le deuxieme "---"
    -- = segments[3] concatène le reste
    for i = 3, #segments do
      body = body .. (i > 3 and "\n---\n" or "") .. segments[i]
    end
    body = body:match("^%s*(.*%S)%s*$") or ""

    -- Normaliser les cles francaises
    local meta_norm = {}
    for k, v in pairs(first_meta) do
      local plain = k:gsub(" ",""):gsub("\195\169","e"):gsub("\195\168","e")
                     :gsub("\195\160","a"):gsub("\195\180","o"):gsub("\195\170","e")
      local canonical = FIELD_MAP[plain] or FIELD_MAP[k] or k:lower()
      meta_norm[canonical] = v
    end
    return {{ meta = meta_norm, body = body }}
  end

  -- Nouveau format : paires (yaml_segment, content_segment)
  -- segments[1] vide, segments[2..] alternent yaml/content
  local raw_variations = {}
  local i = 2
  while i <= #segments do
    local seg = segments[i]
    if is_yaml_like(seg) then
      local body = (segments[i+1] or ""):match("^%s*(.*%S)%s*$") or ""
      raw_variations[#raw_variations+1] = { yaml_raw = seg, body = body }
      i = i + 2
    else
      local body = seg:match("^%s*(.*%S)%s*$") or ""
      raw_variations[#raw_variations+1] = { yaml_raw = nil, body = body }
      i = i + 1
    end
  end

  -- Fusionner les metas en cascade
  local variations = {}
  local prev_meta  = {}
  for _, rv in ipairs(raw_variations) do
    local cur_meta = {}
    if rv.yaml_raw then
      cur_meta = parse_yaml_str(rv.yaml_raw) or {}
    end
    local merged = deep_merge(prev_meta, cur_meta)
    prev_meta = merged
    variations[#variations+1] = { meta = merged, body = rv.body }
  end
  return variations
end

local function resolve_asset(raw, root, workdir_assets)
  if type(raw) ~= "string" then return nil end
  raw = clean_path_str(raw)

  local function exists(p)
    local fh = io.open(p, "r")
    if fh then fh:close(); return true end
    return false
  end

  -- Ordre de recherche :
  -- 1. Chemin relatif a ROOT (ex. src/assets/logo.svg)
  -- 2. Nom de fichier dans src/assets/ (ex. logo.svg -> src/assets/logo.svg)
  -- 3. Retro-compat : .dev/assets/ -> assets/branding/
  local basename = raw:match("[^/\\]+$") or raw
  local candidates = {
    root .. "/" .. raw,
    root .. "/src/assets/" .. basename,
    root .. "/" .. raw:gsub("%.dev/assets/", "assets/branding/"),
  }

  local candidate
  for _, c in ipairs(candidates) do
    if exists(c) then candidate = c; break end
  end

  if not candidate then
    io.stderr:write("[WARN] Asset introuvable : " .. raw .. "\n")
    return nil
  end

  local ext  = (candidate:match("%.(%w+)$") or ""):lower()
  local stem = (candidate:match("([^/\\]+)%.[^%.]+$") or "file"):gsub("[^%w%.%-]", "_")

  if ext == "svg" then
    local target = workdir_assets .. "/" .. stem .. ".pdf"
    if not exists(target) then
      os.execute(string.format(
        "inkscape --export-type=pdf --export-filename=%q %q 2>/dev/null",
        target, candidate))
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

-- Lire un fichier verbatim.md : skipper le front matter YAML si present
local function read_verbatim_body(path)
  local fh = io.open(path, "r")
  if not fh then return "" end
  local s = fh:read("*a")
  fh:close()
  if s:match("^%-%-%-") then
    local front_end = s:find("\n%-%-%-", 4)
    if front_end then s = s:sub(front_end + 4) end
  end
  return s:match("^%s*(.*%S)%s*$") or ""
end

local function parse_height_cm(h)
  local n = tonumber((h or ""):match("([%d%.]+)cm"))
  return n or 1.1
end

local function format_logos(logo_items)
  if not logo_items or #logo_items == 0 then return "" end
  -- Hauteur maximale pour aligner toutes les baselines basses au même niveau.
  local max_h = 0
  for _, item in ipairs(logo_items) do
    local h = parse_height_cm(item.height)
    if h > max_h then max_h = h end
  end
  local max_h_str = string.format("%.4gcm", max_h)
  local items = {}
  for _, item in ipairs(logo_items) do
    local h = item.height or "1.1cm"
    items[#items+1] = string.format(
      "\\raisebox{0pt}[%s][0pt]{\\includegraphics[height=%s]{%s}}",
      max_h_str, h, item.path)
  end
  return table.concat(items, "\\hspace{1.5em}")
end

-- Construire le contexte etlua a partir de meta + body + config
local function build_ctx(meta, body, config, root, workdir_assets)
  -- Couche de base : config global
  local ctx = {}
  for k, v in pairs(config) do ctx[k] = v end

  -- Nouveau format : fusionner global-params, params, puis content
  if meta.diapo then
    local gparams = meta["global-params"] or {}
    local params  = meta.params            or {}
    local content = meta.content           or {}
    for k, v in pairs(gparams)  do ctx[k] = v end
    for k, v in pairs(params)   do ctx[k] = v end
    for k, v in pairs(content)  do ctx[k] = v end
    ctx["model"] = (meta.diapo or {}).model or config["default_model"] or "plain"
  else
    -- Format ancien : champs plats
    for k, v in pairs(meta) do ctx[k] = v end
  end

  -- Background : image en priorité, couleur de fond unie sinon
  local bg_raw = ctx["background"] or ctx["background-image"]
  if bg_raw and type(bg_raw) == "string" and bg_raw ~= "" then
    local bg_path = resolve_asset(clean_path_str(bg_raw), root, workdir_assets)
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
    -- Option de couleur de fond desactivee : pas de fond uni injecte.
    ctx["background_block"] = ""
  end

  -- Auteurs
  local authors = ctx["authors"] or {}
  if type(authors) == "string" then authors = { authors } end
  local auth_parts = {}
  for _, a in ipairs(authors) do
    if type(a) == "table" and (a.name or a.role) then
      local name = tex_escape(a.name or "")
      local role = tex_escape(a.role or "")
      if role ~= "" then
        auth_parts[#auth_parts+1] = "\\textbf{" .. name .. "} {\\footnotesize\\itshape " .. role .. "}"
      else
        auth_parts[#auth_parts+1] = name
      end
    else
      auth_parts[#auth_parts+1] = tex_escape(a)
    end
  end
  ctx["authors_formatted"] = table.concat(auth_parts, " \\\\[0.4em] ")

  -- Champs texte (tex_escape gere nil et yaml.null = table -> chaine vide)
  ctx["title_tex"]    = tex_escape(ctx["title"])
  ctx["subtitle_tex"] = tex_escape(ctx["subtitle"])
  ctx["event_tex"]    = tex_escape(ctx["event"])
  ctx["date_tex"]     = tex_escape(ctx["date"])
  ctx["demo_tex"]     = tex_escape(ctx["demo"])
  ctx["location_tex"] = tex_escape(ctx["location"])

  -- Logos
  local logos_raw = ctx["logos"] or {}
  local logo_items = {}
  for _, lr in ipairs(logos_raw) do
    local src_raw, height
    if type(lr) == "string" then
      src_raw = lr
    elseif type(lr) == "table" and lr.src then
      src_raw = lr.src
      height  = lr.height
    end
    if src_raw then
      local p = resolve_asset(clean_path_str(src_raw), root, workdir_assets)
      if p then logo_items[#logo_items+1] = { path = p, height = height } end
    end
  end
  ctx["logos_formatted"] = format_logos(logo_items)

  -- Options de couleur du titre desactivees.
  ctx["title_color_block"] = ""

  -- Corps Markdown
  ctx["content"] = render_body(body)

  return ctx
end

local function main()
  if #arg < 5 then
    print("Usage: texlua render_slide.lua <content.md> <config.yaml> <output.tex> <templates_dir> <workdir_assets> [<verbatim.md> <slide_num>]")
    os.exit(1)
  end

  local content_md, config_yaml, output_tex, templates_dir, workdir_assets =
    arg[1], arg[2], arg[3], arg[4], arg[5]
  local verbatim_md = arg[6]
  local slide_num   = arg[7] or ""

  local root = os.getenv("PRESENTATION_ROOT") or "."
  os.execute("mkdir -p " .. workdir_assets)

  -- Lire src/global-params.yaml comme couche de base (si present)
  local global_params = {}
  local gp_fh = io.open(root .. "/src/global-params.yaml", "r")
  if gp_fh then
    local gp_str = gp_fh:read("*a"); gp_fh:close()
    local gp_ok, gp_data = pcall(tinyyaml.parse, gp_str)
    if gp_ok and type(gp_data) == "table" then global_params = gp_data end
  end

  -- Lire config.yaml et le fusionner par-dessus global-params
  local fh = assert(io.open(config_yaml, "r"))
  local config_str = fh:read("*a"); fh:close()
  local ok, config_raw = pcall(tinyyaml.parse, config_str)
  if not ok then config_raw = {} end
  local config = deep_merge(global_params, config_raw or {})

  -- Cache des gabarits
  local tpl_cache = {}
  local function load_template(model)
    if tpl_cache[model] then return tpl_cache[model] end
    local tpl_path = templates_dir .. "/models/" .. model .. ".tex"
    local fh2 = assert(io.open(tpl_path, "r"), "Gabarit introuvable : " .. tpl_path)
    local tpl = fh2:read("*a"); fh2:close()
    tpl_cache[model] = tpl
    return tpl
  end

  local frames = {}

  if verbatim_md then
    -- Mode verbatim : titre extrait du content.md, corps lu depuis verbatim.md
    local variations = parse_content_file(content_md)
    local first_meta = (variations[1] or { meta = {} }).meta
    local vbody      = read_verbatim_body(verbatim_md)
    local ctx        = build_ctx(first_meta, vbody, config, root, workdir_assets)
    ctx["slide_num"] = tex_escape(slide_num)
    local tpl        = load_template("verbatim")
    local compiled   = assert(etlua.compile(tpl))
    frames[#frames+1] = compiled(ctx)
  else
    -- Mode normal : rendre chaque variation du slide
    local variations = parse_content_file(content_md)
    for _, var in ipairs(variations) do
      local model = ((var.meta.diapo or {}).model)
                 or var.meta["model"]
                 or config["default_model"]
                 or "plain"
      local ctx   = build_ctx(var.meta, var.body, config, root, workdir_assets)
      local tpl   = load_template(model)
      local compiled = assert(etlua.compile(tpl))
      frames[#frames+1] = compiled(ctx)
    end
  end

  -- Ecrire le .tex de sortie
  local out_dir = output_tex:match("(.*[/\\])")
  if out_dir then os.execute("mkdir -p " .. out_dir) end
  local fh3 = assert(io.open(output_tex, "w"))
  fh3:write(table.concat(frames, "\n"))
  fh3:close()
  io.write("[OK] " .. output_tex .. "\n")
end

main()
