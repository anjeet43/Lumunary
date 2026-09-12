"""SQLAlchemy persistence foundation. API demo uses deterministic in-memory seed data.
Replace DemoStore with repositories backed by these models when provisioning Postgres."""
from datetime import datetime
from sqlalchemy import DateTime, Float, ForeignKey, Integer, String, Text, create_engine
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from app.core.config import settings

class Base(DeclarativeBase): pass
class Timestamped:
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
class User(Timestamped, Base):
    __tablename__="users"; id:Mapped[str]=mapped_column(String,primary_key=True); phone:Mapped[str]=mapped_column(String,unique=True,index=True); password_hash:Mapped[str]=mapped_column(String); role:Mapped[str]=mapped_column(String,default="ARTISAN")
class ArtisanProfile(Timestamped, Base):
    __tablename__="artisan_profiles"; id:Mapped[str]=mapped_column(String,primary_key=True); user_id:Mapped[str]=mapped_column(ForeignKey("users.id")); name:Mapped[str]=mapped_column(String); craft:Mapped[str]=mapped_column(String); state:Mapped[str]=mapped_column(String); district:Mapped[str]=mapped_column(String); cluster:Mapped[str|None]=mapped_column(String,nullable=True)
class Product(Timestamped, Base):
    __tablename__="products"; id:Mapped[str]=mapped_column(String,primary_key=True); artisan_id:Mapped[str]=mapped_column(ForeignKey("artisan_profiles.id")); title:Mapped[str]=mapped_column(String,index=True); status:Mapped[str]=mapped_column(String,index=True); price:Mapped[float]=mapped_column(Float); quantity:Mapped[int]=mapped_column(Integer)
class ProductImage(Timestamped, Base):
    __tablename__="product_images"; id:Mapped[str]=mapped_column(String,primary_key=True); product_id:Mapped[str]=mapped_column(ForeignKey("products.id")); url:Mapped[str]=mapped_column(String); mime_type:Mapped[str]=mapped_column(String)
class ProductAttribute(Timestamped, Base):
    __tablename__="product_attributes"; id:Mapped[str]=mapped_column(String,primary_key=True); product_id:Mapped[str]=mapped_column(ForeignKey("products.id")); name:Mapped[str]=mapped_column(String); value:Mapped[str]=mapped_column(String); confidence:Mapped[float]=mapped_column(Float)
class ProductDescription(Timestamped, Base):
    __tablename__="product_descriptions"; id:Mapped[str]=mapped_column(String,primary_key=True); product_id:Mapped[str]=mapped_column(ForeignKey("products.id")); locale:Mapped[str]=mapped_column(String); body:Mapped[str]=mapped_column(Text); source:Mapped[str]=mapped_column(String)
class ProductProvenance(Timestamped, Base):
    __tablename__="product_provenance"; id:Mapped[str]=mapped_column(String,primary_key=True); product_id:Mapped[str]=mapped_column(ForeignKey("products.id")); source_type:Mapped[str]=mapped_column(String); source_reference:Mapped[str]=mapped_column(String); verified:Mapped[bool]=mapped_column(default=False); artisan_confirmed:Mapped[bool]=mapped_column(default=False)
class PricingResult(Timestamped, Base):
    __tablename__="pricing_results"; id:Mapped[str]=mapped_column(String,primary_key=True); product_id:Mapped[str]=mapped_column(ForeignKey("products.id")); recommended_price:Mapped[float]=mapped_column(Float); explanation:Mapped[str]=mapped_column(Text); confidence:Mapped[float]=mapped_column(Float)
class MarketSignal(Timestamped, Base):
    __tablename__="market_signals"; id:Mapped[str]=mapped_column(String,primary_key=True); craft:Mapped[str]=mapped_column(String); demand:Mapped[str]=mapped_column(String); source:Mapped[str]=mapped_column(String); freshness:Mapped[str]=mapped_column(String)
class Buyer(Timestamped, Base):
    __tablename__="buyers"; id:Mapped[str]=mapped_column(String,primary_key=True); name:Mapped[str]=mapped_column(String); location:Mapped[str]=mapped_column(String)
class BuyerRequestModel(Timestamped, Base):
    __tablename__="buyer_requests"; id:Mapped[str]=mapped_column(String,primary_key=True); buyer_id:Mapped[str]=mapped_column(ForeignKey("buyers.id")); craft:Mapped[str]=mapped_column(String); quantity:Mapped[int]=mapped_column(Integer); budget_min:Mapped[float]=mapped_column(Float); budget_max:Mapped[float]=mapped_column(Float)
class Match(Timestamped, Base):
    __tablename__="matches"; id:Mapped[str]=mapped_column(String,primary_key=True); request_id:Mapped[str]=mapped_column(ForeignKey("buyer_requests.id")); score:Mapped[float]=mapped_column(Float); capacity:Mapped[int]=mapped_column(Integer)
class Order(Timestamped, Base):
    __tablename__="orders"; id:Mapped[str]=mapped_column(String,primary_key=True); buyer_id:Mapped[str]=mapped_column(ForeignKey("buyers.id")); status:Mapped[str]=mapped_column(String); total:Mapped[float]=mapped_column(Float)
class OrderItem(Timestamped, Base):
    __tablename__="order_items"; id:Mapped[str]=mapped_column(String,primary_key=True); order_id:Mapped[str]=mapped_column(ForeignKey("orders.id")); product_id:Mapped[str]=mapped_column(ForeignKey("products.id")); quantity:Mapped[int]=mapped_column(Integer)
class OrderEvent(Timestamped, Base):
    __tablename__="order_events"; id:Mapped[str]=mapped_column(String,primary_key=True); order_id:Mapped[str]=mapped_column(ForeignKey("orders.id")); status:Mapped[str]=mapped_column(String); note:Mapped[str]=mapped_column(Text)
class SyncRecordModel(Timestamped, Base):
    __tablename__="sync_records"; id:Mapped[str]=mapped_column(String,primary_key=True); local_id:Mapped[str]=mapped_column(String,index=True); server_id:Mapped[str|None]=mapped_column(String,nullable=True); sync_status:Mapped[str]=mapped_column(String); device_id:Mapped[str]=mapped_column(String)
class AuditLog(Timestamped, Base):
    __tablename__="audit_logs"; id:Mapped[str]=mapped_column(String,primary_key=True); actor_id:Mapped[str]=mapped_column(String); action:Mapped[str]=mapped_column(String); detail:Mapped[str]=mapped_column(Text)

def initialize_database():
    engine=create_engine(settings.database_url); Base.metadata.create_all(engine); return engine
