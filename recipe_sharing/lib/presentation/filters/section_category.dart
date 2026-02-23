import 'package:recipe_sharing/presentation/filters/section_item.dart';


class SelectionCategory {
  String name;
  List<SelectionItem<String>> items;

  SelectionCategory({required this.name, required this.items});

  SelectionCategory copyWith({
    String? name,
    List<SelectionItem<String>>? items,
  }) {
    return SelectionCategory(
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}
