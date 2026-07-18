import 'package:flutter/material.dart';
import '../models/room.dart';
import '../theme/app_theme.dart';
import 'availability_badge.dart';

/// Room card widget for listings
class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const RoomCard({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
              width: double.infinity,
              child: room.imageAssets.isNotEmpty
                  ? Image.asset(
                      room.imageAssets.first,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 110,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          room.imageEmojis.first,
                          style: const TextStyle(fontSize: 44),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        room.imageEmojis.first,
                        style: const TextStyle(fontSize: 44),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        room.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AvailabilityBadge(isAvailable: room.isAvailable),
                  const SizedBox(height: 8),
                  Text(
                    '₱${room.pricePerNight.toStringAsFixed(0)} / night',
                    style: const TextStyle(
                      color: AppColors.coral,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
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
