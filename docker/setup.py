# setup.py
from setuptools import setup, find_packages

setup(
    name="KubSU",
    version="0.1.0",
    packages=find_packages(),
    python_requires=">=3.10",
    install_requires=[
        "fastapi==0.115.8",
        "uvicorn==0.34.0",
        "sqlalchemy==2.0.37",
        "psycopg-binary==3.2.4",
        "psycopg==3.2.4"
    ],
    extras_require={
        "test": [
            "pytest>=6.2.5",
            "pytest-asyncio==0.25.3",
            "httpx==0.28.1"
        ]
    },
)