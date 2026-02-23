enum FirestoreCollections {
  creators("Creators"),
  recipes("Recipes"),
  filters("Filters"),
  categories("Categories"),
  favorites("Favorites"),
  follows("Follows");

  final String collectionName;

  const FirestoreCollections(this.collectionName);
}
