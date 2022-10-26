import 'package:equatable/equatable.dart';
import 'package:scyject/domain/entities/project.dart';

class ProjectTable extends Equatable {
  // final int id;
  final String? title;
  final String? subtitle;
  final String? date;

  const ProjectTable({
    // required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  factory ProjectTable.fromEntity(Project project) => ProjectTable(
        // id: project.id,
        title: project.title,
        subtitle: project.subtitle,
        date: project.date,
      );

  factory ProjectTable.fromMap(Map<String, dynamic> map) => ProjectTable(
      // id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      date: map['date']);
  Map<String, dynamic> toJson() => {
        // 'id': id,
        'title': title,
        'subtitle': subtitle,
        'date': date,
      };

  Project toEntity() => Project.listProject(
        // id: id,
        title: title,
        subtitle: subtitle,
        date: date,
      );
  @override
  List<Object?> get props => [
        // id,
        title,
        subtitle,
        date,
      ];
}
