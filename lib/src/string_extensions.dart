extension StringExtensions on String {
  String toNonNullable() => endsWith('?') ? substring(0, length - 1) : this;
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
