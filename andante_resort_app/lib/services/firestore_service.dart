import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_details.dart';
import '../models/review.dart';

/// Cloud Firestore helper service.
class FirestoreService {
  FirestoreService._();
  static final FirestoreService instance = FirestoreService._();

  final CollectionReference<Map<String, dynamic>> _bookings =
      FirebaseFirestore.instance.collection('bookings');

  final CollectionReference<Map<String, dynamic>> _reviews =
      FirebaseFirestore.instance.collection('reviews');

  /// Save booking records to Firestore.
  Future<void> submitBooking(BookingDetails booking) async {
    await _bookings.add({
      'confirmationNumber': booking.confirmationNumber,
      'roomId': booking.room.id,
      'roomName': booking.room.name,
      'guestName': booking.guestName,
      'checkIn': Timestamp.fromDate(booking.checkIn),
      'checkOut': Timestamp.fromDate(booking.checkOut),
      'guestCount': booking.guestCount,
      'package': booking.package.label,
      'totalCost': booking.totalCost,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Save guest reviews to Firestore.
  Future<void> submitReview({
    required String roomId,
    required String roomName,
    required String guestName,
    required int rating,
    required String comment,
  }) async {
    await _reviews.add({
      'roomId': roomId,
      'roomName': roomName,
      'guestName': guestName.trim().isNotEmpty ? guestName.trim() : 'Guest',
      'rating': rating,
      'comment': comment.trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdAtFallback': DateTime.now().toUtc().toIso8601String(),
    });
  }

  /// Stream reviews filtered by room id or room name.
  Stream<List<Review>> streamReviewsForRoom(String roomId, {String? roomName}) {
    final normalizedRoomId = roomId.trim().toLowerCase();
    final normalizedRoomName = (roomName ?? '').trim().toLowerCase();

    return _reviews.snapshots().map((snapshot) {
      final reviews =
          snapshot.docs.map((doc) => Review.fromFirestore(doc)).where((review) {
        final sameRoomId =
            review.roomId.trim().toLowerCase() == normalizedRoomId;
        final sameRoomName = normalizedRoomName.isNotEmpty &&
            review.roomName.trim().toLowerCase() == normalizedRoomName;
        return sameRoomId || sameRoomName;
      }).toList();

      return sortReviews(reviews);
    });
  }

  static List<Review> sortReviews(List<Review> reviews) {
    final withDate =
        reviews.where((review) => review.createdAt != null).toList()
          ..sort((a, b) {
            final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bDate.compareTo(aDate);
          });

    final withoutDate =
        reviews.where((review) => review.createdAt == null).toList();
    return [...withDate, ...withoutDate];
  }
}
