import 'package:flutter/material.dart';
import '../models/room.dart';
import '../theme/app_theme.dart';
import '../widgets/availability_badge.dart';

class RoomDetailScreen extends StatefulWidget {
  final Room room;
  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;

    return Scaffold(
      appBar: AppBar(title: Text(room.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PhotoGallery(
              images: room.imageEmojis,
              controller: _pageController,
              currentPage: _currentPage,
              onPageChanged: (i) => setState(() => _currentPage = i),
              height: isWide ? 320 : 220,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepTeal,
                          ),
                        ),
                      ),
                      AvailabilityBadge(isAvailable: room.isAvailable),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${room.rating} · ${room.category.label}'),
                      const Spacer(),
                      Text(
                        '₱${room.pricePerNight.toStringAsFixed(0)}'
                        '${room.category.label == 'Day Tour' ? ' / person' : ' / night'}',
                        style: const TextStyle(
                          color: AppColors.coral,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text(
                    'About this stay',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    room.longDescription,
                    style: const TextStyle(height: 1.5, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Amenities',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: room.amenities
                        .map(
                          (a) => Chip(
                            label: Text(a),
                            backgroundColor: AppColors.sand.withOpacity(0.6),
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Max guests: ${room.maxGuests}',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: room.isAvailable
                          ? () => Navigator.pushNamed(
                              context,
                              '/booking-form',
                              arguments: room,
                            )
                          : null,
                      icon: const Icon(Icons.event_available),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          room.isAvailable ? 'Book Now' : 'Fully Booked',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoGallery extends StatelessWidget {
  final List<String> images;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final double height;

  const _PhotoGallery({
    required this.images,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.teal, AppColors.deepTeal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  images[index],
                  style: const TextStyle(fontSize: 90),
                ),
              );
            },
          ),
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == currentPage ? 18 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == currentPage
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
