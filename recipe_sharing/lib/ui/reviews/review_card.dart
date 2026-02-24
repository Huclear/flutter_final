import 'package:flutter/material.dart';
import '../../domain/models/reviews/review_model.dart';
import '../recipes/recipes_screen/rating_row.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    review.userName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            RatingRow(currentRating: review.rating.toDouble(), starSize: 24),

            const SizedBox(height: 12),

            Text(
              review.text,
              style: theme.textTheme.bodyLarge?.copyWith(
                letterSpacing: 1.5,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
