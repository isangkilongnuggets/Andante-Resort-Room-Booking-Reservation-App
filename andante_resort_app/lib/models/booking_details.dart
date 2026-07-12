import 'room.dart';

enum MealPackage { roomOnly, breakfastIncluded, fullBoard }

extension MealPackageLabel on MealPackage {
  String get label {
    switch (this) {
      case MealPackage.roomOnly:
        return 'Room Only';
      case MealPackage.breakfastIncluded:
        return 'Breakfast Included';
      case MealPackage.fullBoard:
        return 'Full Board (All Meals)';
    }
  }

  double get extraPerNight {
    switch (this) {
      case MealPackage.roomOnly:
        return 0;
      case MealPackage.breakfastIncluded:
        return 350;
      case MealPackage.fullBoard:
        return 900;
    }
  }
}

/// Carries the completed booking form data to the confirmation screen.
class BookingDetails {
  final Room room;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guestCount;
  final MealPackage package;
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
    final nightlyTotal = room.pricePerNight + package.extraPerNight;
    return nightlyTotal * effectiveNights;
  }
}
