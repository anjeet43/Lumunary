import 'package:flutter/material.dart';

class ProductStudio extends StatefulWidget {
  const ProductStudio({super.key});
  @override
  State<ProductStudio> createState() => _ProductStudioState();
}

class _ProductStudioState extends State<ProductStudio> {
  int step = 0;
  double price = 2399;
  bool enhanced = true;
  final steps = [
    'Photo',
    'Studio',
    'Voice',
    'Details',
    'Catalogue',
    'Price',
    'Review'
  ];
  void next() {
    if (step < steps.length - 1) {
      setState(() => step++);
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                  icon: const Icon(Icons.check_circle,
                      color: Color(0xFF27705A), size: 48),
                  title: const Text('Your product is live!'),
                  content: const Text(
                      'Your catalogue is saved and published through the demo commerce adapter.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('View product')),
                    FilledButton(
                        onPressed: () =>
                            Navigator.of(context).popUntil((r) => r.isFirst),
                        child: const Text('Done'))
                  ]));
    }
  }

  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: Text('${steps[step]} · ${step + 1}/7')),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                LinearProgressIndicator(
                    value: (step + 1) / 7,
                    borderRadius: BorderRadius.circular(8)),
                const SizedBox(height: 22),
                Expanded(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _content(c))),
                Row(children: [
                  if (step > 0)
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () => setState(() => step--),
                            child: const Text('Back'))),
                  if (step > 0) const SizedBox(width: 12),
                  Expanded(
                      child: FilledButton(
                          onPressed: next,
                          child:
                              Text(step == 6 ? 'Publish product' : 'Continue')))
                ])
              ]))));
  Widget _content(BuildContext c) {
    switch (step) {
      case 0:
        return _Photo(onPick: () => setState(() => step = 1));
      case 1:
        return _Studio(
            enhanced: enhanced, onChanged: (v) => setState(() => enhanced = v));
      case 2:
        return const _Voice();
      case 3:
        return const _Details();
      case 4:
        return const _Catalogue();
      case 5:
        return _Pricing(
            price: price, onChanged: (v) => setState(() => price = v));
      default:
        return _Review(price: price, enhanced: enhanced);
    }
  }
}

class _Panel extends StatelessWidget {
  const _Panel(
      {required this.title, required this.subtitle, required this.child});
  final String title, subtitle;
  final Widget child;
  @override
  Widget build(BuildContext c) => ListView(key: ValueKey(title), children: [
        Text(title, style: Theme.of(c).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(subtitle),
        const SizedBox(height: 22),
        child
      ]);
}

class _Photo extends StatelessWidget {
  const _Photo({required this.onPick});
  final VoidCallback onPick;
  @override
  Widget build(BuildContext c) => _Panel(
      title: 'Add a clear photo',
      subtitle: 'Take one clear photo. We’ll help improve it.',
      child: Column(children: [
        Container(
            height: 260,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xFFF1D3C7),
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: const Icon(Icons.add_a_photo_outlined,
                size: 74, color: Color(0xFFC85B3C))),
        const SizedBox(height: 18),
        FilledButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Take photo')),
        const SizedBox(height: 10),
        TextButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.photo_library_outlined),
            label: const Text('Choose from gallery'))
      ]));
}

class _Studio extends StatelessWidget {
  const _Studio({required this.enhanced, required this.onChanged});
  final bool enhanced;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext c) => _Panel(
      title: 'Your photo studio',
      subtitle: 'We help your product look clear and true to life.',
      child: Column(children: [
        Container(
            height: 230,
            decoration: const BoxDecoration(
                color: Color(0xFFF1D3C7),
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Center(
                child: Text(enhanced ? 'IMPROVED PREVIEW' : 'ORIGINAL PHOTO',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC85B3C))))),
        const SizedBox(height: 16),
        const Card(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('E-commerce readiness'),
                        Text('93/100',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF27705A)))
                      ]),
                  SizedBox(height: 8),
                  LinearProgressIndicator(value: .93, color: Color(0xFF27705A))
                ]))),
        SwitchListTile(
            value: enhanced,
            onChanged: onChanged,
            title: const Text('Use enhanced image'),
            subtitle: const Text('Background cleaned · lighting improved'),
            contentPadding: EdgeInsets.zero)
      ]));
}

class _Voice extends StatelessWidget {
  const _Voice();
  @override
  Widget build(BuildContext c) => _Panel(
      title: 'Tell us about your product',
      subtitle: 'Speak naturally in your language. You do not need to type.',
      child: Column(children: [
        const CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xFFE7F1EB),
            child: Icon(Icons.mic, size: 52, color: Color(0xFF27705A))),
        const SizedBox(height: 20),
        const Text('Listening in Hindi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        const Card(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    '“यह लाल रंग का हाथ से बना बंधनी सिल्क दुपट्टा है, 2.2 मीटर का है और बनाने में तीन दिन लगते हैं।”'))),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit transcript'))
      ]));
}

class _Details extends StatelessWidget {
  const _Details();
  @override
  Widget build(BuildContext c) => const _Panel(
      title: 'We found these details',
      subtitle: 'Check anything marked for review before publishing.',
      child: Column(children: [
        _Field('Material', 'Silk', '94%'),
        _Field('Colour', 'Red', '96%'),
        _Field('Dimensions', '2.2 m', '72% · check'),
        _Field('Time to make', '3 days', '88%'),
        _Field('Care', 'Dry clean only', '68% · check')
      ]));
}

class _Field extends StatelessWidget {
  const _Field(this.label, this.value, this.confidence);
  final String label, value, confidence;
  @override
  Widget build(BuildContext c) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
          initialValue: value,
          decoration: InputDecoration(
              labelText: label,
              helperText: 'AI-assisted · $confidence',
              helperStyle: TextStyle(
                  color: confidence.contains('check')
                      ? const Color(0xFFC85B3C)
                      : null))));
}

class _Catalogue extends StatelessWidget {
  const _Catalogue();
  @override
  Widget build(BuildContext c) => const _Panel(
      title: 'Your catalogue is ready',
      subtitle: 'AI-assisted draft. Your words and confirmation come first.',
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(label: Text('AI-assisted draft')),
                    SizedBox(height: 8),
                    Text('Handwoven Bandhani Silk Dupatta',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text(
                        'A hand-crafted Bandhani silk dupatta in a rich red tone. Details come from your description and can be edited.'),
                    SizedBox(height: 12),
                    Text('बंधनी सिल्क दुपट्टा',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    SizedBox(height: 8),
                    Text('प्रकाशन से पहले विवरण की पुष्टि करें।')
                  ]))));
}

class _Pricing extends StatelessWidget {
  const _Pricing({required this.price, required this.onChanged});
  final double price;
  final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext c) => _Panel(
      title: 'A fair price, explained',
      subtitle:
          'This is an estimate using demo market signals — not live market pricing.',
      child: Column(children: [
        const Card(
            child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  _Cost('Material', '₹700'),
                  _Cost('Labour', '₹900'),
                  _Cost('Overhead + packaging', '₹200'),
                  Divider(),
                  _Cost('Cost floor', '₹1,890', bold: true),
                  _Cost('Demo market range', '₹2,100–₹2,650'),
                  SizedBox(height: 8),
                  Text(
                      'Covers your costs, includes your margin, and fits the seeded market range.',
                      style: TextStyle(fontSize: 12))
                ]))),
        const SizedBox(height: 18),
        Text('Recommended price  ₹${price.round()}',
            style: Theme.of(c).textTheme.titleLarge),
        Slider(
            value: price,
            min: 1890,
            max: 2700,
            divisions: 81,
            label: '₹${price.round()}',
            onChanged: onChanged),
        const Text('You are always in control. You can adjust this price.')
      ]));
}

class _Cost extends StatelessWidget {
  const _Cost(this.a, this.b, {this.bold = false});
  final String a, b;
  final bool bold;
  @override
  Widget build(BuildContext c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(a, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
        Text(b, style: TextStyle(fontWeight: bold ? FontWeight.bold : null))
      ]));
}

class _Review extends StatelessWidget {
  const _Review({required this.price, required this.enhanced});
  final double price;
  final bool enhanced;
  @override
  Widget build(BuildContext c) => _Panel(
      title: 'Ready to publish?',
      subtitle: 'You remain in control. Please confirm everything below.',
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Check('Photo'),
                    const _Check('Title and category'),
                    const _Check('Material and description'),
                    _Check('Price · ₹${price.round()}'),
                    const _Check('Your approval'),
                    const SizedBox(height: 14),
                    const Text(
                        'Publishing uses the Demo Commerce Adapter. It is not a live ONDC or government marketplace connection.',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF6D625B)))
                  ]))));
}

class _Check extends StatelessWidget {
  const _Check(this.text);
  final String text;
  @override
  Widget build(BuildContext c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(children: [
        const Icon(Icons.check_circle, color: Color(0xFF27705A)),
        const SizedBox(width: 10),
        Text(text)
      ]));
}
