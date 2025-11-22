"""
Aplicação com CREDENCIAIS EXPOSTAS - NUNCA FAÇA ISSO!
Este código contém vulnerabilidades intencionais para fins educacionais.
"""

import boto3
import requests
from flask import Flask, jsonify

app = Flask(__name__)

# VULNERABILIDADE 1: AWS Credentials hardcoded
AWS_ACCESS_KEY = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
AWS_REGION = "us-east-1"

# VULNERABILIDADE 2: API Keys expostas
GITHUB_TOKEN = "ghp_1234567890abcdefghijklmnopqrstuvwxyz"
STRIPE_SECRET_KEY = "sk_test_51JabcdefghijklmnopqrstuvwxyzABCDEF"
OPENAI_API_KEY = "sk-proj-abcdefghijklmnopqrstuvwxyz1234567890"

# VULNERABILIDADE 3: Database credentials
DB_CONNECTION = "postgresql://admin:P@ssw0rd123!@database.example.com:5432/production"

# VULNERABILIDADE 4: Private Key
PRIVATE_KEY = """-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA1234567890abcdefghijklmnopqrstuvwxyz
-----END RSA PRIVATE KEY-----"""

VULNERABILIDADE 5: JWT Secret
JWT_SECRET = "super-secret-jwt-key-never-commit-this-12345"

# Configurar cliente AWS com credenciais expostas
s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY,
    aws_secret_access_key=AWS_SECRET_KEY,
    region_name=AWS_REGION
)

@app.route('/health')
def health():
    return jsonify({"status": "running"})

@app.route('/config')
def show_config():
    """Endpoint que expõe configurações - NUNCA FAÇA ISSO!"""
    return jsonify({
        "aws_key": AWS_ACCESS_KEY,
        "database": DB_CONNECTION,
        "api_keys": {
            "github": GITHUB_TOKEN,
            "stripe": STRIPE_SECRET_KEY
        }
    })

@app.route('/upload', methods=['POST'])
def upload_to_s3():
    # Usa credenciais expostas
    try:
        s3_client.upload_file('test.txt', 'my-bucket', 'test.txt')
        return jsonify({"message": "Upload successful"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
