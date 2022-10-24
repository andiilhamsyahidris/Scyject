import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/domain/usecases/get_list_project.dart';

part 'list_project_event.dart';
part 'list_project_state.dart';

class ListProjectBloc extends Bloc<ListProjectEvent, ListProjectState> {
  final GetListProject getListProject;

  ListProjectBloc({required this.getListProject}) : super(ListProjectEmpty()) {
    on<FetchListProject>((event, emit) async {
      emit(ListProjectLoading());

      final result = await getListProject.execute();
      result.fold((failure) {
        emit(ListProjectError(failure.message));
      }, (data) {
        emit(ListProjectHasData(data));
      });
    });
  }
}
