import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/domain/usecases/remove_project.dart';
import 'package:scyject/domain/usecases/save_project.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final SaveProject saveProject;
  final RemoveProject removeProject;

  ProjectBloc({
    required this.saveProject,
    required this.removeProject,
  }) : super(ProjectEmpty()) {
    on<InsertProject>((event, emit) async {
      final data = event.project;
      final result = await saveProject.execute(data);

      result.fold((failure) {
        emit(InsertOrRemoveProjectFailed(failure.message));
      }, (data) {
        emit(InsertOrRemoveProjectSuccess(data));
      });
    });
    on<UnsaveProject>((event, emit) async {
      final data = event.project;
      final result = await removeProject.execute(data);

      result.fold((failure) {
        emit(InsertOrRemoveProjectFailed(failure.message));
      }, (data) {
        emit(InsertOrRemoveProjectSuccess(data));
      });
    });
  }
}
