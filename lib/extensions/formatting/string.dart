extension StringFormatting on String {
  String capitalize() {
    // TODO note we dont need this on subsctring - i guess it is implied
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
