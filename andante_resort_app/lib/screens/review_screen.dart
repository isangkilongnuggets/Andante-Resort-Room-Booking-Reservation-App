import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/room.dart';
import '../models/review.dart';
import '../services/firestore_service.dart';
import '../theme/app_theme.dart';

/// Guest review submission screen for stay feedback.
class ReviewScreen extends StatefulWidget {
  final Room room;
  final String guestName;

  const ReviewScreen({super.key, required this.room, required this.guestName});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _commentController = TextEditingController();
  int _rating = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating.')),
      );
      return;
    }
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a short review.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await FirestoreService.instance.submitReview(
        roomId: widget.room.id,
        roomName: widget.room.name,
        guestName: widget.guestName.isEmpty ? 'Guest' : widget.guestName,
        rating: _rating,
        comment: _commentController.text.trim(),
      );
      if (!mounted) return;
      _commentController.clear();
      setState(() => _rating = 0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your review!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not submit your review. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;

    return Scaffold(
      appBar: AppBar(title: const Text('Rate Your Stay')),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: isWide ? 64 : 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(widget.room.imageEmojis.first,
                        style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.room.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const Text(
                            'Thanks for staying with us!',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Rate your stay',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (i) {
                final filled = i < _rating;
                return GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      filled ? Icons.star : Icons.star_border,
                      color: filled ? Colors.amber : Colors.black26,
                      size: 34,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            const Text('Your Review',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Tell other guests about your experience...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitReview,
                icon: _isSubmitting
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Icon(Icons.rate_review_outlined),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child:
                      Text(_isSubmitting ? 'Submitting...' : 'Submit Review'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.deepTeal),
                ),
                child: const Text('Back to Home'),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Recent Reviews',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const Divider(height: 24),
            StreamBuilder<List<Review>>(
              stream: FirestoreService.instance.streamReviewsForRoom(
                widget.room.id,
                roomName: widget.room.name,
              ),
              builder: (context, snapshot) {
                final reviews = snapshot.data ?? [];
                if (snapshot.connectionState == ConnectionState.waiting &&
                    reviews.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Unable to load reviews right now.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }
                if (reviews.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'No reviews yet — be the first to share your experience!',
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }
                return Column(
                  children: reviews.map((r) => _ReviewTile(review: r)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final Review review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    final dateStr = review.createdAt != null
        ? DateFormat('MMM d, yyyy').format(review.createdAt!)
        : '';
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.sand,
            child: Text(
              review.guestName.isNotEmpty
                  ? review.guestName[0].toUpperCase()
                  : 'G',
              style: const TextStyle(
                  color: AppColors.deepTeal, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(review.guestName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13.5)),
                    ),
                    if (dateStr.isNotEmpty)
                      Text(dateStr,
                          style: const TextStyle(
                              color: Colors.black45, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < review.rating ? Icons.star : Icons.star_border,
                      size: 14,
                      color: i < review.rating ? Colors.amber : Colors.black26,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(review.comment,
                    style: const TextStyle(fontSize: 13, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
