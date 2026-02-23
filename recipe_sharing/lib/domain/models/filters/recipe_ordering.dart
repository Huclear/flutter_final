enum RecipeOrdering {
  datePublished('Date published'),
  rating('Rasting'),
  difficulty('Difficulty');

  final String nameRes;

  const RecipeOrdering(this.nameRes);
}
