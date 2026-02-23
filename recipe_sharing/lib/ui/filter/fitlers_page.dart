import 'package:flutter/material.dart';
import 'package:recipe_sharing/ui/filter/section_parts.dart';

import '../../presentation/filters/section_category.dart';
import '../../presentation/filters/section_item.dart';

class FiltersPage extends StatefulWidget {
  final Map<String, List<String>> categorizedItems;
  final Function(List<String>) onFiltersConfirmed;
  final VoidCallback onCancelChanges;

  const FiltersPage({
    super.key,
    required this.categorizedItems,
    required this.onFiltersConfirmed,
    required this.onCancelChanges,
  });

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  late List<SelectionCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = widget.categorizedItems.entries.map((e) {
      return SelectionCategory(
        name: e.key,
        items: e.value.map((value) => SelectionItem(value)).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        height: 500,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                int categoryIndex = index ~/ 2;
                if (index % 2 == 0) {
                  return Container(
                    width: double.infinity,
                    color: theme.colorScheme.surfaceContainerHighest,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _categories[categoryIndex].name,
                      style: theme.textTheme.headlineLarge,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: _categories[categoryIndex].items.length,
                      itemBuilder: (context, itemIndex) {
                        final item =
                            _categories[categoryIndex].items[itemIndex];
                        return SelectionCategoryItem(
                          text: item.item,
                          isSelected: item.isSelected,
                          onSelect: () {
                            setState(() {
                              for (
                                var i = 0;
                                i < _categories[categoryIndex].items.length;
                                i++
                              ) {
                                _categories[categoryIndex].items[i].isSelected =
                                    false;
                              }

                              _categories[categoryIndex]
                                      .items[itemIndex]
                                      .isSelected =
                                  true;
                            });
                          },
                          onUnSelect: () {
                            setState(() {
                              _categories[categoryIndex]
                                      .items[itemIndex]
                                      .isSelected =
                                  false;
                            });
                          },
                        );
                      },
                    ),
                  );
                }
              }, childCount: _categories.length * 2),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                ),
                onPressed: widget.onCancelChanges,
                child: Text('Cancel', style: theme.textTheme.titleMedium),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  final selectedItems = <String>[];
                  for (var category in _categories) {
                    for (var item in category.items) {
                      if (item.isSelected) {
                        selectedItems.add(item.item);
                      }
                    }
                  }
                  widget.onFiltersConfirmed(selectedItems);
                },
                child: Text('Confirm', style: theme.textTheme.titleMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
