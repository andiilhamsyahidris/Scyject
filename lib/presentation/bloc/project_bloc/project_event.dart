part of 'project_bloc.dart';

abstract class ProjectEvent {
  const ProjectEvent();
}

class InsertProject extends ProjectEvent {
  final Project project;
  const InsertProject(this.project);
}

class UnsaveProject extends ProjectEvent {
  final Project project;
  const UnsaveProject(this.project);
}
