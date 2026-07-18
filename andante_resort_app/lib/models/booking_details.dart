import 'room.dart';

/// Booking details model and package helpers.
enum StayPackage { overnightStay, dayTour }

extension StayPackageLabel on StayPackage {
  String get label {
    switch (this) {
      case StayPackage.overnightStay:
        return 'Overnight Stay Package';
      case StayPackage.dayTour:
        return 'Day Tour Package';
    }
  }

  String get description {
    switch (this) {
      case StayPackage.overnightStay:
        return 'Room booking with complimentary themed breakfast and pool access.';
      case StayPackage.dayTour:
        return 'Day-use access to pools, beach, and resort activities — no overnight room.';
    }
  }
}

/// Booking details record used for reservation confirmation.
class BookingDetails {
  final Room room;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guestCount;
  final StayPackage package;
  final String guestName;
  final String confirmationNumber;

  BookingDetails({
    required this.room,
    required this.checkIn,
    required this.checkOut,
    required this.guestCount,
    required this.package,
    required this.guestName,
    required this.confirmationNumber,
  });

  int get nights => checkOut.difference(checkIn).inDays;

  double get totalCost {
    final effectiveNights = nights == 0 ? 1 : nights;
    return room.pricePerNight * effectiveNights;
  }
}
