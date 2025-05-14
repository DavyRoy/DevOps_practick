import redis
from fastapi import FastAPI

app = FastAPI()
r = redis.Redis(host="redis", port=6379)

@app.get("/")
def root():
    r.set("status", "ok")
    return {"status": r.get("status").decode()}