import 'package:flutter/material.dart';
import '../app/components.dart';
import '../app/theme.dart';
import '../core/localization.dart';
import 'product_studio.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int tab = 0;
  String language = 'en';
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
          language: language,
          onLanguage: () =>
              setState(() => language = language == 'en' ? 'hi' : 'en')),
      const ProductsPage(),
      const OrdersPage(),
      const InsightsPage(),
      const ProfilePage()
    ];
    return Scaffold(
        body: pages[tab],
        bottomNavigationBar: NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (v) => setState(() => tab = v),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  selectedIcon: Icon(Icons.inventory_2),
                  label: 'Products'),
              NavigationDestination(
                  icon: Icon(Icons.local_shipping_outlined),
                  selectedIcon: Icon(Icons.local_shipping),
                  label: 'Orders'),
              NavigationDestination(
                  icon: Icon(Icons.auto_graph_outlined),
                  selectedIcon: Icon(Icons.auto_graph),
                  label: 'Insights'),
              NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile')
            ]));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.language, required this.onLanguage});
  final String language;
  final VoidCallback onLanguage;
  @override
  Widget build(BuildContext c) {
    final l = L10n(language);
    return AppPage(
        bottom: 168,
        child: ListView(children: [
          Row(children: [
            const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF202B4D),
                child: Text('RK',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(l.greeting, style: Theme.of(c).textTheme.titleLarge),
                  const Text('Bandhani artisan · Kutch, Gujarat',
                      style: TextStyle(fontSize: 12, color: Color(0xFF686158)))
                ])),
            TextButton(
                onPressed: onLanguage,
                child: Text(language == 'en' ? 'हिं' : 'EN')),
            IconButton(
                onPressed: () => _note(c, 'No new notifications'),
                tooltip: 'Notifications',
                icon: const Icon(Icons.notifications_none))
          ]),
          const SizedBox(height: 30),
          Text(l.question, style: Theme.of(c).textTheme.displaySmall),
          const SizedBox(height: 10),
          Text('Take a photo and tell us about it.',
              style: Theme.of(c).textTheme.bodyLarge),
          const SizedBox(height: 22),
          InkWell(
              onTap: () => Navigator.push(
                  c, MaterialPageRoute(builder: (_) => const ProductStudio())),
              borderRadius: BorderRadius.circular(22),
              child: Ink(
                  decoration: BoxDecoration(
                      color: LuminaryTheme.indigo,
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Row(children: [
                        const Icon(Icons.add_a_photo_outlined,
                            color: Colors.white, size: 29),
                        const SizedBox(width: 15),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              const Text('Add a product',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 3),
                              Text('Photo + voice, in a few minutes',
                                  style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: .75)))
                            ])),
                        const Icon(Icons.arrow_forward, color: Colors.white)
                      ])))),
          const SizedBox(height: 30),
          const SectionLabel('Your business today'),
          const SizedBox(height: 14),
          const Card(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Metric(value: '3', label: 'Products'),
                        Metric(value: '2', label: 'Live'),
                        Metric(value: '1', label: 'Order'),
                        Metric(value: '₹4.6K', label: 'Value')
                      ]))),
          const SizedBox(height: 30),
          const SectionLabel('Recent products'),
          const SizedBox(height: 14),
          const _ProductRow(
              title: 'Bandhani Silk Dupatta',
              detail: 'Silk · 2.2 m',
              price: '₹2,399',
              status: 'Live'),
          const SizedBox(height: 12),
          const _ProductRow(
              title: 'Handcrafted Wall Hanging',
              detail: 'Cotton · made to order',
              price: '₹1,299',
              status: 'Live'),
          const SizedBox(height: 26),
          Card(
              color: const Color(0xFFF3F0EA),
              child: ListTile(
                  onTap: () => Navigator.push(c,
                      MaterialPageRoute(builder: (_) => const InsightsPage())),
                  leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE4EFE9),
                      child:
                          Icon(Icons.trending_up, color: LuminaryTheme.green)),
                  title: const Text('Bandhani is getting more interest'),
                  subtitle: const Text(
                      'Demand is stronger than your recent average.'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16)))
        ]));
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow(
      {required this.title,
      required this.detail,
      required this.price,
      required this.status});
  final String title, detail, price, status;
  @override
  Widget build(BuildContext c) => InkWell(
      onTap: () => Navigator.push(
          c,
          MaterialPageRoute(
              builder: (_) => ProductDetail(title: title, price: price))),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            const SizedBox(
                width: 82, child: ProductVisual(height: 72, compact: true)),
            const SizedBox(width: 13),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title, style: Theme.of(c).textTheme.titleMedium),
                  const SizedBox(height: 3),
                  Text(detail, style: Theme.of(c).textTheme.bodyMedium),
                  const SizedBox(height: 7),
                  StatusPill(label: status)
                ])),
            Text(price, style: Theme.of(c).textTheme.titleMedium)
          ])));
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext c) => AppPage(
          child: ListView(children: [
        Text('Your products', style: Theme.of(c).textTheme.displaySmall),
        const SizedBox(height: 8),
        const Text('A small, clear view of what you have ready to sell.'),
        const SizedBox(height: 22),
        const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search products')),
        const SizedBox(height: 18),
        const Wrap(spacing: 8, children: [
          Chip(label: Text('All products')),
          Chip(label: Text('Live')),
          Chip(label: Text('Drafts'))
        ]),
        const SizedBox(height: 18),
        const ProductVisual(height: 210),
        const SizedBox(height: 12),
        const _ProductRow(
            title: 'Bandhani Silk Dupatta',
            detail: 'Silk · 12 available',
            price: '₹2,399',
            status: 'Live'),
        const Divider(height: 28),
        const _ProductRow(
            title: 'Handcrafted Wall Hanging',
            detail: 'Cotton · 8 available',
            price: '₹1,299',
            status: 'Live'),
        const Divider(height: 28),
        const _ProductRow(
            title: 'Traditional Textile',
            detail: 'Needs review',
            price: '₹899',
            status: 'Draft')
      ]));
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.title, required this.price});
  final String title, price;
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => _note(c, 'Share message prepared for WhatsApp'),
            icon: const Icon(Icons.ios_share))
      ]),
      body: AppPage(
          bottom: 24,
          child: ListView(children: [
            const ProductVisual(height: 300),
            const SizedBox(height: 22),
            const StatusPill(label: 'READY TO SELL'),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(c).textTheme.headlineSmall),
            const SizedBox(height: 5),
            Text(price,
                style:
                    Theme.of(c).textTheme.displaySmall?.copyWith(fontSize: 28)),
            const SizedBox(height: 22),
            const SectionLabel('About this product'),
            const SizedBox(height: 8),
            const Text(
                'A hand-crafted Bandhani silk dupatta in a rich red tone. Product details are confirmed by the artisan.'),
            const SizedBox(height: 18),
            const _DetailGrid(),
            const SizedBox(height: 22),
            const Text('Craft story',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 6),
            const Text(
                'Made by Ramesh Kumar in Kutch, Gujarat. This profile is artisan-provided; it is not a government verification.'),
            const SizedBox(height: 24),
            FilledButton.icon(
                onPressed: () =>
                    _note(c, 'Share message prepared for WhatsApp'),
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share product'))
          ])));
}

class _DetailGrid extends StatelessWidget {
  const _DetailGrid();
  @override
  Widget build(BuildContext c) => const Card(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            _KV('Material', 'Silk'),
            Divider(),
            _KV('Dimensions', '2.2 m'),
            Divider(),
            _KV('Care', 'Dry clean only')
          ])));
}

class _KV extends StatelessWidget {
  const _KV(this.a, this.b);
  final String a, b;
  @override
  Widget build(BuildContext c) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(a),
        Text(b, style: const TextStyle(fontWeight: FontWeight.w600))
      ]);
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  @override
  Widget build(BuildContext c) => AppPage(
          child: ListView(children: [
        Text('Orders', style: Theme.of(c).textTheme.displaySmall),
        const SizedBox(height: 8),
        const Text('One order needs your attention.'),
        const SizedBox(height: 24),
        Card(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(children: [
                        Expanded(
                            child: Text('Heritage Retail Buyer',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700))),
                        StatusPill(
                            label: 'IN PRODUCTION', color: Color(0xFFC87823))
                      ]),
                      const SizedBox(height: 8),
                      const Text('ORD-102 · 50 Bandhani Silk Dupattas'),
                      const SizedBox(height: 18),
                      const _OrderRail(),
                      const SizedBox(height: 18),
                      Row(children: [
                        const Expanded(child: Text('Expected 30 Sep')),
                        FilledButton(
                            onPressed: () => Navigator.push(
                                c,
                                MaterialPageRoute(
                                    builder: (_) => const PackagingPage())),
                            child: const Text('Pack order'))
                      ])
                    ])))
      ]));
}

class _OrderRail extends StatelessWidget {
  const _OrderRail();
  @override
  Widget build(BuildContext c) => const Row(children: [
        Icon(Icons.check_circle, color: LuminaryTheme.green),
        Expanded(child: Divider()),
        Icon(Icons.check_circle, color: LuminaryTheme.green),
        Expanded(child: Divider()),
        Icon(Icons.radio_button_checked, color: LuminaryTheme.terracotta),
        Expanded(child: Divider()),
        Icon(Icons.circle_outlined, color: Color(0xFFB8B0A7))
      ]);
}

class PackagingPage extends StatelessWidget {
  const PackagingPage({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: const Text('Pack with care')),
      body: AppPage(
          bottom: 24,
          child: ListView(children: [
            Text('How to pack this product',
                style: Theme.of(c).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('Short steps for a safe delivery.'),
            const SizedBox(height: 24),
            ...[
              'Wrap the dupatta in clean tissue paper.',
              'Add a protective layer around the folded product.',
              'Place it in a sturdy, correctly sized box.',
              'Add the invoice and care card.',
              'Seal the box securely.'
            ].asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: const Color(0xFFF1D2C6),
                        child: Text('${e.key + 1}')),
                    title: Text(e.value)))),
            const SizedBox(height: 12),
            OutlinedButton.icon(
                onPressed: () => _note(c, 'Voice guidance is ready in Hindi'),
                icon: const Icon(Icons.volume_up_outlined),
                label: const Text('Listen in Hindi')),
            const SizedBox(height: 10),
            FilledButton(
                onPressed: () =>
                    _note(c, 'Order marked packed and ready for dispatch'),
                child: const Text('Mark packed'))
          ])));
}

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});
  @override
  Widget build(BuildContext c) => AppPage(
          child: ListView(children: [
        Text('Market insights', style: Theme.of(c).textTheme.displaySmall),
        const SizedBox(height: 8),
        const Text('A simple view of what may be worth making next.'),
        const SizedBox(height: 24),
        const _Signal(
            label: 'HIGH DEMAND',
            title: 'Silk Dupatta',
            copy: 'Stronger interest this week.',
            color: LuminaryTheme.green),
        const SizedBox(height: 12),
        const _Signal(
            label: 'STABLE',
            title: 'Wall Hanging',
            copy: 'Steady interest from buyers.',
            color: Color(0xFFC87823)),
        const SizedBox(height: 12),
        const _Signal(
            label: 'NEEDS ATTENTION',
            title: 'Small Pouch',
            copy: 'Try a clearer photo or a bundle.',
            color: Color(0xFFC85B3C)),
        const SizedBox(height: 26),
        Card(
            color: const Color(0xFF202B4D),
            child: ListTile(
                onTap: () => Navigator.push(
                    c, MaterialPageRoute(builder: (_) => const B2BPage())),
                leading: const Icon(Icons.groups_outlined, color: Colors.white),
                title: const Text('A buyer needs 500 products',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                subtitle: const Text('See how your cluster can fulfil it.',
                    style: TextStyle(color: Color(0xFFD9DEEF))),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white)))
      ]));
}

class _Signal extends StatelessWidget {
  const _Signal(
      {required this.label,
      required this.title,
      required this.copy,
      required this.color});
  final String label, title, copy;
  final Color color;
  @override
  Widget build(BuildContext c) => Card(
      child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(children: [
            Container(width: 4, height: 55, color: color),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .6)),
                  const SizedBox(height: 4),
                  Text(title, style: Theme.of(c).textTheme.titleMedium),
                  Text(copy, style: Theme.of(c).textTheme.bodyMedium)
                ]))
          ])));
}

class B2BPage extends StatelessWidget {
  const B2BPage({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(title: const Text('Buyer request')),
      body: AppPage(
          bottom: 24,
          child: ListView(children: [
            const StatusPill(
                label: 'DEMO B2B REQUEST', color: Color(0xFFC87823)),
            const SizedBox(height: 16),
            Text('500 Bandhani products',
                style: Theme.of(c).textTheme.headlineSmall),
            const SizedBox(height: 7),
            const Text('Heritage Retail Buyer · delivery in 30 days'),
            const SizedBox(height: 22),
            const Card(
                child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Metric(value: '92%', label: 'Good match'),
                          Metric(value: '612', label: 'Capacity'),
                          Metric(value: '17', label: 'Artisans'),
                          Metric(value: '24 days', label: 'Estimate')
                        ]))),
            const SizedBox(height: 20),
            const Text('How the cluster helps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
                'Small artisan capacities are combined to meet this larger request. Figures are seeded demo data.'),
            const SizedBox(height: 14),
            const _KV('Average price', '₹1,050'),
            const Divider(),
            const _KV('Buyer budget', '₹900–₹1,200'),
            const Divider(),
            const _KV('Cluster capacity', '612 units'),
            const SizedBox(height: 24),
            FilledButton(
                onPressed: () =>
                    _note(c, 'Proposal sent to Heritage Retail Buyer'),
                child: const Text('Send proposal')),
            const SizedBox(height: 10),
            OutlinedButton(
                onPressed: () => _note(c, 'Cluster has 17 available artisans'),
                child: const Text('View cluster'))
          ])));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext c) => AppPage(
          child: ListView(children: [
        const CircleAvatar(
            radius: 38,
            backgroundColor: LuminaryTheme.indigo,
            child: Text('RK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700))),
        const SizedBox(height: 16),
        Text('Ramesh Kumar', style: Theme.of(c).textTheme.headlineSmall),
        const SizedBox(height: 3),
        const Text('Bandhani artisan · Kutch, Gujarat'),
        const SizedBox(height: 22),
        Card(
            child: ListTile(
                onTap: () => _note(c, 'Craft Passport ready to share'),
                leading: const Icon(Icons.badge_outlined),
                title: const Text('Craft Passport'),
                subtitle: const Text('Artisan profile and product provenance'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16))),
        const SizedBox(height: 10),
        const Card(
            child: ListTile(
                leading: Icon(Icons.workspace_premium_outlined),
                title: Text('Profile status'),
                subtitle: Text(
                    'Artisan-provided profile · not government verified'))),
        const SizedBox(height: 22),
        const SectionLabel('Settings'),
        const ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            trailing: Text('Hindi')),
        const ListTile(
            leading: Icon(Icons.sync),
            title: Text('Up to date'),
            subtitle: Text('Drafts are safe if you go offline')),
        ListTile(
            onTap: () => _note(c, 'You are signed out in demo mode'),
            leading: const Icon(Icons.logout),
            title: const Text('Log out'))
      ]));
}

void _note(BuildContext c, String text) => ScaffoldMessenger.of(c).showSnackBar(
    SnackBar(content: Text(text), behavior: SnackBarBehavior.floating));
