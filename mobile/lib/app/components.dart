import 'package:flutter/material.dart';
import 'theme.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key, required this.child, this.bottom = 104});
  final Widget child;
  final double bottom;
  @override
  Widget build(BuildContext c) => SafeArea(
      child: Padding(
          padding: EdgeInsets.fromLTRB(20, 18, 20, bottom), child: child));
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.action, this.onAction});
  final String text;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext c) => Row(children: [
        Expanded(child: Text(text, style: Theme.of(c).textTheme.titleLarge)),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!))
      ]);
}

class StatusPill extends StatelessWidget {
  const StatusPill(
      {super.key, required this.label, this.color = LuminaryTheme.green});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext c) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
          color: color.withValues(alpha: .11),
          borderRadius: BorderRadius.circular(99)),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.w700)));
}

class ProductVisual extends StatelessWidget {
  const ProductVisual({super.key, this.height = 170, this.compact = false});
  final double height;
  final bool compact;
  @override
  Widget build(BuildContext c) => Container(
      height: height,
      decoration: BoxDecoration(
          color: const Color(0xFFF1D2C6),
          borderRadius: BorderRadius.circular(compact ? 14 : 22)),
      child: Stack(children: [
        Positioned(
            right: -14,
            top: -12,
            child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                    color: Color(0xFFDE8A6B), shape: BoxShape.circle))),
        Center(
            child: Icon(Icons.checkroom_outlined,
                size: compact ? 36 : 68, color: LuminaryTheme.terracotta)),
        Positioned(
            left: 13,
            bottom: 12,
            child: Text('BANDHANI',
                style: TextStyle(
                    fontSize: compact ? 9 : 11,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    color: LuminaryTheme.terracotta.withValues(alpha: .8))))
      ]));
}

class Metric extends StatelessWidget {
  const Metric({super.key, required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext c) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value,
            style: Theme.of(c).textTheme.titleLarge?.copyWith(fontSize: 21)),
        const SizedBox(height: 2),
        Text(label, style: Theme.of(c).textTheme.bodyMedium)
      ]);
}
