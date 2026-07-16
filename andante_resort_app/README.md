# Andante Resort — Room Booking / Reservation Module

**IT 331: Application Development and Emerging Technologies — Final Project**

A guest-facing Flutter prototype of the guest booking interface for **Andante
Resort** (Brgy. Banoyo, San Luis, Batangas). Guests can browse available
overnight rooms, pet-friendly accommodations, and day-tour packages, then
submit a booking request end-to-end — from browsing to a confirmed
reservation summary.

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
and paddle boarding. This app is a **frontend prototype**: all data is
local/hardcoded (no backend/API) for this course deliverable, but it's
structured so it could later connect to the reservation database described in
the capstone's layered architecture.

## Screens

| # | Screen | Purpose |
|---|--------|---------|
| 1 | **Home / Welcome** | Andante Resort branding, hero banner, quick overview stats, CTA to browse |
| 2 | **Room Listings** | Browse rooms filtered by category (Standard / Pet-Friendly / Day Tour) with availability badges |
| 3 | **Room Detail** | Swipeable photo gallery, full description, price, amenities |
| 4 | **Booking Form** | Guest name, check-in/out date pickers, guest-count stepper, package selection, validation |
| 5 | **Booking Confirmation** | Full reservation summary, generated confirmation number, thank-you message |

## How This Meets the Project Requirements

| Requirement | Implementation |
|---|---|
| **UI/UX Design** | Custom resort color palette (teal / sand / coral), consistent card-based layout, clear visual hierarchy, iconography throughout `lib/theme/app_theme.dart` |
| **Navigation & Routing** | 5 named routes wired through `onGenerateRoute` in `lib/main.dart`, passing typed arguments (`Room`, `BookingDetails`) between screens |
| **Data Handling** | Local hardcoded dataset (`lib/data/room_data.dart`) reflecting Andante Resort's actual rooms and day-tour packages; fetched, filtered (by category), and displayed across screens; booking data flows from form → confirmation |
| **Forms** | `Form` + `TextFormField` with validators, `showDatePicker` for check-in/out, `RadioListTile` package selection, inline guest-count stepper — all validated before submission |
| **Gestures** | Tap (room cards, chips, buttons), scroll (listings grid, detail page), swipe (`PageView` photo gallery on Room Detail) |
| **Responsiveness** | `LayoutBuilder`/`MediaQuery`-driven column counts and paddings so layouts adapt across phone and tablet widths, in both listings grid and detail/form screens |
| **Widgets & Components variety** | `GridView`, `PageView`, `Card`, `ChoiceChip`, `RadioListTile`, `Chip`, `AnimatedContainer`, `RefreshIndicator`, custom widgets (`RoomCard`, `AvailabilityBadge`) |
| **Theming** | Centralized `ThemeData` in `AppTheme` — consistent buttons, inputs, app bars, cards |
| **Unit Testing** | `test/widget_test.dart` covers navigation, category filtering, form validation, and booking cost calculation |

## Project Structure

```
andante_resort_app/
├── lib/
│   ├── main.dart                     # App entry point + named route table
│   ├── theme/
│   │   └── app_theme.dart            # Resort color palette + ThemeData
│   ├── models/
│   │   ├── room.dart                 # Room data model + category enum
│   │   └── booking_details.dart      # Booking form result model
│   ├── data/
│   │   └── room_data.dart            # Local hardcoded Andante Resort room/tour dataset
│   ├── widgets/
│   │   ├── room_card.dart            # Reusable room/tour card
│   │   └── availability_badge.dart   # Available / Fully Booked pill
│   └── screens/
│       ├── home_screen.dart
│       ├── room_listings_screen.dart
│       ├── room_detail_screen.dart
│       ├── booking_form_screen.dart
│       └── booking_confirmation_screen.dart
├── test/
│   └── widget_test.dart              # Unit / widget tests
├── pubspec.yaml
└── README.md
```

## Getting Started

1. Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (Flutter 3.19+ recommended).
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on a connected device or emulator:
   ```bash
   flutter run
   ```
4. Run the test suite:
   ```bash
   flutter test
   ```

## Tech Stack

- **Flutter** (Material 3)
- **Dart**
- `intl` — date formatting
- Local in-memory data (no backend required for this prototype)

## Notes for the Instructor

- No PowerPoint presentation is included, per the final project guidelines.
- All room/tour data is hardcoded locally in `lib/data/room_data.dart`,
  modeled on Andante Resort's actual rooms and day-tour packages, for demo
  purposes — swapping in a live API would only require changing that one
  file and how it's consumed.
- Booking submissions are not persisted (no backend); the "Booking
  Confirmation" screen displays the data captured in-memory from the form.

## Proponents

- Carl Ashton T. Villalobos
- Frankin C. Dela Torre
- Kier H. Alvaira

*Bachelor of Science in Information Technology (Business Analytics Track),
College of Informatics and Computing Sciences*
