import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroBanner(isWide: isWide),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 48 : 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to Andante Resort',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.deepTeal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Located in Brgy. Banoyo, San Luis, Batangas, '
                      'Andante Resort offers cozy overnight rooms, '
                      'pet-friendly accommodations, and day-tour packages '
                      'complete with free snorkeling and paddle boarding. '
                      'Browse what\'s available and reserve your stay in '
                      'just a few taps.',
                      style: TextStyle(fontSize: 15, height: 1.4),
                    ),
                    const SizedBox(height: 24),
                    _QuickOverviewRow(isWide: isWide),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/listings'),
                        icon: const Icon(Icons.explore),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text('Browse Rooms & Tours'),
                        ),
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

class _HeroBanner extends StatelessWidget {
  final bool isWide;
  const _HeroBanner({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isWide ? 260 : 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.deepTeal, AppColors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            right: 24,
            child: Opacity(
              opacity: 0.25,
              child: Text('🌴', style: TextStyle(fontSize: isWide ? 90 : 60)),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 24,
            child: Opacity(
              opacity: 0.25,
              child: Text('🌊', style: TextStyle(fontSize: isWide ? 90 : 60)),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🏝️', style: TextStyle(fontSize: 46)),
              const SizedBox(height: 8),
              Text(
                'ANDANTE RESORT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWide ? 30 : 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'San Luis, Batangas — your escape, one tap away',
                style: TextStyle(color: AppColors.sand, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickOverviewRow extends StatelessWidget {
  final bool isWide;
  const _QuickOverviewRow({required this.isWide});

  @override
  Widget build(BuildContext context) {
    final stats = const [
      (icon: Icons.hotel, label: '16 Rooms Available'),
      (icon: Icons.pets, label: 'Pet-Friendly Stays'),
      (icon: Icons.pool, label: 'Free Snorkeling & SUP'),
    ];

    return Row(
      children: stats
          .map(
            (s) => Expanded(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Icon(
                        s.icon,
                        color: AppColors.coral,
                        size: isWide ? 30 : 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        s.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
