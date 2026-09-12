from datetime import date, datetime
from enum import Enum
from pydantic import BaseModel, Field


class ProductStatus(str, Enum):
    draft = "DRAFT"
    active = "ACTIVE"
    archived = "ARCHIVED"


class OrderStatus(str, Enum):
    new = "NEW"
    confirmed = "CONFIRMED"
    production = "IN_PRODUCTION"
    ready = "READY"
    packed = "PACKED"
    dispatched = "DISPATCHED"
    delivered = "DELIVERED"
    completed = "COMPLETED"


class RegisterRequest(BaseModel):
    name: str = Field(min_length=2, max_length=100)
    phone: str = Field(min_length=8, max_length=20)
    password: str = Field(min_length=8, max_length=128)
    craft: str = Field(default="Bandhani", max_length=80)
    state: str = Field(default="Gujarat", max_length=80)
    district: str = Field(default="Kutch", max_length=80)
    preferred_language: str = "en"


class LoginRequest(BaseModel):
    phone: str
    password: str


class UserResponse(BaseModel):
    id: str
    name: str
    phone: str
    craft: str
    state: str
    district: str
    preferred_language: str


class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserResponse


class ImageAssessment(BaseModel):
    background: int
    lighting: int
    sharpness: int
    framing: int
    readiness: int
    enhancement_label: str = "AI-assisted demo enhancement"


class ExtractedField(BaseModel):
    value: str
    confidence: float = Field(ge=0, le=1)
    source: str = "AI-assisted"


class CatalogExtraction(BaseModel):
    title: ExtractedField
    craft: ExtractedField
    category: ExtractedField
    material: ExtractedField
    color: ExtractedField
    dimensions: ExtractedField
    time_to_make: ExtractedField
    care: ExtractedField


class CatalogContent(BaseModel):
    title_en: str
    title_hi: str
    description_en: str
    description_hi: str
    summary: str
    tags: list[str]
    generated_label: str = "AI-assisted draft — please review"


class PriceRequest(BaseModel):
    material_cost: float = Field(ge=0)
    labour_hours: float = Field(ge=0)
    labour_rate: float = Field(ge=0)
    overhead: float = Field(ge=0)
    packaging_cost: float = Field(ge=0)
    transaction_cost: float = Field(default=0, ge=0)
    target_margin: float = Field(default=.25, ge=0, le=1)
    observed_market_min: float | None = Field(default=None, ge=0)
    observed_market_max: float | None = Field(default=None, ge=0)
    demand_score: float = Field(default=.5, ge=0, le=1)


class PriceResult(BaseModel):
    total_cost: float
    sustainable_floor: float
    market_low: float | None
    market_high: float | None
    recommended_price: float
    confidence: float
    data_freshness: str
    source: str
    reasons: list[str]


class ProductCreate(BaseModel):
    title: str = Field(min_length=2, max_length=160)
    craft: str
    category: str
    material: str
    color: str
    dimensions: str
    description_en: str
    description_hi: str = ""
    price: float = Field(ge=0)
    quantity: int = Field(default=1, ge=0)
    image_url: str = "/assets/demo-bandhani.jpg"
    ai_assisted: bool = True


class ProductResponse(ProductCreate):
    id: str
    status: ProductStatus
    artisan_name: str
    created_at: datetime


class MatchResponse(BaseModel):
    request_id: str
    craft: str
    match_score: int
    artisans: int
    available_capacity: int
    eta_days: int
    average_price: float
    source: str = "Demo matching engine"


class BuyerRequest(BaseModel):
    craft: str
    quantity: int = Field(gt=0)
    budget_min: float = Field(ge=0)
    budget_max: float = Field(ge=0)
    deadline: date
    location: str


class OrderResponse(BaseModel):
    id: str
    buyer: str
    product: str
    quantity: int
    total: float
    expected_date: date
    status: OrderStatus
    payment_status: str
    shipment_status: str

