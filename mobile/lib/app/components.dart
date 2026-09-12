import 'package:flutter/material.dart';

import 'theme.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.child,
    this.bottom = 104,
  });

  final Widget child;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          18,
          20,
          bottom,
        ),
        child: child,
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(
    this.text, {
    super.key,
    this.action,
    this.onAction,
  });

  final String text;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  letterSpacing: -0.3,
                ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(action!),
          ),
      ],
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.color = LuminaryTheme.green,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: color.withValues(alpha: .18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: .45,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductVisual extends StatelessWidget {
  const ProductVisual({
    super.key,
    this.height = 170,
    this.compact = false,
  });

  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(
      compact ? 15 : 24,
    );

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF4DDD4),
              Color(0xFFEAC4B7),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -28,
              top: -36,
              child: Container(
                width: compact ? 82 : 150,
                height: compact ? 82 : 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFD48669).withValues(alpha: .24),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -24,
              bottom: -45,
              child: Container(
                width: compact ? 70 : 125,
                height: compact ? 70 : 125,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .22),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Container(
                width: compact ? 52 : 100,
                height: compact ? 52 : 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .34),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.checkroom_outlined,
                  size: compact ? 27 : 52,
                  color: LuminaryTheme.terracotta,
                ),
              ),
            ),
            Positioned(
              left: compact ? 10 : 18,
              bottom: compact ? 9 : 16,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 7 : 10,
                  vertical: compact ? 4 : 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .72),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'BANDHANI',
                  style: TextStyle(
                    fontSize: compact ? 8 : 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                    color: LuminaryTheme.terracotta,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Metric extends StatelessWidget {
  const Metric({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  letterSpacing: -.6,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11.5,
                ),
          ),
        ],
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? LuminaryTheme.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: LuminaryTheme.line,
        ),
      ),
      child: child,
    );
  }
}

class SoftMetricCard extends StatelessWidget {
  const SoftMetricCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.accent = LuminaryTheme.indigo,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: LuminaryTheme.line,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: accent,
                ),
              ),
            if (icon != null) const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 21,
                    letterSpacing: -.4,
                  ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductStatusBar extends StatelessWidget {
  const ProductStatusBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}