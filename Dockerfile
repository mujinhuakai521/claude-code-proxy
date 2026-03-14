FROM python:latest

RUN apt-get update && apt-get install -y rustc cargo && rm -rf /var/lib/apt/lists/*

WORKDIR /claude-code-proxy

COPY pyproject.toml uv.lock ./

RUN pip install --upgrade uv && uv sync

COPY . .

EXPOSE 8082
CMD uv run uvicorn server:app --host 0.0.0.0 --port 8082 --reload
