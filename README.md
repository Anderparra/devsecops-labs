# DevSecOps Labs (Starter)

Repositorio público de ejemplo para demostrar prácticas DevSecOps **sin exponer información sensible**.
Incluye automatización de seguridad en CI/CD, buenas prácticas de contenedores, ejemplos de IaC
y scripts de auditoría. Puedes usarlo como portafolio técnico.

## Contenido

```
.
├─ .github/workflows/security-pipeline.yml   # Pipeline con SAST (Semgrep) y análisis con Trivy (código, IaC y contenedor)
├─ containers/app/                           # App mínima para demostrar build/scan de imagen
├─ docs/                                     # Guías y documentación
├─ iac/                                      # Infraestructura como código (Terraform) para demostraciones
├─ monitoring/wazuh/                         # Reglas de ejemplo para Wazuh/OSSEC
├─ scripts/                                  # Utilidades de seguridad (secret scanning básico, hardening checks)
├─ SECURITY.md                               
└─ CONTRIBUTING.md
```

> ⚠️ **Importante**: Este repo está diseñado para demostraciones. No contiene datos de clientes ni secretos reales.

## Cómo usarlo

1. **Crea un nuevo repositorio en GitHub** (público recomendado para que Code Scanning funcione gratuitamente).
2. Descarga el ZIP desde el enlace que te compartiré debajo, descomprímelo y sube los archivos a tu repo.
3. Confirma que el workflow en `.github/workflows/security-pipeline.yml` está activo.
4. (Opcional) En *Settings → Code security & analysis*, habilita:
   - **Code scanning** (Default setup) — CodeQL
   - **Secret scanning** y **Push Protection** (en repos públicos suele ser gratis)
5. Abre un Pull Request: el pipeline correrá SAST (Semgrep) y **Trivy** (código/archivos/IaC y contenedor).

## Demostraciones incluidas

- **SAST con Semgrep** sobre el código de ejemplo.
- **Trivy**:
  - `fs` (análisis de archivos, dependencias y configuraciones → IaC).
  - `image` (escaneo de la imagen Docker construida desde `containers/app/`).
- **Buenas prácticas en Docker**: usuario no-root, multi-stage, dependencias fijadas.
- **IaC para *scanning***: archivo Terraform **intencionalmente inseguro** para gatillar findings (marcado como demo).
- **Scripts de seguridad**: detección simple de secretos y verificación de configuración básica en Linux.

## Requisitos locales (opcional)

- Docker 24+ si quieres construir la imagen localmente.
- Python 3.11+ si quieres ejecutar la app de ejemplo.

## Ejecución local de la app

```bash
cd containers/app
pip install -r requirements.txt
python app.py
# http://127.0.0.1:5000
```

### Build y ejecución con Docker

```bash
cd containers/app
docker build -t demoapp:latest -f Dockerfile .
docker run --rm -p 5000:5000 demoapp:latest
```

## Nota sobre el Terraform de ejemplo

En `iac/terraform/aws/insecure_sg.tf` hay un Security Group **intencionalmente permisivo** (22/tcp abierto a Internet) para que herramientas
de análisis lo detecten. **No lo apliques en cuentas reales**. Sirve solo para *demos* de detección.

## Siguiente paso sugerido

- Agrega más PoCs (tu estilo personal), por ejemplo:
  - Pipelines con *matrix* por lenguaje.
  - Integración con Wazuh/OSSEC en un laboratorio local.
  - Ejemplos de *policy as code* (OPA/Conftest).
- Usa issues y PRs para mostrar tu flujo de trabajo profesional.

---

© 2025 Tu Nombre. Licencia MIT.
