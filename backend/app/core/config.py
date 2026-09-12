from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    database_url: str = "sqlite:///./luminary.db"
    jwt_secret: str = "demo-secret-change-me"
    ai_provider_mode: str = "mock"
    commerce_mode: str = "demo"
    demo_mode: bool = True
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")


settings = Settings()
