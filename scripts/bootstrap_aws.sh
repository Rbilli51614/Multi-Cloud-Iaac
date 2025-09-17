#!/usr/bin/env bash
set -euo pipefail
sudo yum update -y || true
sudo amazon-linux-extras install nginx1 -y || sudo yum install -y nginx
cat <<'HTML' | sudo tee /usr/share/nginx/html/index.html
<!doctype html>
<html><head><title>AWS</title></head>
<body style="font-family:Arial; margin:2rem">
  <h1>Hello from AWS (EC2 + ALB)</h1>
  <p>If you see this, your AWS stack is up.</p>
</body></html>
HTML
sudo systemctl enable nginx
sudo systemctl restart nginx
