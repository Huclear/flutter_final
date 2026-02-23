enum RecipeDifficulty {
  beginner('Begginer'),
  
  common('Common'),
  
  adept('Adept'),
  
  masterpiece('Masterpiece');

  final String nameRes;
  
  const RecipeDifficulty(this.nameRes);

  int compareTo(RecipeDifficulty difficulty) {
    return index - difficulty.index;
  }
}