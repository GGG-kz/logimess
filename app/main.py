from fastapi import FastAPI
from app.api import auth

app = FastAPI(title="Logimess API")

app.include_router(auth.router)  # ← Подключаем маршруты авторизации

@app.get("/")
async def root():
    return {"message": "Добро пожаловать в Logimess!"}
