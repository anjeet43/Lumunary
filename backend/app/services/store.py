from datetime import date, datetime, timedelta, timezone
from uuid import uuid4
import base64
import hashlib
import hmac
import os
from app.schemas.contracts import BuyerRequest, OrderResponse, OrderStatus, ProductCreate, ProductResponse, ProductStatus, UserResponse

def hash_password(password: str) -> str:
    """Portable scrypt password hashing; no passwords are persisted as plaintext."""
    salt = os.urandom(16)
    digest = hashlib.scrypt(password.encode(), salt=salt, n=2**14, r=8, p=1)
    return f"scrypt${base64.b64encode(salt).decode()}${base64.b64encode(digest).decode()}"


def verify_password(password: str, encoded: str) -> bool:
    algorithm, salt_b64, digest_b64 = encoded.split("$", 2)
    if algorithm != "scrypt":
        return False
    expected = base64.b64decode(digest_b64)
    actual = hashlib.scrypt(password.encode(), salt=base64.b64decode(salt_b64), n=2**14, r=8, p=1)
    return hmac.compare_digest(actual, expected)

class DemoStore:
    def __init__(self):
        self.users = {}
        self.products = {}
        self.orders = {}
        self.seed()
    def seed(self):
        user = {"id":"artisan-ramesh", "name":"Ramesh Kumar", "phone":"9999999999", "password":hash_password("luminary-demo"), "craft":"Bandhani", "state":"Gujarat", "district":"Kutch", "preferred_language":"hi"}
        self.users[user["phone"]] = user
        for title, craft, material, price in [("Bandhani Silk Dupatta","Bandhani","Silk",2399),("Handcrafted Wall Hanging","Textile Art","Cotton",1299),("Traditional Textile","Bandhani","Cotton",899)]:
            ident=str(uuid4()); self.products[ident] = ProductResponse(id=ident,title=title,craft=craft,category="Textiles",material=material,color="Red",dimensions="2.2 m",description_en="Artisan-made demo product.",description_hi="कारीगर द्वारा बनाया गया डेमो उत्पाद।",price=price,quantity=12,image_url="/assets/demo-bandhani.jpg",ai_assisted=True,status=ProductStatus.active,artisan_name="Ramesh Kumar",created_at=datetime.now(timezone.utc))
        self.orders["ORD-102"] = OrderResponse(id="ORD-102",buyer="Heritage Retail Buyer",product="Bandhani Silk Dupatta",quantity=50,total=119950,expected_date=date.today()+timedelta(days=18),status=OrderStatus.confirmed,payment_status="Pending",shipment_status="Not dispatched")
    def user_response(self, item): return UserResponse(**{key:item[key] for key in UserResponse.model_fields})
    def register(self, data):
        if data.phone in self.users: raise ValueError("An account with this phone already exists")
        item={"id":str(uuid4()), **data.model_dump(), "password":hash_password(data.password)}; self.users[data.phone]=item; return self.user_response(item)
    def authenticate(self, phone, password):
        item=self.users.get(phone)
        return self.user_response(item) if item and verify_password(password, item["password"]) else None
    def create_product(self, data: ProductCreate, artisan_name="Ramesh Kumar"):
        ident=str(uuid4()); result=ProductResponse(id=ident,**data.model_dump(),status=ProductStatus.draft,artisan_name=artisan_name,created_at=datetime.now(timezone.utc));self.products[ident]=result;return result
    def publish(self, ident):
        item=self.products.get(ident)
        if not item: return None
        item.status=ProductStatus.active; return item
    def match(self, req: BuyerRequest):
        return {"request_id":"RFQ-500", "craft":req.craft, "match_score":92 if req.craft.lower()=="bandhani" else 78, "artisans":17, "available_capacity":612, "eta_days":24, "average_price":1050}

store = DemoStore()
