extension StringExtension on String {
  String formatAsCurrency() {
    try {
      final number = double.parse(this);
      return number.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );
    } catch (e) {
      return this;
    }
  }
}
