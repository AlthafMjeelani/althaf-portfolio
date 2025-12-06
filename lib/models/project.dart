class Project {
  final String title;
  final String tech;
  final String period;
  final List<String> points;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String? thumbnailImagePath;
  final String? fullImagePath;
  final String? description;
  final String? detailedDescription;
  final List<String>? tasks;
  final List<String>? screenshots;

  Project({
    required this.title,
    required this.tech,
    required this.period,
    required this.points,
    this.appStoreUrl,
    this.playStoreUrl,
    this.thumbnailImagePath,
    this.fullImagePath,
    this.description,
    this.detailedDescription,
    this.tasks,
    this.screenshots,
  });
}
