class SelectionItem<T> {
  T item;
  bool isSelected;

  SelectionItem(this.item, {this.isSelected = false});
}