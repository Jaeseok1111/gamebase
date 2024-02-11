class Format {
  static DateTime? int2DateTime(int value) {
    String str = value.toString();

    int? year = int.tryParse(str.substring(0, 4));
    int? month = int.tryParse(str.substring(4, 6));
    int? day = int.tryParse(str.substring(6, 8));
    int? hour = int.tryParse(str.substring(8, 10));

    if (year == null || month == null || day == null || hour == null) {
      return null;
    }

    return DateTime(year, month, day, hour);
  }
}
