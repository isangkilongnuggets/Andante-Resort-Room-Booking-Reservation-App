import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Home screen and resort navigation entry point.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroBanner(isWide: isWide),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 48 : 20,
                  vertical: 28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
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
                            const SizedBox(height: 12),
                            const Text(
                              'Located in Brgy. Banoyo, San Luis, Batangas, '
                              'Andante Resort offers cozy overnight rooms, '
                              'stylish rooms and suites complete with resort comforts. '
                              'Browse what\'s available and reserve your stay in '
                              'just a few taps.',
                              style: TextStyle(fontSize: 15, height: 1.4),
                            ),
                            const SizedBox(height: 28),
                            _QuickOverviewRow(isWide: isWide),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/listings'),
                        icon: const Icon(Icons.explore),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text('Browse Rooms & Suites'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
      height: isWide ? 300 : 240,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B4F6C), Color(0xFF1E88E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: isWide ? 110 : 86,
                height: isWide ? 110 : 86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    width: isWide ? 110 : 86,
                    height: isWide ? 110 : 86,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'ANDANTE RESORT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWide ? 30 : 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
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
    const stats = [
      (icon: Icons.king_bed, label: 'Rooms & Suites'),
      (icon: Icons.beach_access, label: 'Sea View Stays'),
      (icon: Icons.pool, label: 'Resort Amenities'),
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
                      Icon(s.icon,
                          color: AppColors.coral, size: isWide ? 30 : 24),
                      const SizedBox(height: 10),
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
