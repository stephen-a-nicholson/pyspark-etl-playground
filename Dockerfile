FROM python:3.12-slim-bookworm

WORKDIR /app/

RUN apt-get update && \
    apt-get install -y \
    curl \
    gcc \
    && rm -rf /var/lib/apt/lists/* && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

COPY ./pyproject.toml ./uv.lock /app/

ARG INSTALL_DEV=false

RUN if [ "$INSTALL_DEV" = "true" ] ; then \
        uv pip compile pyproject.toml --all-extras -o requirements.txt && \
        uv pip install -r requirements.txt ; \
    else \
        uv pip compile pyproject.toml -o requirements.txt && \
        uv pip install -r requirements.txt ; \
    fi

ENV PYTHONPATH=/app