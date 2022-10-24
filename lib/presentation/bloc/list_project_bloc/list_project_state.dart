part of 'list_project_bloc.dart';

abstract class ListProjectState extends Equatable {
  const ListProjectState();

  @override
  List<Object> get props => [];
}

class ListProjectEmpty extends ListProjectState {}

class ListProjectLoading extends ListProjectState {}

class ListProjectError extends ListProjectState {
  final String message;
  const ListProjectError(this.message);

  @override
  List<Object> get props => [message];
}

class ListProjectHasData extends ListProjectState {
  final List<Project> project;

  const ListProjectHasData(this.project);

  @override
  List<Object> get props => [project];
}
