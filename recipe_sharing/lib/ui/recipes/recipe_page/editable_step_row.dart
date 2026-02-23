import 'package:flutter/material.dart'
    show
        StatefulWidget,
        State,
        BuildContext,
        Widget,
        EdgeInsets,
        BoxConstraints,
        Theme,
        Curves,
        Border,
        Colors,
        BorderRadius,
        BoxDecoration,
        MainAxisAlignment,
        FontWeight,
        Text,
        Opacity,
        MainAxisSize,
        Icons,
        Icon,
        IconButton,
        Row,
        Container,
        TextAlign,
        Padding,
        AnimatedOpacity,
        Column,
        AnimatedContainer,
        GestureDetector;

import '../../../domain/models/recipes/step.dart';

class EditableStepRow extends StatefulWidget {
  final int stepOrder;
  final Step step;
  final bool canEdit;
  final Function(Step) onDeleteClick;
  final Function(Step) onEditClick;

  const EditableStepRow({
    super.key,
    required this.stepOrder,
    required this.step,
    this.canEdit = false,
    required this.onDeleteClick,
    required this.onEditClick,
  });

  @override
  State<EditableStepRow> createState() => _EditableStepRowState();
}

class _EditableStepRowState extends State<EditableStepRow> {
  bool _isExpanded = false;

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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isExpanded ? Colors.grey : theme.colorScheme.tertiary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Step order
                  Text(
                    'Step ${widget.stepOrder + 1}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onTertiaryContainer,
                      letterSpacing: 0.1,
                    ),
                  ),

                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      '${widget.step.durationMinutes} min',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onTertiaryContainer,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),

                  if (widget.canEdit)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: theme.colorScheme.secondary,
                          ),
                          onPressed: () => widget.onEditClick(widget.step),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: theme.colorScheme.secondary,
                          ),
                          onPressed: () => widget.onDeleteClick(widget.step),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            if (_isExpanded)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isExpanded ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    widget.step.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
