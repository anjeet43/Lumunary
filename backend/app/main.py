import base64, hashlib, hmac, json
from datetime import datetime, timedelta, timezone
from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from app.core.config import settings
from app.schemas.contracts import *
from app.services.pricing import pricing_engine
from app.services.providers import catalog_provider, speech_provider, vision_provider
from app.services.store import store

app=FastAPI(title="Luminary API", version="0.1.0", description="Demo-safe virtual business manager APIs for artisans.")
app.add_middleware(CORSMiddleware, allow_origins=["http://localhost:3000","http://localhost:8080"], allow_credentials=True, allow_methods=["*"], allow_headers=["*"])
bearer=HTTPBearer(auto_error=False)
def token_for(user_id):
    body=base64.urlsafe_b64encode(json.dumps({"sub":user_id,"exp":int((datetime.now(timezone.utc)+timedelta(days=7)).timestamp())}).encode()).decode().rstrip("=")
    sig=hmac.new(settings.jwt_secret.encode(),body.encode(),hashlib.sha256).hexdigest(); return f"{body}.{sig}"
def current_user(credentials: HTTPAuthorizationCredentials=Depends(bearer)):
    if not credentials: raise HTTPException(401,"Please sign in")
    try:
        body,sig=credentials.credentials.split("."); expected=hmac.new(settings.jwt_secret.encode(),body.encode(),hashlib.sha256).hexdigest()
        if not hmac.compare_digest(sig,expected): raise ValueError
        data=json.loads(base64.urlsafe_b64decode(body+"=="));
        if data["exp"]<datetime.now(timezone.utc).timestamp(): raise ValueError
        return data["sub"]
    except Exception: raise HTTPException(401,"Your session has expired")

@app.get("/health")
def health(): return {"status":"ok","demo_mode":settings.demo_mode,"ai_provider":settings.ai_provider_mode}
@app.post("/auth/register",response_model=TokenResponse,status_code=201)
def register(data:RegisterRequest):
    try: user=store.register(data)
    except ValueError as e: raise HTTPException(409,str(e))
    return TokenResponse(access_token=token_for(user.id),user=user)
@app.post("/auth/login",response_model=TokenResponse)
def login(data:LoginRequest):
    user=store.authenticate(data.phone,data.password)
    if not user: raise HTTPException(status.HTTP_401_UNAUTHORIZED,"Incorrect phone or password")
    return TokenResponse(access_token=token_for(user.id),user=user)
@app.get("/artisans/me",response_model=UserResponse)
def me(user=Depends(current_user)):
    return next(store.user_response(item) for item in store.users.values() if item["id"]==user)
@app.post("/images/assess",response_model=ImageAssessment)
def assess(image_name:str="product.jpg",user=Depends(current_user)): return vision_provider.assess(image_name)
@app.post("/speech/transcribe")
def transcribe(language:str="hi",hint:str|None=None,user=Depends(current_user)): return {"transcript":speech_provider.transcribe(language,hint),"provider":"deterministic mock"}
@app.post("/catalog/extract",response_model=CatalogExtraction)
def extract(transcript:str,user=Depends(current_user)): return catalog_provider.extract(transcript)
@app.post("/catalog/generate",response_model=CatalogContent)
def catalog(data:CatalogExtraction,user=Depends(current_user)): return catalog_provider.generate(data)
@app.post("/pricing/recommend",response_model=PriceResult)
def price(data:PriceRequest,user=Depends(current_user)): return pricing_engine.recommend(data)
@app.get("/products",response_model=list[ProductResponse])
def products(user=Depends(current_user)): return list(store.products.values())
@app.post("/products",response_model=ProductResponse,status_code=201)
def create_product(data:ProductCreate,user=Depends(current_user)): return store.create_product(data)
@app.post("/products/{product_id}/publish",response_model=ProductResponse)
def publish(product_id:str,user=Depends(current_user)):
    item=store.publish(product_id)
    if not item: raise HTTPException(404,"Product not found")
    return item
@app.get("/market/signals")
def signals(user=Depends(current_user)): return [{"craft":"Silk Dupatta","demand":"HIGH","message":"Demand is stronger than your recent average.","source":"DEMO market signal"},{"craft":"Wall Hanging","demand":"STABLE","message":"Interest is steady this week.","source":"DEMO market signal"}]
@app.post("/buyers/requests/match",response_model=MatchResponse)
def match(data:BuyerRequest,user=Depends(current_user)): return store.match(data)
@app.get("/buyers/requests")
def buyer_requests(user=Depends(current_user)): return [{"id":"RFQ-500","buyer":"Heritage Retail Buyer","craft":"Bandhani","quantity":500,"budget":"₹900–₹1,200","deadline_days":30,"integration":"Demo B2B request"}]
@app.get("/orders",response_model=list[OrderResponse])
def orders(user=Depends(current_user)): return list(store.orders.values())
@app.post("/orders/{order_id}/status",response_model=OrderResponse)
def update_order(order_id:str,new_status:OrderStatus,user=Depends(current_user)):
    item=store.orders.get(order_id)
    if not item: raise HTTPException(404,"Order not found")
    item.status=new_status; item.shipment_status="Dispatched" if new_status==OrderStatus.dispatched else item.shipment_status; return item
@app.get("/packaging/{category}")
def packaging(category:str,user=Depends(current_user)): return {"category":category,"steps":["Wrap the product in clean tissue paper.","Use a sturdy box with padding on every side.","Add a care card and seal the parcel."],"audio_ready":True}
