import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking_details.dart';
import '../theme/app_theme.dart';

/// Screen 5 — Booking Confirmation
///
/// Displays a summary of the reservation along with a confirmation
/// message and a generated confirmation number.
class BookingConfirmationScreen extends StatelessWidget {
  final BookingDetails booking;
  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmed')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 20,
          vertical: 24,
        ),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 72),
            const SizedBox(height: 16),
            const Text(
              'Thank you, your reservation request\nhas been received!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.deepTeal,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Confirmation #${booking.confirmationNumber}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.coral,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SummaryRow(label: 'Guest Name', value: booking.guestName),
                    _SummaryRow(label: 'Room / Tour', value: booking.room.name),
                    _SummaryRow(
                      label: 'Check-in',
                      value: dateFormat.format(booking.checkIn),
                    ),
                    _SummaryRow(
                      label: 'Check-out',
                      value: dateFormat.format(booking.checkOut),
                    ),
                    _SummaryRow(
                      label: 'Nights',
                      value: '${booking.nights == 0 ? 1 : booking.nights}',
                    ),
                    _SummaryRow(label: 'Guests', value: '${booking.guestCount}'),
                    _SummaryRow(label: 'Package', value: booking.package.label),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Estimated Cost',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '₱${booking.totalCost.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppColors.coral,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/'),
                icon: const Icon(Icons.home_outlined),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('Back to Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
