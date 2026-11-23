import 'package:myportofolio_mobile/utils/date_format.dart';

class Experience {
  static const Map<String, String> categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  static const String defaultCategory = 'full-time';
  static const int titleMaxLength = 255;
  static const int organizationMaxLength = 255;
  static const int projectMaxLength = 255;
  static const int technologiesMaxLength = 255;
  static const int thumbnailMaxLength = 200;

  final String title;
  final String organization;
  final String description;
  final String project;
  final String technologies;
  final String category;
  final String thumbnail;
  final DateTime startedAt;
  final DateTime? endedAt;

  const Experience({
    required this.title,
    required this.organization,
    required this.description,
    required this.project,
    required this.technologies,
    required this.category,
    required this.thumbnail,
    required this.startedAt,
    this.endedAt,
  });

  bool get isOngoing => endedAt == null;

  String get categoryLabel => categories[category] ?? category;

  String get period {
    final end = endedAt;
    final endLabel = end == null ? 'Present' : formatMonthYear(end);
    return '${formatMonthYear(startedAt)} — $endLabel';
  }

  List<String> get tags {
    return technologies
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }
}
