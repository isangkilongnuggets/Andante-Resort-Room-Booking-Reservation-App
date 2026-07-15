import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:andante_resort_app/main.dart';
import 'package:andante_resort_app/models/booking_details.dart';
import 'package:andante_resort_app/models/room.dart';
import 'package:andante_resort_app/data/room_data.dart';

void main() {
  testWidgets('Home screen shows resort branding and CTA button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const IslaSerenaApp());

    expect(find.text('ANDANTE RESORT'), findsOneWidget);
    expect(find.text('Browse Rooms & Tours'), findsOneWidget);
  });

  testWidgets(
    'Tapping "Browse Rooms & Tours" navigates to the listings screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(const IslaSerenaApp());

      await tester.tap(find.text('Browse Rooms & Tours'));
      await tester.pumpAndSettle();

      expect(find.text('Rooms & Tours'), findsOneWidget);
      expect(find.text(resortRooms.first.name), findsOneWidget);
    },
  );

  testWidgets('Category filter chips narrow down the room list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const IslaSerenaApp());
    await tester.tap(find.text('Browse Rooms & Tours'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pet-Friendly'));
    await tester.pumpAndSettle();

    final standardOnlyRoom = resortRooms.firstWhere(
      (r) => r.category == RoomCategory.standard,
    );
    expect(find.text(standardOnlyRoom.name), findsNothing);
  });

  testWidgets('Booking form shows a validation error when name is empty', (
    WidgetTester tester,
  ) async {
    final room = resortRooms.firstWhere((r) => r.isAvailable);

    await tester.pumpWidget(const IslaSerenaApp());
    final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
    navigatorState.pushNamed('/booking-form', arguments: room);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirm Booking Request'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a guest name.'), findsOneWidget);
  });

  test('BookingDetails calculates total cost including package surcharge', () {
    final room = resortRooms.first;
    final booking = BookingDetails(
      room: room,
      checkIn: DateTime(2026, 8, 1),
      checkOut: DateTime(2026, 8, 3),
      guestCount: 2,
      package: MealPackage.breakfastIncluded,
      guestName: 'Test Guest',
      confirmationNumber: 'ISR-000000',
    );

    expect(booking.nights, 2);
    expect(
      booking.totalCost,
      (room.pricePerNight + MealPackage.breakfastIncluded.extraPerNight) * 2,
    );
  });
}
