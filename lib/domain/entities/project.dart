import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  Project.listProject({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  final int id;
  final String? title;
  final String? subtitle;
  final String? date;

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        date,
      ];
}
