import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'models/room.dart';
import 'models/booking_details.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/room_listings_screen.dart';
import 'screens/room_detail_screen.dart';
import 'screens/booking_form_screen.dart';
import 'screens/booking_confirmation_screen.dart';
import 'screens/review_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AndanteResortApp());
}

/// App entrypoint and navigation route configuration for the resort app.
class AndanteResortApp extends StatelessWidget {
  const AndanteResortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andante Resort',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const LoginScreen(),
            );
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
          case '/review':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ReviewScreen(
                room: args['room'] as Room,
                guestName: args['guestName'] as String? ?? '',
              ),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const LoginScreen(),
            );
        }
      },
    );
  }
}
