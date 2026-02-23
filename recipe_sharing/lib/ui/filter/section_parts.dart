import 'package:flutter/material.dart';

class SelectionCategoryItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onUnSelect;

  const SelectionCategoryItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onSelect,
    required this.onUnSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.onSurface
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: isSelected
              ? theme.colorScheme.surface
              : theme.colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        ),
        onPressed: isSelected ? onUnSelect : onSelect,
        child: Text(
          text,
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
