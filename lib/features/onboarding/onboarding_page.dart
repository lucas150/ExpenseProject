import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      _OnboardSlide(
        icon: Icons.pie_chart,
        title: "Track Expenses",
        description: "Monitor your spending and stay in control.",
      ),
      _OnboardSlide(
        icon: Icons.account_balance_wallet,
        title: "Accounts Optional",
        description: "Add expenses directly, link wallets only if you want.",
      ),
      _OnboardSlide(
        icon: Icons.analytics,
        title: "See Insights",
        description: "Visualize where your money goes each month.",
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (_, i) => pages[i],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/dashboard'),
        label: const Text('Get Started'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class _OnboardSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _OnboardSlide({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
