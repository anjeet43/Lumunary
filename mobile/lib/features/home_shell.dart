import 'package:flutter/material.dart';

import '../app/components.dart';
import '../app/theme.dart';
import '../core/localization.dart';
import '../core/session.dart';

import 'login.dart';
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
        onLanguage: () {
          setState(() {
            language = language == 'en' ? 'hi' : 'en';
          });
        },
      ),
      const ProductsPage(),
      const OrdersPage(),
      const InsightsPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: LuminaryTheme.ivory,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: KeyedSubtree(
          key: ValueKey(tab),
          child: pages[tab],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() => tab = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2_rounded),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            selectedIcon: Icon(Icons.local_shipping_rounded),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_graph_outlined),
            selectedIcon: Icon(Icons.auto_graph_rounded),
            label: 'Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HOME
// -----------------------------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.language,
    required this.onLanguage,
  });

  final String language;
  final VoidCallback onLanguage;

  @override
  Widget build(BuildContext context) {
    final l = L10n(language);

    return AppPage(
      bottom: 24,
      child: ListView(
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: LuminaryTheme.indigo,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'RK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.greeting,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Bandhani artisan · Kutch, Gujarat',
                      style: TextStyle(
                        color: LuminaryTheme.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _HeaderButton(
                icon: Icons.language_rounded,
                onTap: onLanguage,
                label: language == 'en' ? 'हिं' : 'EN',
              ),
              const SizedBox(width: 6),
              _HeaderButton(
                icon: Icons.notifications_none_rounded,
                onTap: () => _note(
                  context,
                  'No new notifications',
                ),
              ),
            ],
          ),

          const SizedBox(height: 38),

          // Main greeting
          Text(
            l.question,
            style: Theme.of(context).textTheme.displaySmall,
          ),

          const SizedBox(height: 10),

          Text(
            language == 'en'
                ? 'Turn your craft into a professional product.'
                : 'अपने हुनर को एक पेशेवर उत्पाद में बदलें।',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: LuminaryTheme.muted,
                ),
          ),

          const SizedBox(height: 24),

          // Main CTA
          _ProductStudioHero(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductStudio(),
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          const SectionLabel('Your business'),

          const SizedBox(height: 14),

          // Metrics
          const Row(
            children: [
              SoftMetricCard(
                value: '3',
                label: 'Products',
                icon: Icons.inventory_2_outlined,
                accent: LuminaryTheme.indigo,
              ),
              SizedBox(width: 10),
              SoftMetricCard(
                value: '2',
                label: 'Live',
                icon: Icons.storefront_outlined,
                accent: LuminaryTheme.green,
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Row(
            children: [
              SoftMetricCard(
                value: '1',
                label: 'Order',
                icon: Icons.local_shipping_outlined,
                accent: LuminaryTheme.terracotta,
              ),
              SizedBox(width: 10),
              SoftMetricCard(
                value: '₹4.6K',
                label: 'Value',
                icon: Icons.currency_rupee_rounded,
                accent: LuminaryTheme.indigo,
              ),
            ],
          ),

          const SizedBox(height: 32),

          const SectionLabel('Recent products'),

          const SizedBox(height: 14),

          const _ProductRow(
            title: 'Bandhani Silk Dupatta',
            detail: 'Silk · 2.2 m',
            price: '₹2,399',
            status: 'Live',
          ),

          const SizedBox(height: 10),

          const _ProductRow(
            title: 'Handcrafted Wall Hanging',
            detail: 'Cotton · made to order',
            price: '₹1,299',
            status: 'Live',
          ),

          const SizedBox(height: 28),

          // Market insight
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InsightsPage(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(22),
            child: Ink(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: LuminaryTheme.greenSoft,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .75),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.trending_up_rounded,
                      color: LuminaryTheme.green,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Market signal',
                          style: TextStyle(
                            fontSize: 11,
                            color: LuminaryTheme.green,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .8,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bandhani is getting more interest',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: LuminaryTheme.charcoal,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Demand is stronger than your recent average.',
                          style: TextStyle(
                            fontSize: 12,
                            color: LuminaryTheme.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: LuminaryTheme.green,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HOME HERO
// -----------------------------------------------------------------------------

class _ProductStudioHero extends StatelessWidget {
  const _ProductStudioHero({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          height: 190,
          decoration: BoxDecoration(
            color: LuminaryTheme.indigo,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -35,
                top: -45,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .07),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 35,
                bottom: -65,
                child: Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: LuminaryTheme.terracotta.withValues(alpha: .20),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Add a product',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Photo + voice → catalogue → price',
                      style: TextStyle(
                        color: Color(0xFFD9DEEF),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 22,
                bottom: 23,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HEADER BUTTON
// -----------------------------------------------------------------------------

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.icon,
    required this.onTap,
    this.label,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 42,
          width: label == null ? 42 : 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: LuminaryTheme.line,
            ),
          ),
          child: label == null
              ? Icon(
                  icon,
                  size: 20,
                  color: LuminaryTheme.charcoal,
                )
              : Center(
                  child: Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: LuminaryTheme.indigo,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PRODUCT ROW
// -----------------------------------------------------------------------------

class _ProductRow extends StatelessWidget {
  const _ProductRow({
    required this.title,
    required this.detail,
    required this.price,
    required this.status,
  });

  final String title;
  final String detail;
  final String price;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetail(
                title: title,
                price: price,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: LuminaryTheme.paper,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: LuminaryTheme.line,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 78,
                height: 78,
                child: ProductVisual(
                  height: 78,
                  compact: true,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    StatusPill(label: status),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                price,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PRODUCTS
// -----------------------------------------------------------------------------

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bottom: 24,
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your products',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductStudio(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            'Everything you have ready to sell, in one place.',
          ),
          const SizedBox(height: 22),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search products',
            ),
          ),
          const SizedBox(height: 16),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'All products',
                  selected: true,
                ),
                SizedBox(width: 8),
                _FilterChip(
                  label: 'Live',
                ),
                SizedBox(width: 8),
                _FilterChip(
                  label: 'Drafts',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _ProductGridCard(
            title: 'Bandhani Silk Dupatta',
            detail: 'Silk · 12 available',
            price: '₹2,399',
            status: 'Live',
          ),
          const SizedBox(height: 12),
          const _ProductGridCard(
            title: 'Handcrafted Wall Hanging',
            detail: 'Cotton · 8 available',
            price: '₹1,299',
            status: 'Live',
          ),
          const SizedBox(height: 12),
          const _ProductGridCard(
            title: 'Traditional Textile',
            detail: 'Needs review',
            price: '₹899',
            status: 'Draft',
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: selected
            ? LuminaryTheme.indigo
            : LuminaryTheme.paper,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: selected
              ? LuminaryTheme.indigo
              : LuminaryTheme.line,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected
              ? Colors.white
              : LuminaryTheme.charcoal,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  const _ProductGridCard({
    required this.title,
    required this.detail,
    required this.price,
    required this.status,
  });

  final String title;
  final String detail;
  final String price;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetail(
                title: title,
                price: price,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: LuminaryTheme.paper,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: LuminaryTheme.line,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProductVisual(
                height: 190,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            detail,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                          const SizedBox(height: 10),
                          StatusPill(label: status),
                        ],
                      ),
                    ),
                    Text(
                      price,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PRODUCT DETAIL
// -----------------------------------------------------------------------------

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.title,
    required this.price,
  });

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuminaryTheme.ivory,
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
            onPressed: () =>
                _note(context, 'Share message prepared for WhatsApp'),
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: AppPage(
        bottom: 24,
        child: ListView(
          children: [
            const ProductVisual(height: 300),
            const SizedBox(height: 20),
            const StatusPill(label: 'READY TO SELL'),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 24),
            const SectionLabel('About this product'),
            const SizedBox(height: 9),
            const Text(
              'A hand-crafted Bandhani silk dupatta in a rich red tone. '
              'Product details are confirmed by the artisan.',
            ),
            const SizedBox(height: 18),
            const _DetailGrid(),
            const SizedBox(height: 24),
            const SectionLabel('Craft story'),
            const SizedBox(height: 8),
            const Text(
              'Made by Ramesh Kumar in Kutch, Gujarat. '
              'This profile is artisan-provided; it is not a government verification.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () =>
                  _note(context, 'Share message prepared for WhatsApp'),
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share product'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailGrid extends StatelessWidget {
  const _DetailGrid();

  @override
  Widget build(BuildContext context) {
    return const PremiumCard(
      child: Column(
        children: [
          _KV('Material', 'Silk'),
          Divider(height: 24),
          _KV('Dimensions', '2.2 m'),
          Divider(height: 24),
          _KV('Care', 'Dry clean only'),
        ],
      ),
    );
  }
}

class _KV extends StatelessWidget {
  const _KV(this.a, this.b);

  final String a;
  final String b;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          a,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          b,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// ORDERS
// -----------------------------------------------------------------------------

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bottom: 24,
      child: ListView(
        children: [
          Text(
            'Orders',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 7),
          const Text(
            'Keep track of every order from production to dispatch.',
          ),
          const SizedBox(height: 24),
          PremiumCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Heritage Retail Buyer',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    StatusPill(
                      label: 'IN PRODUCTION',
                      color: LuminaryTheme.terracotta,
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                const Text(
                  'ORD-102 · 50 Bandhani Silk Dupattas',
                  style: TextStyle(
                    color: LuminaryTheme.muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),
                const _OrderRail(),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confirmed',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Production',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Packed',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Dispatch',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: LuminaryTheme.ivory,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.event_outlined,
                        size: 19,
                        color: LuminaryTheme.indigo,
                      ),
                      SizedBox(width: 9),
                      Text(
                        'Expected 30 Sep',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PackagingPage(),
                        ),
                      );
                    },
                    child: const Text('Pack order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderRail extends StatelessWidget {
  const _OrderRail();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: LuminaryTheme.green,
          size: 21,
        ),
        Expanded(child: Divider()),
        Icon(
          Icons.radio_button_checked_rounded,
          color: LuminaryTheme.terracotta,
          size: 21,
        ),
        Expanded(child: Divider()),
        Icon(
          Icons.circle_outlined,
          color: LuminaryTheme.muted,
          size: 21,
        ),
        Expanded(child: Divider()),
        Icon(
          Icons.circle_outlined,
          color: LuminaryTheme.muted,
          size: 21,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// PACKAGING
// -----------------------------------------------------------------------------

class PackagingPage extends StatelessWidget {
  const PackagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = [
      'Wrap the dupatta in clean tissue paper.',
      'Add a protective layer around the folded product.',
      'Place it in a sturdy, correctly sized box.',
      'Add the invoice and care card.',
      'Seal the box securely.',
    ];

    return Scaffold(
      backgroundColor: LuminaryTheme.ivory,
      appBar: AppBar(
        title: const Text('Pack with care'),
      ),
      body: AppPage(
        bottom: 24,
        child: ListView(
          children: [
            Text(
              'How to pack this product',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 7),
            const Text(
              'Short steps for a safe delivery.',
            ),
            const SizedBox(height: 22),
            ...steps.asMap().entries.map(
              (entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: PremiumCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: LuminaryTheme.terracottaSoft,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: LuminaryTheme.terracotta,
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              fontSize: 13.5,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () =>
                  _note(context, 'Voice guidance is ready in Hindi'),
              icon: const Icon(Icons.volume_up_outlined),
              label: const Text('Listen in Hindi'),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () => _note(
                context,
                'Order marked packed and ready for dispatch',
              ),
              child: const Text('Mark packed'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// INSIGHTS
// -----------------------------------------------------------------------------

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bottom: 24,
      child: ListView(
        children: [
          Text(
            'Market insights',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 7),
          const Text(
            'Know what buyers are looking for before you make your next piece.',
          ),
          const SizedBox(height: 24),
          const _Signal(
            label: 'HIGH DEMAND',
            title: 'Silk Dupatta',
            copy: 'Stronger interest this week.',
            color: LuminaryTheme.green,
            icon: Icons.trending_up_rounded,
          ),
          const SizedBox(height: 12),
          const _Signal(
            label: 'STABLE',
            title: 'Wall Hanging',
            copy: 'Steady interest from buyers.',
            color: LuminaryTheme.terracotta,
            icon: Icons.remove_rounded,
          ),
          const SizedBox(height: 12),
          const _Signal(
            label: 'NEEDS ATTENTION',
            title: 'Small Pouch',
            copy: 'Try a clearer photo or a bundle.',
            color: Color(0xFFC85B3C),
            icon: Icons.lightbulb_outline_rounded,
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const B2BPage(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(22),
            child: Ink(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: LuminaryTheme.indigo,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.groups_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'B2B OPPORTUNITY',
                          style: TextStyle(
                            color: Color(0xFFBFC7E3),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'A buyer needs 500 products',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'See how your cluster can fulfil it.',
                          style: TextStyle(
                            color: Color(0xFFD9DEEF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Signal extends StatelessWidget {
  const _Signal({
    required this.label,
    required this.title,
    required this.copy,
    required this.color,
    required this.icon,
  });

  final String label;
  final String title;
  final String copy;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  copy,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// B2B
// -----------------------------------------------------------------------------

class B2BPage extends StatelessWidget {
  const B2BPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuminaryTheme.ivory,
      appBar: AppBar(
        title: const Text('Buyer request'),
      ),
      body: AppPage(
        bottom: 24,
        child: ListView(
          children: [
            const StatusPill(
              label: 'DEMO B2B REQUEST',
              color: LuminaryTheme.terracotta,
            ),
            const SizedBox(height: 15),
            Text(
              '500 Bandhani products',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            const Text(
              'Heritage Retail Buyer · delivery in 30 days',
            ),
            const SizedBox(height: 20),
            const PremiumCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      _B2BMetric(
                        value: '92%',
                        label: 'Match',
                      ),
                      _B2BMetric(
                        value: '612',
                        label: 'Capacity',
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      _B2BMetric(
                        value: '17',
                        label: 'Artisans',
                      ),
                      _B2BMetric(
                        value: '24 days',
                        label: 'Estimate',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const SectionLabel('How the cluster helps'),
            const SizedBox(height: 8),
            const Text(
              'Small artisan capacities are combined to meet this larger request. '
              'Figures are seeded demo data.',
            ),
            const SizedBox(height: 18),
            const PremiumCard(
              child: Column(
                children: [
                  _KV('Average price', '₹1,050'),
                  Divider(height: 24),
                  _KV('Buyer budget', '₹900–₹1,200'),
                  Divider(height: 24),
                  _KV('Cluster capacity', '612 units'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () =>
                  _note(context, 'Proposal sent to Heritage Retail Buyer'),
              child: const Text('Send proposal'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () =>
                  _note(context, 'Cluster has 17 available artisans'),
              child: const Text('View cluster'),
            ),
          ],
        ),
      ),
    );
  }
}

class _B2BMetric extends StatelessWidget {
  const _B2BMetric({
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PROFILE
// -----------------------------------------------------------------------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bottom: 24,
      child: ListView(
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: LuminaryTheme.indigo,
                  borderRadius: BorderRadius.circular(22),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'RK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ramesh Kumar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Bandhani artisan · Kutch, Gujarat',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () =>
                _note(context, 'Craft Passport ready to share'),
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: LuminaryTheme.paper,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: LuminaryTheme.line,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.badge_outlined,
                    color: LuminaryTheme.indigo,
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Craft Passport',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Artisan profile and product provenance',
                          style: TextStyle(
                            fontSize: 12,
                            color: LuminaryTheme.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const PremiumCard(
            child: Row(
              children: [
                Icon(
                  Icons.verified_outlined,
                  color: LuminaryTheme.green,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile status',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Artisan-provided profile · not government verified',
                        style: TextStyle(
                          fontSize: 12,
                          color: LuminaryTheme.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const SectionLabel('Settings'),
          const SizedBox(height: 10),
          _SettingTile(
            icon: Icons.language_rounded,
            title: 'Language',
            trailing: 'Hindi',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _SettingTile(
            icon: Icons.sync_rounded,
            title: 'Up to date',
            subtitle: 'Drafts are safe if you go offline',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _SettingTile(
            icon: Icons.logout_rounded,
            title: 'Log out',
            danger: true,
            onTap: () {
              Session.clear();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailing;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger
        ? LuminaryTheme.terracotta
        : LuminaryTheme.charcoal;

    return Material(
      color: LuminaryTheme.paper,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: LuminaryTheme.line,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: danger
                    ? LuminaryTheme.terracotta
                    : LuminaryTheme.indigo,
                size: 21,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: const TextStyle(
                    color: LuminaryTheme.muted,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HELPERS
// -----------------------------------------------------------------------------

void _note(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    ),
  );
}