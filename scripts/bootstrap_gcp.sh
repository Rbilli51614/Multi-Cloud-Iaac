#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update -y
sudo apt-get install -y nginx
cat <<'HTML' | sudo tee /var/www/html/index.nginx-debian.html
<!doctype html>
<html><head><title>GCP</title></head>
<body style="font-family:Arial; margin:2rem">
  <h1>Hello from GCP (GCE + HTTP LB)</h1>
  <p>If you see this, your GCP stack is up.</p>
</body></html>
HTML
sudo systemctl enable nginx
sudo systemctl restart nginx
