# CRM de turnos — Dr. Omar Cano
# Sirve el HTML estático con nginx y hace de proxy hacia el webhook de n8n,
# para que el navegador vea todo bajo el mismo origen y no haga falta CORS.

FROM nginx:alpine

# Se copia SOLO lo que es web. La carpeta del proyecto tiene documentos
# internos (CLAUDE.md, el PDF de presentación, .claude/, skill-creator/) que
# no deben quedar publicados: por eso la lista es explícita en vez de "COPY . .".
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
