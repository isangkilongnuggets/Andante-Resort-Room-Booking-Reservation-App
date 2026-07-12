enum RoomCategory { standard, petFriendly, dayTour }

extension RoomCategoryLabel on RoomCategory {
  String get label {
    switch (this) {
      case RoomCategory.standard:
        return 'Standard';
      case RoomCategory.petFriendly:
        return 'Pet-Friendly';
      case RoomCategory.dayTour:
        return 'Day Tour';
    }
  }
}

class Room {
  final String id;
  final String name;
  final RoomCategory category;
  final double pricePerNight;
  final int maxGuests;
  final bool isAvailable;
  final String shortDescription;
  final String longDescription;
  final List<String> amenities;
  final List<String> imageEmojis;
  final double rating;

  const Room({
    required this.id,
    required this.name,
    required this.category,
    required this.pricePerNight,
    required this.maxGuests,
    required this.isAvailable,
    required this.shortDescription,
    required this.longDescription,
    required this.amenities,
    required this.imageEmojis,
    required this.rating,
  });
}
