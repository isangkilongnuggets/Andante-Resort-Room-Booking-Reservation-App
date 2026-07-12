import 'package:flutter/material.dart';
import '../models/room.dart';
import '../models/booking_details.dart';

class BookingFormScreen extends StatelessWidget {
  final Room room;
  const BookingFormScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Your Stay')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final booking = BookingDetails(
              room: room,
              checkIn: DateTime.now(),
              checkOut: DateTime.now().add(const Duration(days: 1)),
              guestCount: 1,
              package: MealPackage.roomOnly,
              guestName: 'Guest',
              confirmationNumber: 'ISR-000000',
            );
            Navigator.pushNamed(
              context,
              '/booking-confirmation',
              arguments: booking,
            );
          },
          child: const Text('Confirm Booking Request'),
        ),
      ),
    );
  }
}
