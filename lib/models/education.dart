class Education {
  static const int qualificationMaxLength = 255;
  static const int institutionMaxLength = 255;

  final String qualification;
  final String institution;
  final int startYear;
  final int? endYear;

  const Education({
    required this.qualification,
    required this.institution,
    required this.startYear,
    this.endYear,
  });

  bool get isOngoing => endYear == null;

  String get period {
    final end = endYear?.toString() ?? 'Present';
    return '$startYear — $end';
  }
}
