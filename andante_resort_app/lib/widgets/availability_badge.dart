import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Room availability badge widget
class AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const AvailabilityBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final Color color = isAvailable ? AppColors.success : AppColors.danger;
    final String label = isAvailable ? 'Available' : 'Fully Booked';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
