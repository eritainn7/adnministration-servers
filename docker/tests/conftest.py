import os
import sys
import pytest_asyncio
from httpx import AsyncClient, ASGITransport
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker

# Добавляем корневую директорию в PYTHONPATH
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.main import app
from src.models import User
from src.database import Base

# Используем переменную окружения для тестов
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql+psycopg://kubsu:kubsu@postgres:5432/kubsu")

# Создаем отдельный engine для тестов
test_engine = create_async_engine(DATABASE_URL, echo=True)
TestAsyncSessionLocal = sessionmaker(
    bind=test_engine, 
    class_=AsyncSession, 
    expire_on_commit=False
)


@pytest_asyncio.fixture(scope="session", autouse=True)
async def setup_database():
    """Создание таблиц перед запуском всех тестов"""
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    # Очистка после всех тестов
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
    await test_engine.dispose()


@pytest_asyncio.fixture(scope='function')
async def db(setup_database):
    """Фикстура для сессии БД"""
    async with TestAsyncSessionLocal() as session:
        # Очищаем таблицу перед каждым тестом
        await session.execute(text("TRUNCATE TABLE users RESTART IDENTITY CASCADE;"))
        await session.commit()
        
        yield session
        
        # Откатываем любые незакоммиченные изменения
        await session.rollback()


@pytest_asyncio.fixture(scope="session")
async def test_client():
    """Фикстура для HTTP клиента"""
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
        yield client


@pytest_asyncio.fixture
async def user(db: AsyncSession):
    """Фикстура для создания тестового пользователя"""
    user = User(name="John Doe")
    db.add(user)
    await db.commit()
    await db.refresh(user)
    return user