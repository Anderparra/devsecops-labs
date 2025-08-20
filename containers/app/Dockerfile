# Multi-stage build for a minimal, non-root image
FROM python:3.11-slim AS builder

# Install build deps (if needed) and create venv
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN python -m venv /opt/venv && /opt/venv/bin/pip install --upgrade pip && /opt/venv/bin/pip install -r requirements.txt

FROM python:3.11-slim AS runtime
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"
WORKDIR /app

# Create non-root user
RUN useradd -m -u 10001 appuser
USER appuser

# Copy venv and app
COPY --from=builder /opt/venv /opt/venv
COPY --chown=appuser:appuser . /app

EXPOSE 5000

# Healthcheck for demo
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import socket; s=socket.socket(); s.connect(('127.0.0.1',5000)); s.close()"

# Use gunicorn in container; suitable for demo
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
