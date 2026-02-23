import 'package:flutter/material.dart';
import 'package:recipe_sharing/ui/recipes/recipes_screen/difficulty_meter.dart';
import 'package:recipe_sharing/ui/recipes/recipes_screen/rating_row.dart';

import '../../../data/helpers/count_to_formatted_string.dart';
import '../../../domain/models/recipes/recipe.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard>
    with SingleTickerProviderStateMixin {
  bool _openDescription = false;
  late AnimationController _descriptionController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  double _starsSize = 32.0;
  double _meterRadius = 48.0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _descriptionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _descriptionController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _descriptionController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleDescription() {
    setState(() {
      _openDescription = !_openDescription;
      if (_openDescription) {
        _descriptionController.forward();
      } else {
        _descriptionController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localDensity = MediaQuery.of(context).devicePixelRatio;
    final starSizePx = _starsSize + 8;
    final viewsCountStr = widget.recipe.viewsCount.toAmountStringFormatted();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust stars size based on available width
        if (constraints.maxWidth < starSizePx * 5) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _starsSize *= (constraints.maxWidth * 0.8) / (starSizePx * 5);
            });
          });
        }

        // Adjust meter radius based on available width
        final meterRadiusPx = _meterRadius * localDensity;
        if ((meterRadiusPx * 2) / constraints.maxWidth > 0.3) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _meterRadius *=
                  (constraints.maxWidth * 0.25) / (meterRadiusPx * 2);
            });
          });
        }

        return Card(
          elevation: 8,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image section
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        // TODO(add async images)
                        child: Image.asset(
                          'assets/no_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 12,
                      left: 12,
                      child: SizedBox(
                        width: _meterRadius * 2,
                        height: _meterRadius * 2,
                        child: DifficultyMeter(
                          difficulty: widget.recipe.difficulty,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.remove_red_eye,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '($viewsCountStr)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    RatingRow(
                      currentRating: widget.recipe.currentRating,
                      starSize: _starsSize,
                    ),
                    Text(
                      '(${widget.recipe.reviewsCount.toAmountStringFormatted()})',
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onLongPress: _toggleDescription,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 12,
                      bottom: 8,
                    ),
                    child: Text(
                      widget.recipe.recipeName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (_openDescription)
                  SizeTransition(
                    sizeFactor: _slideAnimation,
                    axis: Axis.vertical,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        height: 68,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Text(
                            widget.recipe.description ?? 'No description',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(letterSpacing: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
