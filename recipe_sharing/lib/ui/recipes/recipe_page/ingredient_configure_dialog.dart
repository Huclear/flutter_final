import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/models/recipes/ingredient.dart';
import '../../../domain/models/recipes/measure.dart';
import '../../../domain/models/validation_info.dart';

class IngredientConfigureDialog extends StatefulWidget {
  final Ingredient ingredient;
  final VoidCallback onDismissRequest;
  final Function(Ingredient) onSaveChanges;

  const IngredientConfigureDialog({
    super.key,
    required this.ingredient,
    required this.onDismissRequest,
    required this.onSaveChanges,
  });

  @override
  State<IngredientConfigureDialog> createState() =>
      _IngredientConfigureDialogState();
}

class _IngredientConfigureDialogState extends State<IngredientConfigureDialog> {
  late Ingredient editedIngredient;
  late TextEditingController _amountController;
  late TextEditingController _nameController;
  ValidationInfo _amountError = ValidationInfo(isValid: true);
  ValidationInfo _nameError = ValidationInfo(isValid: true);

  @override
  void initState() {
    super.initState();
    editedIngredient = widget.ingredient;
    _amountController = TextEditingController(
      text: editedIngredient.amount.toString(),
    );
    _nameController = TextEditingController(text: editedIngredient.name);

    _amountController.addListener(_validateAmount);
    _nameController.addListener(_validateName);

    _validateAmount();
    _validateName();
  }

  void _validateAmount() {
    final input = _amountController.text;
    setState(() {
      if (input.isEmpty) {
        _amountError = ValidationInfo(
          isValid: false,
          error: 'Field cannot be empty',
        );
      } else {
        final amount = double.tryParse(input);
        if (amount == null || amount < 1 || amount > double.maxFinite) {
          _amountError = ValidationInfo(
            isValid: false,
            error: 'Invalid format',
          );
        } else if (input.split('.').first.length > 5) {
          _amountError = ValidationInfo(
            isValid: false,
            error: 'Length should be 1-5 digits',
          );
        } else {
          _amountError = ValidationInfo(isValid: true);
        }
      }
    });
  }

  void _validateName() {
    final input = _nameController.text;
    final RegExp validRegex = RegExp(
      r'^[A-Za-zА-Яа-я0-9][A-Za-zА-Яа-я0-9 ]*[A-Za-zА-Яа-я0-9]*$',
    );

    setState(() {
      if (input.isEmpty) {
        _nameError = ValidationInfo(
          isValid: false,
          error: 'Field cannot be empty',
        );
      } else if (!validRegex.hasMatch(input)) {
        _nameError = ValidationInfo(error: 'Invalid format', isValid: false);
      } else {
        _nameError = ValidationInfo(isValid: true);
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
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
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Ingredient name',
                errorText: _nameError.isValid ? null : _nameError.error,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      errorText: _amountError.isValid
                          ? null
                          : _amountError.error,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<Measure>(
                    initialValue: editedIngredient.measureType,
                    items: Measure.values.map((measure) {
                      return DropdownMenuItem<Measure>(
                        value: measure,
                        child: Text(measure.name),
                      );
                    }).toList(),
                    onChanged: (Measure? newValue) {
                      if (newValue != null) {
                        setState(() {
                          editedIngredient.measureType = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _amountError.isValid && _nameError.isValid
                        ? () {
                            final amount =
                                double.tryParse(_amountController.text) ?? 0;
                            editedIngredient.name = _nameController.text;
                            editedIngredient.amount = amount;
                            widget.onSaveChanges(editedIngredient);
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
