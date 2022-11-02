// import 'package:scyject/domain/entities/project.dart';

class ProjectTable {
  String id;
  final String title;
  final String subtitle;
  final String date;

  ProjectTable({
    this.id = '',
    required this.title,
    required this.subtitle,
    required this.date,
  });

  // factory ProjectTable.fromEntity(Project project) => ProjectTable(
  //       id: project.id,
  //       title: project.title,
  //       subtitle: project.subtitle,
  //       date: project.date,
  //     );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'date': date,
      };

  static ProjectTable fromJson(Map<String, dynamic> json) => ProjectTable(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        date: json['date'],
      );
}
