import 'package:flutter/material.dart'
    show
        ElevatedButton,
        RoundedRectangleBorder,
        StatefulWidget,
        VoidCallback,
        State,
        TextEditingController,
        BuildContext,
        Widget,
        EdgeInsets,
        SizedBox,
        OutlineInputBorder,
        Theme,
        MainAxisSize,
        Colors,
        BorderSide,
        Border,
        BoxDecoration,
        TextAlign,
        Text,
        Container,
        InputDecoration,
        TextField,
        TextInputType,
        BorderRadius,
        Expanded,
        Row,
        Column,
        Dialog;
import 'package:flutter/services.dart';

import '../../../domain/models/recipes/step.dart';
import '../../../domain/models/validation_info.dart';

class StepConfigureDialog extends StatefulWidget {
  final Step step;
  final VoidCallback onDismissRequest;
  final Function(Step) onSaveChanges;

  const StepConfigureDialog({
    super.key,
    required this.step,
    required this.onDismissRequest,
    required this.onSaveChanges,
  });

  @override
  State<StepConfigureDialog> createState() => _StepConfigureDialogState();
}

class _StepConfigureDialogState extends State<StepConfigureDialog> {
  late Step _stepState;
  late TextEditingController _durationController;
  late TextEditingController _descriptionController;

  ValidationInfo _durationError = ValidationInfo(isValid: true);
  ValidationInfo _descriptionError = ValidationInfo(isValid: true);

  @override
  void initState() {
    super.initState();
    _stepState = widget.step;
    _durationController = TextEditingController(
      text: _stepState.durationMinutes.toString(),
    );
    _descriptionController = TextEditingController(
      text: _stepState.description,
    );

    _durationController.addListener(_validateDuration);
    _descriptionController.addListener(_validateDescription);

    _validateDuration();
    _validateDescription();
  }

  void _validateDuration() {
    final input = _durationController.text;
    setState(() {
      if (input.isEmpty) {
        _durationError = ValidationInfo(
          isValid: false,
          error: 'Field cannot be empty',
        );
      } else if (input.length > 5) {
        _durationError = ValidationInfo(
          isValid: false,
          error: 'Length should be 1-5 digits',
        );
      } else if (!RegExp(r'^\d+$').hasMatch(input)) {
        _durationError = ValidationInfo(
          isValid: false,
          error: 'Must contain only numbers',
        );
      } else {
        final value = int.tryParse(input) ?? 0;
        if (value <= 0) {
          _durationError = ValidationInfo(
            isValid: false,
            error: 'Invalid format',
          );
        } else {
          _durationError = ValidationInfo(isValid: true);
        }
      }
    });
  }

  void _validateDescription() {
    final input = _descriptionController.text;
    final RegExp validRegex = RegExp(
      r'^[A-Za-zА-Яа-я0-9][A-Za-zА-Яа-я0-9 ]+[A-Za-zА-Яа-я0-9]$',
    );

    setState(() {
      if (input.isEmpty) {
        _descriptionError = ValidationInfo(
          isValid: false,
          error: 'Field cannot be empty',
        );
      } else if (!validRegex.hasMatch(input)) {
        _descriptionError = ValidationInfo(
          isValid: false,
          error: 'Invalid format',
        );
      } else {
        _descriptionError = ValidationInfo(isValid: true);
      }
    });
  }

  @override
  void dispose() {
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: theme.colorScheme.surfaceContainerHighest,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade400, width: 2),
                  bottom: BorderSide(color: Colors.grey.shade400, width: 2),
                ),
              ),
              child: Text(
                'Step Configuration',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Step description',
                errorText: _descriptionError.isValid
                    ? null
                    : _descriptionError.error,
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Duration (minutes)',
                errorText: _durationError.isValid ? null : _durationError.error,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        _durationError.isValid && _descriptionError.isValid
                        ? () {
                            final duration =
                                double.tryParse(_durationController.text) ?? 0;
                            widget.onSaveChanges(
                              Step(
                                description: _descriptionController.text,
                                durationMinutes: duration,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text('Confirm', style: theme.textTheme.titleSmall),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onDismissRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.onError,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text('Cancel', style: theme.textTheme.titleSmall),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
