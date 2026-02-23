import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FiltersTab extends StatefulWidget {
  final List<String> filters;
  final List<String> ingredients;
  final Function(String) onRemoveFilter;
  final Function(String) onAddIngredient;
  final Function(String) onRemoveIngredient;
  final int timeFrom;
  final int timeTo;
  final Function(int) onTimeFromChanged;
  final Function(int) onTimeToChanged;
  final VoidCallback onClearFilters;
  final VoidCallback onConfirmFilters;

  const FiltersTab({
    super.key,
    required this.filters,
    required this.ingredients,
    required this.onRemoveFilter,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
    required this.timeFrom,
    required this.timeTo,
    required this.onTimeFromChanged,
    required this.onTimeToChanged,
    required this.onClearFilters,
    required this.onConfirmFilters,
  });

  @override
  State<FiltersTab> createState() => _FiltersTabState();
}

class _FiltersTabState extends State<FiltersTab> {
  final TextEditingController _ingredientController = TextEditingController();
  String _ingredientInput = '';
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _ingredientController.addListener(_updateInput);
  }

  void _updateInput() {
    setState(() {
      _ingredientInput = _ingredientController.text;
      _validateInput();
    });
  }

  void _validateInput() {
    final RegExp validRegex = RegExp(r'^[A-Za-zА-Яа-я0-9 ]{2,}$');
    _isError =
        _ingredientInput.isEmpty ||
        widget.ingredients.contains(_ingredientInput) ||
        !validRegex.hasMatch(_ingredientInput);
  }

  String _getErrorText() {
    if (_ingredientInput.isEmpty) return 'Field cannot be empty';
    if (!RegExp(r'^[A-Za-z0-9]{2,}$').hasMatch(_ingredientInput)) {
      return 'Invalid format';
    }
    return 'Value already exists';
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filters', style: theme.textTheme.titleLarge),
          _buildFilterChips(theme),
          const Divider(thickness: 2),
          const Divider(thickness: 2),
          Text('Ingredients', style: theme.textTheme.titleLarge),
          _buildIngredientInput(theme),
          _buildIngredientChips(theme),
          const Divider(thickness: 2),
          const Divider(thickness: 2),
          Text('Time', style: theme.textTheme.titleLarge),
          SizedBox(
            height: 25,
            child: TextFormField(
              initialValue: widget.timeFrom.toString(),
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                final intValue = int.tryParse(value) ?? 0;
                widget.onTimeFromChanged(intValue);
              },
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 25,
            child: TextFormField(
              initialValue: widget.timeTo.toString(),
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                final intValue = int.tryParse(value) ?? 9999;
                widget.onTimeToChanged(intValue);
              },
            ),
          ),
          _buildActionButtons(theme),
        ],
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme) {
    if (widget.filters.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Opacity(
          opacity: 0.35,
          child: Text(
            'No saved filters',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.tertiary,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: _buildChip(filter, theme, widget.onRemoveFilter),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIngredientChips(ThemeData theme) {
    if (widget.ingredients.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Opacity(
          opacity: 0.35,
          child: Text(
            'No saved filters',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.tertiary,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.ingredients.map((ingredient) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: _buildChip(ingredient, theme, widget.onRemoveIngredient),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChip(String label, ThemeData theme, Function(String) onRemove) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              label,
              style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.clear,
              size: 20,
              color: theme.colorScheme.onTertiaryContainer,
            ),
            onPressed: () => onRemove(label),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientInput(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _ingredientController,
        decoration: InputDecoration(
          labelText: 'Ingredient name',
          errorText: _isError ? _getErrorText() : null,
          suffixIcon: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _isError
                ? null
                : () {
                    widget.onAddIngredient(_ingredientInput);
                    _ingredientController.clear();
                  },
          ),
          border: const OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          if (!_isError) {
            widget.onAddIngredient(_ingredientInput);
            _ingredientController.clear();
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zА-Яа-я0-9 ]')),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: widget.onConfirmFilters,
                child: Text('Confirm', style: theme.textTheme.titleSmall),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: widget.onClearFilters,
                child: Text('Cancel', style: theme.textTheme.titleSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
