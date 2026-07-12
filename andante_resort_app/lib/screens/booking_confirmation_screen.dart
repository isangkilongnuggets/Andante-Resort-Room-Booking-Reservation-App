import 'package:flutter/material.dart';
import '../models/booking_details.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final BookingDetails booking;
  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmed')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Thank you, ${booking.guestName}! Your booking for '
          '${booking.room.name} is confirmed.',
        ),
      ),
    );
  }
}
