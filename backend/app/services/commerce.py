from abc import ABC, abstractmethod


class CommerceAdapter(ABC):
    @abstractmethod
    def publish_product(self, product_id: str) -> dict: ...
    @abstractmethod
    def create_order(self, request_id: str) -> dict: ...


class DemoCommerceAdapter(CommerceAdapter):
    def publish_product(self, product_id: str) -> dict:
        return {"status": "published", "product_id": product_id, "label": "Demo commerce adapter"}
    def create_order(self, request_id: str) -> dict:
        return {"status": "created", "request_id": request_id, "label": "Demo B2B adapter"}


class ONDCReadyAdapter(CommerceAdapter):
    """Integration contract only. Never represents a live ONDC connection."""
    def publish_product(self, product_id: str) -> dict: raise NotImplementedError("ONDC-ready export is not connected")
    def create_order(self, request_id: str) -> dict: raise NotImplementedError("ONDC-ready export is not connected")
