import '../models/room.dart';

/// Local room catalog used by listings and room detail pages.
final List<Room> resortRooms = [
  const Room(
    id: 'room-001',
    name: 'Standard King Room',
    category: RoomCategory.room,
    pricePerNight: 5500,
    maxGuests: 2,
    isAvailable: true,
    shortDescription:
        'A bright, restful room with a king bed and comfort essentials.',
    longDescription:
        'A comfortable room designed for couples or solo travelers, featuring '
        'a king-sized bed, premium linens, and a calm interior with ocean '
        'views. Enjoy complimentary breakfast and easy access to the pool.',
    amenities: [
      'King Bed',
      'Air Conditioning',
      'Free Wi-Fi',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['🛏️', '🌊', '☀️'],
    imageAssets: [
      'assets/images/standard_king_room_1.jpg',
      'assets/images/standard_king_room_2.jpg',
      'assets/images/standard_king_room_3.jpg',
      'assets/images/standard_king_room_4.jpg',
      'assets/images/standard_king_room_5.jpg',
      'assets/images/standard_king_room_6.jpg',
      'assets/images/standard_king_room_7.jpg',
    ],
    rating: 4.7,
  ),
  const Room(
    id: 'room-002',
    name: 'Deluxe Room',
    category: RoomCategory.room,
    pricePerNight: 6100,
    maxGuests: 2,
    isAvailable: true,
    shortDescription:
        'Elevated comfort with a private lounge and poolside access.',
    longDescription:
        'Our deluxe room offers more space, a cozy lounge corner, and a '
        'fresh coastal design. It is well suited for families or guests who '
        'want a little extra room to unwind after a day at the resort.',
    amenities: [
      'Lounge Corner',
      'Poolside Access',
      'Free Wi-Fi',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['🛋️', '🏖️', '🌿'],
    imageAssets: [
      'assets/images/deluxe_room_1.jpg',
      'assets/images/deluxe_room_2.jpg',
      'assets/images/deluxe_room_3.jpg',
      'assets/images/deluxe_room_4.jpg',
      'assets/images/deluxe_room_5.jpg',
      'assets/images/deluxe_room_6.jpg',
      'assets/images/deluxe_room_7.jpg',
      'assets/images/deluxe_room_8.jpg',
      'assets/images/deluxe_room_9.jpg',
      'assets/images/deluxe_room_10.jpg',
    ],
    rating: 4.8,
  ),
  const Room(
    id: 'room-003',
    name: 'Quadruple Room with Sea View',
    category: RoomCategory.room,
    pricePerNight: 7800,
    maxGuests: 8,
    isAvailable: true,
    shortDescription:
        'A spacious sea-view stay perfect for groups and family getaways.',
    longDescription:
        'This generous family room features a beautiful sea view, extra beds, '
        'and ample space for a shared stay. It is ideal for groups looking for '
        'a comfortable base with resort amenities just steps away.',
    amenities: [
      'Sea View',
      'Extra Beds',
      'Free Wi-Fi',
      'Pool Access',
    ],
    imageEmojis: ['👨‍👩‍👧‍👦', '🌅', '🛏️'],
    imageAssets: [
      'assets/images/quadruple_room_with_sea_view_1.jpg',
      'assets/images/quadruple_room_with_sea_view_2.jpg',
      'assets/images/quadruple_room_with_sea_view_3.jpg',
      'assets/images/quadruple_room_with_sea_view_4.jpg',
      'assets/images/quadruple_room_with_sea_view_5.jpg',
      'assets/images/quadruple_room_with_sea_view_6.jpg',
      'assets/images/quadruple_room_with_sea_view_7.jpg',
      'assets/images/quadruple_room_with_sea_view_8.jpg',
      'assets/images/quadruple_room_with_sea_view_9.jpg',
      'assets/images/quadruple_room_with_sea_view_10.jpg',
      'assets/images/quadruple_room_with_sea_view_11.jpg',
      'assets/images/quadruple_room_with_sea_view_12.jpg',
      'assets/images/quadruple_room_with_sea_view_13.jpg',
      'assets/images/quadruple_room_with_sea_view_14.jpg',
    ],
    rating: 4.9,
  ),
  const Room(
    id: 'suite-001',
    name: 'Family Suite',
    category: RoomCategory.suite,
    pricePerNight: 8900,
    maxGuests: 4,
    isAvailable: true,
    shortDescription:
        'A premium suite with a separate lounge area for family comfort.',
    longDescription:
        'The family suite brings together premium design, a private lounge, '
        'and enough space for the whole family to settle in comfortably. '
        'Enjoy a more elevated stay with resort breakfast and easy pool access.',
    amenities: [
      'Separate Lounge',
      'Family Friendly',
      'Free Wi-Fi',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['🏡', '🛋️', '👨‍👩‍👧‍👦'],
    imageAssets: [
      'assets/images/family_suite_1.jpg',
      'assets/images/family_suite_2.jpg',
      'assets/images/family_suite_3.jpg',
      'assets/images/family_suite_4.jpg',
      'assets/images/family_suite_5.jpg',
      'assets/images/family_suite_6.jpg',
    ],
    rating: 4.9,
  ),
];
