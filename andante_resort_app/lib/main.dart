import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'models/room.dart';
import 'models/booking_details.dart';
import 'screens/home_screen.dart';
import 'screens/room_listings_screen.dart';
import 'screens/room_detail_screen.dart';
import 'screens/booking_form_screen.dart';
import 'screens/booking_confirmation_screen.dart';

void main() {
  runApp(const IslaSerenaApp());
}

class IslaSerenaApp extends StatelessWidget {
  const IslaSerenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andante Resort',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomeScreen(),
            );
          case '/listings':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const RoomListingsScreen(),
            );
          case '/room-detail':
            final room = settings.arguments as Room;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => RoomDetailScreen(room: room),
            );
          case '/booking-form':
            final room = settings.arguments as Room;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => BookingFormScreen(room: room),
            );
          case '/booking-confirmation':
            final booking = settings.arguments as BookingDetails;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => BookingConfirmationScreen(booking: booking),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomeScreen(),
            );
        }
      },
    );
  }
}
