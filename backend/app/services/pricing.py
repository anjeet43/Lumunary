from app.schemas.contracts import PriceRequest, PriceResult


class PricingEngine:
    """Transparent rules engine; replaceable with a validated market model later."""
    def recommend(self, data: PriceRequest) -> PriceResult:
        cost = data.material_cost + data.labour_hours * data.labour_rate + data.overhead + data.packaging_cost + data.transaction_cost
        floor = round(cost * 1.05, 2)
        target = cost * (1 + data.target_margin)
        market_ok = data.observed_market_min is not None and data.observed_market_max is not None
        if market_ok:
            low, high = data.observed_market_min, data.observed_market_max
            adjusted = target * (0.96 + data.demand_score * .08)
            recommendation = min(max(adjusted, low), high)
            confidence, source = .86, "DEMO market signal — not live pricing"
            reasons = ["Covers your cost floor", "Fits the seeded market range", "Includes your target margin", "Adjusted for the demo demand signal"]
        else:
            low = high = None
            recommendation, confidence, source = target, .62, "Cost-based estimate — no market range available"
            reasons = ["Covers your cost floor", "Includes your target margin", "Add market data for a more reliable range"]
        return PriceResult(total_cost=round(cost, 2), sustainable_floor=floor, market_low=low, market_high=high,
                           recommended_price=round(recommendation), confidence=confidence, data_freshness="Seeded demo data · Sep 2026", source=source, reasons=reasons)


pricing_engine = PricingEngine()
