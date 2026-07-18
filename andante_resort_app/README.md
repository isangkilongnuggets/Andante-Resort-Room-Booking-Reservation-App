# Andante Resort — Room Booking / Reservation Module

**IT 331: Application Development and Emerging Technologies — Final Project**

A guest-facing Flutter app for **Andante Resort** (Brgy. Banoyo, San Luis,
Batangas). Guests sign in, browse available overnight rooms, pet-friendly
accommodations, and day-tour packages, submit a booking request, and leave a
review — with bookings, reviews, and authentication now backed by **Firebase**
(Cloud Firestore + Firebase Auth) instead of purely local data.

This module also serves as the **frontend prototype for the guest-facing
side** of the group's proposed capstone system, *AI-Enhanced Resort
Analytics and Reservation Management System for Andante Resort* (see the
Topic Abstract Form). The full capstone system additionally covers AI-driven
analytics, a management dashboard, and predictive forecasting — this Flutter
module focuses specifically on the **guest reservation experience**.

---

## Overview

Andante Resort accommodates both overnight-stay and day-tour visitors across
16 rooms, with amenities including swimming pools, sunbeds, dining areas, and
pet-friendly rooms. Guests enjoy complimentary breakfast (rotating Filipino,
Western, and Korean themed dishes) with overnight stays, plus free snorkeling
and paddle boarding.

Room/tour listings are still local, hardcoded data (`lib/data/room_data.dart`)
for simplicity, but **bookings, reviews, and user accounts are now real,
cloud-persisted data** via Firebase — not just in-memory state.

## Screens

| # | Screen | Purpose |
|---|--------|---------|
| 1 | **Login / Sign Up** | Firebase Auth (email/password) sign-in and account creation, with a "Continue as Guest" option |
| 2 | **Home / Welcome** | Andante Resort branding, hero banner, quick overview stats, CTA to browse |
| 3 | **Room Listings** | Browse rooms filtered by category (Standard / Pet-Friendly / Day Tour) with availability badges |
| 4 | **Room Detail** | Swipeable photo gallery, full description, price, amenities |
| 5 | **Booking Form** | Guest name, check-in/out date pickers, guest-count stepper, package selection, validation — saved to Firestore on submit |
| 6 | **Booking Confirmation** | Full reservation summary, generated confirmation number, thank-you message |
| 7 | **Rate Your Stay (Review)** | Star rating + written review, saved to Firestore; live-streamed list of recent reviews for that room/tour |

## Firebase Setup

This app needs a real Firebase project to run — `lib/firebase_options.dart`
in this repo is a **placeholder** and must be regenerated for your own
project before `flutter run` will work.

### 1. Create the Firebase project
1. Go to the [Firebase Console](https://console.firebase.google.com/) and
   create a new project (e.g. `andante-resort`).
2. In **Build → Authentication → Sign-in method**, enable **Email/Password**.
3. In **Build → Firestore Database**, click **Create database** and start
   in **test mode** (fine for a course project — see the note on security
   rules below).

### 2. Generate platform folders (if not already present)
This repo ships as `lib/` + `pubspec.yaml` only. If your local checkout has
no `android/`, `ios/`, or `web/` folders yet, generate them once:
```bash
flutter create .
```
This won't overwrite your existing `lib/` code — it just fills in the
missing platform scaffolding Firebase needs to hook into.

### 3. Connect the app to your Firebase project
```bash
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
```
Pick your Firebase project and the platforms you're targeting (Android/iOS/
Web). This **overwrites `lib/firebase_options.dart`** with your project's
real values and adds `google-services.json` / `GoogleService-Info.plist`
automatically. Commit those generated files along with everything else —
for a client app like this, they aren't secrets (access is controlled by
Firestore/Auth security rules, not by hiding these files).

### 4. Install dependencies and run
```bash
flutter pub get
flutter run
```

### On Firestore security rules
Test mode leaves the database open to anyone for 30 days, which is fine
while developing, but for your submission consider tightening it, e.g.:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /bookings/{bookingId} {
      allow read, write: if true; // demo-only — tighten before real use
    }
    match /reviews/{reviewId} {
      allow read: if true;
      allow write: if request.resource.data.rating is int
                   && request.resource.data.rating >= 1
                   && request.resource.data.rating <= 5;
    }
  }
}
```

## How This Meets the Project Requirements

| Requirement | Implementation |
|---|---|
| **UI/UX Design** | Custom resort color palette (teal / sand / coral), consistent card-based layout, clear visual hierarchy, iconography throughout `lib/theme/app_theme.dart` |
| **Navigation & Routing** | 7 named routes wired through `onGenerateRoute` in `lib/main.dart`, passing typed arguments (`Room`, `BookingDetails`, review payload) between screens |
| **Data Handling** | Local hardcoded room/tour catalog (`lib/data/room_data.dart`) combined with **real Cloud Firestore reads/writes** for bookings and reviews (`lib/services/firestore_service.dart`), plus **Firebase Auth** for accounts (`lib/services/auth_service.dart`) |
| **Forms** | `Form` + `TextFormField` with validators on Login/Sign Up and Booking Form, `showDatePicker`, `RadioListTile` package selection, tappable star rating on the Review screen |
| **Gestures** | Tap (room cards, chips, stars, buttons), scroll (listings grid, detail page, review list), swipe (`PageView` photo gallery on Room Detail) |
| **Responsiveness** | `MediaQuery`-driven column counts and paddings so layouts adapt across phone and tablet widths |
| **Widgets & Components variety** | `GridView`, `PageView`, `StreamBuilder`, `Card`, `ChoiceChip`, `RadioListTile`, `Chip`, `CircleAvatar`, `CircularProgressIndicator`, custom widgets (`RoomCard`, `AvailabilityBadge`) |
| **Theming** | Centralized `ThemeData` in `AppTheme` — consistent buttons, inputs, app bars, cards |
| **Unit Testing** | `test/widget_test.dart` covers navigation, category filtering, form validation, and booking cost calculation (Firebase-dependent flows are noted as manually verified — see the file's header comment) |

## Project Structure

```
andante_resort_app/
├── lib/
│   ├── main.dart                        # Firebase init + named route table
│   ├── firebase_options.dart            # placeholder — regenerate with flutterfire configure
│   ├── theme/
│   │   └── app_theme.dart               # Resort color palette + ThemeData
│   ├── models/
│   │   ├── room.dart                    # Room data model + category enum
│   │   ├── booking_details.dart         # Booking form result model
│   │   └── review.dart                  # Review model (Firestore (de)serialization)
│   ├── data/
│   │   └── room_data.dart               # Local hardcoded Andante Resort room/tour dataset
│   ├── services/
│   │   ├── auth_service.dart            # Firebase Auth wrapper (sign in / sign up / sign out)
│   │   └── firestore_service.dart       # Cloud Firestore wrapper (bookings + reviews)
│   ├── widgets/
│   │   ├── room_card.dart               # Reusable room/tour card
│   │   └── availability_badge.dart      # Available / Fully Booked pill
│   └── screens/
│       ├── login_screen.dart            # Firebase Auth sign-in / sign-up
│       ├── home_screen.dart
│       ├── room_listings_screen.dart
│       ├── room_detail_screen.dart
│       ├── booking_form_screen.dart      # Now saves bookings to Firestore
│       ├── booking_confirmation_screen.dart
│       └── review_screen.dart            # Star rating + review, live Firestore stream
├── test/
│   └── widget_test.dart                 # Unit / widget tests
├── pubspec.yaml
└── README.md
```

## Getting Started

1. Complete the **Firebase Setup** section above first — the app will not
   run without a configured Firebase project.
2. Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (Flutter 3.19+ recommended).
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app on a connected device or emulator:
   ```bash
   flutter run
   ```
5. Run the test suite:
   ```bash
   flutter test
   ```

## Tech Stack

- **Flutter** (Material 3)
- **Dart**
- **Firebase Auth** — email/password sign-in and account creation
- **Cloud Firestore** — bookings and reviews, including a live-updating review stream
- `intl` — date formatting

## Notes for the Instructor

- No PowerPoint presentation is included, per the final project guidelines.
- Room/tour catalog data is still hardcoded locally in `lib/data/room_data.dart`
  for simplicity; bookings and reviews are the parts wired to a real backend.
- `lib/firebase_options.dart` in this submission is a placeholder with fake
  keys — the real one (generated by `flutterfire configure` against our own
  Firebase project) is what actually ships/runs. This is intentional and
  documented above, not an oversight.
- "Continue as Guest" on the Login screen skips Firebase Auth entirely (it's
  there so the rest of the app can still be explored/graded even if Firebase
  Auth isn't configured on a given machine) — bookings and reviews still go
  to Firestore either way.

## Proponents

- Carl Ashton T. Villalobos (isangkilongnuggets)
- Frankin C. Dela Torre (ASHTON2020)
- Kier H. Alvaira (AlvairaKier)

