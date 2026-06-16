# "problème" des images de base docker pour demo PQC

- ils sont minimales (presque rien d'installé)
- ils ne sont configurés

# cbomkit-theia

## problèmes

- plante si exécuté sur images locales... problablement à cause de ma mauvaise config de docker...

### échec sur odoo

```sh
$ docker run --rm -v ${PWD}/sbom.json:/data/sbom.json  cbomkit-theia image --bom /data/sbom.json -p certificates,javasecurity,secrets,opensslconf,problematicca odoo:latest | tee -a cbom.json | jq .
time="2026-06-16T06:01:47Z" level=info msg="try to fetch image odoo:latest ..."
time="2026-06-16T06:03:23Z" level=info msg="successfully loaded image odoo:latest with id bdfb46877431666c2ce3209923239c8fd8081bd329e9cc2ecc7fcbef0a3dd4fc"
time="2026-06-16T06:03:23Z" level=info msg="=> Running Certificate File Plugin"
time="2026-06-16T06:03:25Z" level=error msg="could not scan image: plugin (Certificate File Plugin) failed to updated components of bom; max allowable directory traversal depth reached (maybe a link cycle?)"
```