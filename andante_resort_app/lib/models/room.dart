/// Room model and category definitions.
enum RoomCategory { room, suite }

extension RoomCategoryLabel on RoomCategory {
  String get label {
    switch (this) {
      case RoomCategory.room:
        return 'Room';
      case RoomCategory.suite:
        return 'Suite';
    }
  }
}

/// Room model fields used across listings, detail views, and booking flow.
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
  final List<String> imageAssets;
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
    this.imageAssets = const [],
    required this.rating,
  });
}
