enum Measure {
  liter('l', 'Liter'),
  milliliter('ml', 'Milliliter'),
  gram('gr', 'Gramm'),
  amount('th', 'Amount of units'),
  kilogram('kg', 'Kilogramm');

  final String shortName;
  final String fullName;

  const Measure(this.shortName, this.fullName);
}
