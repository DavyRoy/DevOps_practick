FROM python:3.12-alpine
WORKDIR /app
COPY . .
RUN pip install fastapi uvicorn[standard] "python-multipart" "aiofiles" "requests" "jinja2" "pydantic" "httpx" "starlette" "uvicorn"
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]