# Guía rápida: Pipeline de seguridad

Este pipeline ejecuta:
- **Semgrep** (SAST) con el ruleset `p/ci`.
- **Trivy** en modo filesystem (código, dependencias, licencias y configuraciones incluyendo IaC).
- **Trivy** sobre la imagen Docker construida desde `containers/app/`.
- Publica resultados en **Security → Code scanning alerts** como archivos SARIF.

## Recomendaciones adicionales

- Habilita **CodeQL (Default setup)** en *Security & analysis* del repo.
- Activa **Secret scanning** y **Push Protection**.
- Configura **Branch protection rules** para `main`:
  - Requerir PRs y checks verdes.
  - Requerir que el workflow de seguridad pase.
  - Firmado de commits (opcional).
