from dataclasses import dataclass
from enum import Enum

class SyncStatus(str, Enum):
    synced="SYNCED"; pending="PENDING"; failed="FAILED"; conflict="CONFLICT"

@dataclass
class SyncRecord:
    local_id: str; server_id: str | None; version: int; updated_at: str; device_id: str; status: SyncStatus

