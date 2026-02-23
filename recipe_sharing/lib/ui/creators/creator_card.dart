import 'package:flutter/material.dart';

import '../../domain/models/creators/creator_request.dart';

class CreatorCard extends StatelessWidget {
  final CreatorRequest creator;
  final VoidCallback onTap;
  final VoidCallback onAddToFollows;

  const CreatorCard({
    super.key,
    required this.creator,
    required this.onTap,
    required this.onAddToFollows,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ClipOval(child: const Icon(Icons.person, size: 80)),
            const SizedBox(height: 8),
            Text(
              creator.nickname,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                Text(
                  "${creator.recipesCount} recipes",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "${creator.followersCount} followers",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onAddToFollows,
                  icon: Icon(Icons.bookmark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
