from fastapi.testclient import TestClient
from app.main import app

client=TestClient(app)
def token(): return client.post('/auth/login',json={'phone':'9999999999','password':'luminary-demo'}).json()['access_token']
def headers(): return {'Authorization':f'Bearer {token()}'}
def test_golden_path():
    assert client.get('/health').status_code==200
    assert client.post('/images/assess',headers=headers()).json()['readiness']==93
    transcript=client.post('/speech/transcribe',headers=headers()).json()['transcript']
    fields=client.post('/catalog/extract',params={'transcript':transcript},headers=headers()).json()
    assert fields['material']['value']=='Silk'
    price=client.post('/pricing/recommend',headers=headers(),json={'material_cost':700,'labour_hours':12,'labour_rate':75,'overhead':120,'packaging_cost':80,'observed_market_min':2100,'observed_market_max':2650,'demand_score':.8}).json()
    assert price['recommended_price'] >= price['sustainable_floor']
