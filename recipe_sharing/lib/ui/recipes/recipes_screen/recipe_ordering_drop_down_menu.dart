import 'package:flutter/material.dart';

import '../../../domain/models/filters/recipe_ordering.dart';

class RecipeOrderingDropDownMenu extends StatelessWidget {
  final VoidCallback onDismissRequest;
  final Function(RecipeOrdering) onSelectOrdering;
  final RecipeOrdering? selectedOrder;
  final bool isAscending;
  final bool expanded;

  const RecipeOrderingDropDownMenu({
    super.key,
    required this.onDismissRequest,
    required this.onSelectOrdering,
    this.selectedOrder,
    required this.isAscending,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<RecipeOrdering>(
      value: selectedOrder,
      isExpanded: true,
      onChanged: (RecipeOrdering? newValue) {
        if (newValue != null) {
          onSelectOrdering(newValue);
        }
      },
      items: RecipeOrdering.values.map((ordering) {
        return DropdownMenuItem<RecipeOrdering>(
          value: ordering,
          child: Text(ordering.name), // enum name
        );
      }).toList(),
    );
  }
}
