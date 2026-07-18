import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:andante_resort_app/main.dart';
import 'package:andante_resort_app/models/booking_details.dart';
import 'package:andante_resort_app/models/room.dart';
import 'package:andante_resort_app/data/room_data.dart';

/// Widget tests for login flow, navigation, listings, and booking validation.
void main() {
  testWidgets('Login screen is the first thing a guest sees',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AndanteResortApp());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Continue as Guest'), findsOneWidget);
  });

  testWidgets('Continuing as a guest reaches the Home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AndanteResortApp());

    await tester.tap(find.text('Continue as Guest'));
    await tester.pumpAndSettle();

    expect(find.text('ANDANTE RESORT'), findsOneWidget);
    expect(find.text('Browse Rooms & Suites'), findsOneWidget);
  });

  testWidgets(
      'Tapping "Browse Rooms & Suites" navigates to the listings screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AndanteResortApp());
    await tester.tap(find.text('Continue as Guest'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Browse Rooms & Suites'));
    await tester.pumpAndSettle();

    expect(find.text('Rooms & Suites'), findsOneWidget);
    // Verify the first room listing appears after navigation.
    expect(find.text(resortRooms.first.name), findsOneWidget);
  });

  testWidgets('Category filter chips narrow down the room list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AndanteResortApp());
    await tester.tap(find.text('Continue as Guest'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse Rooms & Suites'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Suite'));
    await tester.pumpAndSettle();

    final suiteOnlyRoom =
        resortRooms.firstWhere((r) => r.category == RoomCategory.suite);
    expect(find.text(suiteOnlyRoom.name), findsOneWidget);
    final roomOnlyListing =
        resortRooms.firstWhere((r) => r.category == RoomCategory.room);
    expect(find.text(roomOnlyListing.name), findsNothing);
  });

  testWidgets('Booking form shows a validation error when name is empty',
      (WidgetTester tester) async {
    final room = resortRooms.firstWhere((r) => r.isAvailable);

    await tester.pumpWidget(const AndanteResortApp());
    final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
    navigatorState.pushNamed('/booking-form', arguments: room);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirm Booking Request'));
    await tester.pumpAndSettle();

    // Confirm the form shows a validation message when the name field is empty.
    expect(find.text('Please enter a guest name.'), findsOneWidget);
  });

  test('BookingDetails calculates total cost across the stay length', () {
    final room = resortRooms.first;
    final booking = BookingDetails(
      room: room,
      checkIn: DateTime(2026, 8, 1),
      checkOut: DateTime(2026, 8, 3),
      guestCount: 2,
      package: StayPackage.overnightStay,
      guestName: 'Test Guest',
      confirmationNumber: 'AND-000000',
    );

    expect(booking.nights, 2);
    expect(booking.totalCost, room.pricePerNight * 2);
  });
}
