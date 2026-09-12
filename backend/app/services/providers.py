from abc import ABC, abstractmethod
from app.schemas.contracts import CatalogContent, CatalogExtraction, ExtractedField, ImageAssessment


class VisionProvider(ABC):
    @abstractmethod
    def assess(self, image_name: str) -> ImageAssessment: ...


class SpeechProvider(ABC):
    @abstractmethod
    def transcribe(self, language: str, hint: str | None = None) -> str: ...


class CatalogProvider(ABC):
    @abstractmethod
    def extract(self, transcript: str) -> CatalogExtraction: ...
    @abstractmethod
    def generate(self, extraction: CatalogExtraction) -> CatalogContent: ...


class MockVisionProvider(VisionProvider):
    def assess(self, image_name: str) -> ImageAssessment:
        return ImageAssessment(background=92, lighting=90, sharpness=94, framing=95, readiness=93)


class MockSpeechProvider(SpeechProvider):
    def transcribe(self, language: str, hint: str | None = None) -> str:
        return hint or "यह लाल रंग का हाथ से बना बंधनी सिल्क दुपट्टा है, 2.2 मीटर का है और बनाने में तीन दिन लगते हैं।"


class MockCatalogProvider(CatalogProvider):
    def extract(self, transcript: str) -> CatalogExtraction:
        return CatalogExtraction(
            title=ExtractedField(value="Handwoven Bandhani Silk Dupatta", confidence=.94),
            craft=ExtractedField(value="Bandhani", confidence=.96),
            category=ExtractedField(value="Textiles", confidence=.91),
            material=ExtractedField(value="Silk", confidence=.94),
            color=ExtractedField(value="Red", confidence=.96),
            dimensions=ExtractedField(value="2.2 m", confidence=.72),
            time_to_make=ExtractedField(value="3 days", confidence=.88),
            care=ExtractedField(value="Dry clean only", confidence=.68),
        )
    def generate(self, e: CatalogExtraction) -> CatalogContent:
        return CatalogContent(
            title_en=e.title.value, title_hi="हाथ से बना बंधनी सिल्क दुपट्टा",
            description_en="A hand-crafted Bandhani silk dupatta in a rich red tone. Details are AI-assisted from the artisan's description and should be confirmed before publishing.",
            description_hi="गहरे लाल रंग का हाथ से बना बंधनी सिल्क दुपट्टा। प्रकाशन से पहले विवरण की पुष्टि करें।",
            summary="Hand-crafted Bandhani silk dupatta, 2.2 m.",
            tags=["Bandhani", "silk dupatta", "handcrafted", "Gujarat"],
        )

vision_provider = MockVisionProvider()
speech_provider = MockSpeechProvider()
catalog_provider = MockCatalogProvider()
