#!/usr/bin/env python3
"""
Hook de Claude Code — verifica que no haya secretos en archivos staged antes de commit.
Se ejecuta en el evento Stop.
"""

import subprocess
import re
import sys
import os

# Patrones de secretos a detectar
SECRET_PATTERNS = [
    (r'AKIA[0-9A-Z]{16}', 'AWS Access Key'),
    (r'(?i)(password|passwd|secret|api_key|apikey)\s*[=:]\s*["\'][^"\']{8,}["\']', 'Credencial hardcodeada'),
    (r'ghp_[A-Za-z0-9]{36}', 'GitHub Personal Token'),
    (r'gho_[A-Za-z0-9]{36}', 'GitHub OAuth Token'),
    (r'github_pat_[A-Za-z0-9_]{82}', 'GitHub Fine-grained Token'),
    (r'sk-[A-Za-z0-9]{32,}', 'API Secret Key (OpenAI/Anthropic style)'),
    (r'sk-ant-[A-Za-z0-9\-_]{90,}', 'Anthropic API Key'),
    (r'xoxb-[A-Za-z0-9\-]+', 'Slack Bot Token'),
    (r'xoxp-[A-Za-z0-9\-]+', 'Slack User Token'),
    (r'sk_live_[A-Za-z0-9]{24,}', 'Stripe Live Secret Key'),
    (r'-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----', 'Clave privada PEM'),
]

# Extensiones a ignorar (binarios)
SKIP_EXTENSIONS = {'.png', '.jpg', '.jpeg', '.gif', '.pdf', '.zip', '.tar',
                   '.gz', '.exe', '.dll', '.so', '.lock', '.woff', '.woff2'}

def check_staged_files():
    """Revisa archivos staged en git por posibles secretos."""
    try:
        # Verificar si estamos en un repo git
        result = subprocess.run(
            ['git', 'rev-parse', '--is-inside-work-tree'],
            capture_output=True, text=True
        )
        if result.returncode != 0:
            return  # No es un repo git, ignorar

        # Obtener archivos staged
        result = subprocess.run(
            ['git', 'diff', '--cached', '--name-only'],
            capture_output=True, text=True
        )
        if result.returncode != 0 or not result.stdout.strip():
            return  # Sin archivos staged

        staged_files = [f for f in result.stdout.strip().split('\n') if f]
        found_secrets = []

        for file_path in staged_files:
            # Saltar binarios
            ext = os.path.splitext(file_path)[1].lower()
            if ext in SKIP_EXTENSIONS:
                continue

            # Alerta especial para .env
            if os.path.basename(file_path) == '.env':
                found_secrets.append(f"  ⛔ Archivo .env detectado en staged: {file_path}")
                continue

            # Leer contenido staged del archivo
            try:
                diff_result = subprocess.run(
                    ['git', 'show', f':{file_path}'],
                    capture_output=True, text=True, timeout=5
                )
                content = diff_result.stdout
            except (subprocess.TimeoutExpired, Exception):
                continue

            # Buscar patrones de secretos
            for pattern, label in SECRET_PATTERNS:
                matches = re.findall(pattern, content)
                if matches:
                    found_secrets.append(f"  ⚠️  {label} en {file_path}")
                    break  # Un aviso por archivo es suficiente

        if found_secrets:
            print("\n" + "="*60)
            print("⚠️  CLAUDE CODE — ADVERTENCIA DE SEGURIDAD")
            print("="*60)
            print("Posibles secretos detectados en archivos staged para commit:")
            for s in found_secrets:
                print(s)
            print("\n¿Estás seguro de que quieres hacer commit con estos archivos?")
            print("Revísalos antes de continuar.")
            print("="*60 + "\n")
            sys.exit(1)  # Warning pero no bloquea (exit 1)

    except FileNotFoundError:
        pass  # git no instalado, ignorar
    except Exception:
        pass  # No interrumpir el flujo por errores del hook

if __name__ == '__main__':
    check_staged_files()
    sys.exit(0)
