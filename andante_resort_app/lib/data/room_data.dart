import '../models/room.dart';

final List<Room> resortRooms = [
  const Room(
    id: 'std-001',
    name: 'Garden View Standard Room',
    category: RoomCategory.standard,
    pricePerNight: 2500,
    maxGuests: 2,
    isAvailable: true,
    shortDescription:
        'Cozy overnight room with garden views and free breakfast.',
    longDescription:
        'A comfortable, air-conditioned room with a queen bed overlooking '
        'the resort garden. Includes complimentary breakfast with rotating '
        'Filipino, Western, and Korean themed dishes, plus free access to '
        'the swimming pools and sunbeds during your stay.',
    amenities: [
      'Air Conditioning',
      'Free Wi-Fi',
      'Complimentary Breakfast',
      'Pool Access',
    ],
    imageEmojis: ['🏡', '🛏️', '🌿'],
    rating: 4.5,
  ),
  const Room(
    id: 'std-002',
    name: 'Deluxe Poolside Room',
    category: RoomCategory.standard,
    pricePerNight: 3800,
    maxGuests: 3,
    isAvailable: true,
    shortDescription: 'Steps away from the pool and sunbed area.',
    longDescription:
        'Our most requested overnight room, located just steps from the '
        'main swimming pool and sunbed lounge area. Features a king-sized '
        'bed, a private veranda, and complimentary themed breakfast served '
        'daily at the resort\'s dining area.',
    amenities: [
      'Poolside Location',
      'King Bed',
      'Free Wi-Fi',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['🏊', '🛏️', '🍳'],
    rating: 4.8,
  ),
  const Room(
    id: 'std-003',
    name: 'Family Room',
    category: RoomCategory.standard,
    pricePerNight: 5500,
    maxGuests: 6,
    isAvailable: false,
    shortDescription: 'Spacious room for families near the dining area.',
    longDescription:
        'A spacious overnight room designed for families or barkada '
        'groups, located close to the resort\'s dining area and swimming '
        'pools. Includes complimentary themed breakfast for all guests and '
        'easy access to shared amenities.',
    amenities: [
      'Extra Beds Available',
      'Near Dining Area',
      'Free Wi-Fi',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['👨‍👩‍👧‍👦', '🛋️', '🍽️'],
    rating: 4.6,
  ),
  const Room(
    id: 'pet-001',
    name: 'Pet-Friendly Garden Room',
    category: RoomCategory.petFriendly,
    pricePerNight: 3200,
    maxGuests: 3,
    isAvailable: true,
    shortDescription: 'An overnight room where your pet is welcome too.',
    longDescription:
        'A ground-floor pet-friendly room with easy outdoor access to the '
        'garden area. Perfect for guests bringing along their furry '
        'companions. Includes complimentary themed breakfast and access '
        'to the resort\'s swimming pools (leashed pets only in common '
        'areas).',
    amenities: [
      'Pet-Friendly',
      'Ground Floor',
      'Free Wi-Fi',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['🐾', '🏕️', '🐕'],
    rating: 4.7,
  ),
  const Room(
    id: 'pet-002',
    name: 'Pet-Friendly Poolside Cabin',
    category: RoomCategory.petFriendly,
    pricePerNight: 4300,
    maxGuests: 4,
    isAvailable: true,
    shortDescription: 'Pet-friendly cabin close to the pool and sunbeds.',
    longDescription:
        'Our premium pet-friendly option, located near the pool and '
        'sunbed area with a private outdoor space for your pet to relax. '
        'Includes complimentary themed breakfast and priority seating at '
        'the dining area.',
    amenities: [
      'Pet-Friendly',
      'Poolside Location',
      'Private Outdoor Space',
      'Complimentary Breakfast',
    ],
    imageEmojis: ['🏖️', '🐶', '🌅'],
    rating: 4.9,
  ),
  const Room(
    id: 'day-001',
    name: 'Day Tour: Pool & Beach Access',
    category: RoomCategory.dayTour,
    pricePerNight: 500,
    maxGuests: 10,
    isAvailable: true,
    shortDescription: 'Full-day access to the pools, sunbeds, and dining area.',
    longDescription:
        'A relaxed day-tour package for visitors who want to enjoy the '
        'resort without an overnight stay. Includes full-day access to '
        'the swimming pools, sunbeds, and dining area, plus free use of '
        'snorkeling gear along the resort\'s waterfront.',
    amenities: [
      'Pool Access',
      'Sunbeds',
      'Free Snorkeling Gear',
      'Dining Access',
    ],
    imageEmojis: ['🏝️', '🏊', '🤿'],
    rating: 4.8,
  ),
  const Room(
    id: 'day-002',
    name: 'Day Tour: Snorkel & Paddleboard Adventure',
    category: RoomCategory.dayTour,
    pricePerNight: 650,
    maxGuests: 12,
    isAvailable: false,
    shortDescription: 'Guided snorkeling and paddle boarding for the day.',
    longDescription:
        'An activity-focused day tour combining free snorkeling and paddle '
        'boarding sessions along the resort\'s waterfront, plus full access '
        'to the pools and dining area in between activities. Great for '
        'groups looking for a more active visit.',
    amenities: [
      'Free Snorkeling',
      'Free Paddle Boarding',
      'Pool Access',
      'Dining Access',
    ],
    imageEmojis: ['🏄', '🌊', '🤿'],
    rating: 4.4,
  ),
];
