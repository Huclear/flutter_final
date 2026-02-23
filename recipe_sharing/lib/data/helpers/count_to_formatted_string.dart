extension NumberFormatter on int {
  /// Alternative implementation using NumberFormat for better localization
  String toAmountStringFormatted() {
    if (this > 100000000000) return '> 100 B';

    if (this >= 1000000000) {
      final billions = this / 1000000000;
      return '${billions.toStringAsFixed(2)} B';
    } else if (this >= 1000000) {
      final millions = this / 1000000;
      return '${millions.toStringAsFixed(2)} M';
    } else if (this >= 1000) {
      final thousands = this / 1000;
      return '${thousands.toStringAsFixed(2)} K';
    } else {
      return toString();
    }
  }
}
