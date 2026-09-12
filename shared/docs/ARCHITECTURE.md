# LUMINARY Architecture

## Product boundary

The mobile client never calls an AI provider or commerce network directly. It calls FastAPI contracts. The backend validates structured outputs, keeps credentials server-side, and selects real or mock implementations from configuration.

## AI flow

1. The artisan selects a photo; VisionProvider returns readiness feedback.
2. SpeechProvider returns a transcript in the selected language.
3. CatalogProvider produces a strict `CatalogExtraction`, including each confidence score.
4. The artisan can edit fields, then requests a bilingual catalogue draft.
5. PricingEngine derives its recommendation from exposed costs and labelled market signals.

Mock providers are deterministic and enable the full demo without an internet connection. AI-generated content is labelled and never silently published.

## Data and security

SQLAlchemy models cover user/profile, product/image/attributes/description/provenance, pricing, signals, buyer/RFQ/matches, order/event, sync, and audit domains. Passwords use salted scrypt hashing. API sessions are server-signed bearer tokens. Production deployments must rotate `JWT_SECRET`, configure an allow-list CORS policy, use Postgres, and add request throttling at the gateway.

## Offline sync

Each sync record contains a local id, optional server id, version, update time, device id, and `SYNCED`, `PENDING`, `FAILED`, or `CONFLICT` status. The Flutter prototype presents an up-to-date/offline-safe state. Production clients should queue writes locally and resolve collisions explicitly (last-write-wins only if clearly communicated).

## Commerce

`CommerceAdapter` defines publish and order creation. `DemoCommerceAdapter` is demo-only. `ONDCReadyAdapter` is intentionally an unconnected contract and raises an explicit error instead of implying real network access.
