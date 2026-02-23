import 'package:flutter/material.dart'
    show
        StatefulWidget,
        VoidCallback,
        EdgeInsetsGeometry,
        EdgeInsets,
        State,
        BuildContext,
        Widget,
        SizedBox,
        Icon,
        Size,
        Theme,
        Curves,
        Border,
        BorderRadius,
        BoxDecoration,
        MainAxisAlignment,
        Text,
        Opacity,
        Row,
        Container,
        Padding,
        OutlinedButton,
        Icons,
        Column,
        AnimatedOpacity,
        AnimatedContainer,
        GestureDetector;

import '../../../domain/models/recipes/step.dart';
import 'editable_step_row.dart';

class EditableStepsRows extends StatefulWidget {
  final List<Step> steps;
  final bool canEdit;
  final Function(Step) onDeleteClick;
  final Function(Step) onEditClick;
  final VoidCallback onAddClick;
  final EdgeInsetsGeometry itemPadding;

  const EditableStepsRows({
    super.key,
    required this.steps,
    this.canEdit = false,
    required this.onDeleteClick,
    required this.onEditClick,
    required this.onAddClick,
    this.itemPadding = const EdgeInsets.all(4),
  });

  @override
  State<EditableStepsRows> createState() => _EditableStepsRowsState();
}

class _EditableStepsRowsState extends State<EditableStepsRows> {
  bool _isExpanded = false;

  int _getTotalDuration() {
    return widget.steps.fold(
      0,
      (total, step) => total + step.durationMinutes.ceil(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            // Header row (always visible)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.tertiary, width: 2),
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Instructions count
                  Text(
                    'Instructions (${widget.steps.length})',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                  ),

                  // Total duration
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      '${_getTotalDuration()} min',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Expanded content
            if (_isExpanded)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isExpanded ? 1.0 : 0.0,
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Step rows
                    ...List.generate(widget.steps.length, (index) {
                      return Padding(
                        padding: widget.itemPadding,
                        child: EditableStepRow(
                          stepOrder: index,
                          step: widget.steps[index],
                          canEdit: widget.canEdit,
                          onEditClick: widget.onEditClick,
                          onDeleteClick: widget.onDeleteClick,
                        ),
                      );
                    }),

                    // Add button (if editable)
                    if (widget.canEdit)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: OutlinedButton.icon(
                          onPressed: widget.onAddClick,
                          icon: const Icon(Icons.add),
                          label: Text(
                            'Add Step',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              letterSpacing: 2,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
