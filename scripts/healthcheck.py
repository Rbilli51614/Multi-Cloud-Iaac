#!/usr/bin/env python3
import argparse, sys, urllib.request

def hit(url):
    try:
        with urllib.request.urlopen(url, timeout=10) as r:
            body = r.read(2000).decode(errors="ignore")
            return r.status, body
    except Exception as e:
        return None, str(e)

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("--aws", help="AWS ALB DNS name (no scheme)")
    p.add_argument("--gcp", help="GCP LB IP or domain (no scheme)")
    args = p.parse_args()

    ok = True
    if args.aws:
        s,b = hit(f"http://{args.aws}")
        print("[AWS]", s, "OK" if (s and s<400) else "FAIL")
        if not s or s>=400: ok=False
    if args.gcp:
        s,b = hit(f"http://{args.gcp}")
        print("[GCP]", s, "OK" if (s and s<400) else "FAIL")
        if not s or s>=400: ok=False
    sys.exit(0 if ok else 1)
