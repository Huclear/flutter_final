import 'package:flutter/material.dart';

import '../../../domain/models/recipes/ingredient.dart';

class IngredientCell extends StatelessWidget {
  final Ingredient ingredient;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;

  const IngredientCell({
    super.key,
    required this.ingredient,
    this.onEdit,
    this.onDelete,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Main ingredient row
        Expanded(
          child: Row(
            children: [
              // Ingredient name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  ingredient.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ),

              // Amount and unit row
              Row(
                children: [
                  // Amount with parentheses
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '(${ingredient.amount.toStringAsFixed(2)})',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ),

                  // Unit (short name)
                  Text(
                    ingredient.measureType.shortName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (showActions) ...[
          if (onEdit != null)
            IconButton(
              icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: Icon(Icons.delete, color: theme.colorScheme.secondary),
              onPressed: onDelete,
            ),
        ],
      ],
    );
  }
}
