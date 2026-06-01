FROM python:3.12-slim

WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Копируем файлы с зависимостями
COPY pyproject.toml setup.py* ./

# Устанавливаем зависимости (включая тестовые)
RUN pip install --no-cache-dir .[test]

# Копируем исходный код
COPY src/ ./src/
COPY tests/ ./tests/

# Устанавливаем PYTHONPATH
ENV PYTHONPATH=/app

# Открываем порт
EXPOSE 8000

# Команда для запуска приложения (переопределяется в docker-compose)
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]