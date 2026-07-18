import 'package:cloud_firestore/cloud_firestore.dart';

/// Guest review model
class Review {
  final String id;
  final String roomId;
  final String roomName;
  final String guestName;
  final int rating;  // rating
  final String comment;
  final DateTime? createdAt;

  const Review({
    required this.id,
    required this.roomId,
    required this.roomName,
    required this.guestName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final ts = data['createdAt'];
    DateTime? createdAt;

    if (ts is Timestamp) {
      createdAt = ts.toDate();
    } else if (ts is String) {
      createdAt = DateTime.tryParse(ts);
    } else if (data['createdAtFallback'] is String) {
      createdAt = DateTime.tryParse(data['createdAtFallback'] as String);
    }

    return Review(
      id: doc.id,
      roomId: data['roomId'] as String? ?? '',
      roomName: data['roomName'] as String? ?? '',
      guestName: data['guestName'] as String? ?? 'Guest',
      rating: (data['rating'] as num?)?.toInt() ?? 0,
      comment: data['comment'] as String? ?? '',
      createdAt: createdAt,
    );
  }
}
