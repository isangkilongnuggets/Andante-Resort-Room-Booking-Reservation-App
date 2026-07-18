import 'package:flutter_test/flutter_test.dart';
import 'package:andante_resort_app/models/review.dart';
import 'package:andante_resort_app/services/firestore_service.dart';

void main() {
  group('FirestoreService review ordering', () {
    test('sorts reviews newest first and keeps missing dates at the end', () {
      final reviews = [
        const Review(
          id: 'old',
          roomId: 'room-1',
          roomName: 'Deluxe Room',
          guestName: 'Ana',
          rating: 4,
          comment: 'Older stay',
          createdAt: null,
        ),
        const Review(
          id: 'new',
          roomId: 'room-1',
          roomName: 'Deluxe Room',
          guestName: 'Ben',
          rating: 5,
          comment: 'Newer stay',
          createdAt: null,
        ),
        const Review(
          id: 'missing',
          roomId: 'room-1',
          roomName: 'Deluxe Room',
          guestName: 'Cara',
          rating: 3,
          comment: 'No timestamp',
          createdAt: null,
        ),
      ];

      final sorted = FirestoreService.sortReviews(reviews);

      expect(sorted.first.id, 'new');
      expect(sorted[1].id, 'old');
      expect(sorted.last.id, 'missing');
    });
  });
}
