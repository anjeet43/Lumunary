# LUMINARY

LUMINARY is a demo-safe, voice-first digital business manager for marginalized artisans. It was built around SIH Problem Statement 26090: **“Snap it. Speak it. Price it. Sell it.”**

The prototype intentionally labels deterministic mock AI, seeded market data, and commerce adapters. It does not claim live ONDC, GeM, Pehchan, payment, shipping, or market-price integrations.

## What works

- Flutter Material 3 artisan experience with English/Hindi toggle and accessible large actions
- End-to-end product studio: photo, image assessment, voice transcript, editable AI-assisted extraction, bilingual catalogue, pricing, review, publishing success
- Demo FastAPI APIs with login/register, signed tokens, deterministic mock vision/speech/catalog providers, product inventory, market signals, buyer request matching, orders, and packaging guidance
- Transparent pricing formula and modular AI/commerce/sync contracts
- Deterministic seed data: Ramesh Kumar (Bandhani, Kutch), products, RFQ-500, market signals, and ORD-102

## Architecture

```
Flutter mobile app → FastAPI → provider / pricing / commerce interfaces
                                 ├─ Mock AI providers (demo mode)
                                 ├─ Demo matching + commerce adapters
                                 └─ SQLAlchemy persistence foundation
```

The running demo uses a deterministic in-memory repository so it remains reliable without a database or external API. `backend/app/models.py` defines the SQLAlchemy persistence foundation for Postgres/SQLite migration.

## Run backend

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload --port 8000
```

Open API docs at `http://127.0.0.1:8000/docs`. Demo login: `9999999999` / `luminary-demo`.

Run `pytest` from `backend/` for the API golden-path test. `docker compose up --build` starts Postgres plus the backend; copy `.env.example` and change secrets before any non-demo deployment.

## Run mobile

```bash
source scripts/flutter-env.sh
cd mobile
flutter pub get
flutter run
```

The repository-local Flutter SDK lives in `.tools/flutter`; the helper keeps its PATH, cache, and analytics configuration inside the workspace without changing your global shell profile.

The app works as an offline-friendly visual demo today; its primary actions have local deterministic behavior. The API contracts in `backend/app/schemas/contracts.py` are the integration boundary for wiring network repositories next.

## Configuration

See root and backend `.env.example`. Keep `AI_PROVIDER_MODE=mock`, `COMMERCE_MODE=demo`, and `DEMO_MODE=true` for the SIH demo. Real integrations belong only behind the provider/adapter interfaces and must be visibly labelled once connected.

## Limits and next steps

This is a functional prototype, not a claim of government or network integration. Persistence repositories, image upload/storage, real encrypted mobile token storage, production rate limiting, background queues, Alembic revision generation, and robust offline conflict resolution are intentionally the next production hardening steps.

See [Architecture notes](shared/docs/ARCHITECTURE.md) and [the demo script](shared/docs/DEMO.md).
