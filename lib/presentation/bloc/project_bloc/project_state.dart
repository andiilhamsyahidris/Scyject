part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class ProjectEmpty extends ProjectState {}

class InsertOrRemoveProjectSuccess extends ProjectState {
  final String successMessage;

  const InsertOrRemoveProjectSuccess(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class InsertOrRemoveProjectFailed extends ProjectState {
  final String failureMessage;

  const InsertOrRemoveProjectFailed(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}
