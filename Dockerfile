FROM python:3.9-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

FROM python:3.9-slim
ENV REDIS_HOST redis
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 5000
RUN pip install flask Werkzeug redis prometheus_client 
ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
