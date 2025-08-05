from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_sessionmaker,
    create_async_engine
)
from sqlalchemy.orm import declarative_base
from typing import AsyncGenerator
from app.core.config import settings  # Импортируем настройки

# Получаем строку подключения из settings (собирается из частей)
DATABASE_URL = settings.database_url

# Создание асинхронного движка и сессии
engine = create_async_engine(DATABASE_URL, echo=True)
async_session = async_sessionmaker(engine, expire_on_commit=False)

# Базовый класс для всех моделей
Base = declarative_base()

# Зависимость для FastAPI — выдаёт асинхронную сессию
async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with async_session() as session:
        yield session
