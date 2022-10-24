import 'package:get_it/get_it.dart';
import 'package:scyject/data/datasources/db/database_helper.dart';
import 'package:scyject/data/datasources/scyject_local_data_source.dart';
import 'package:scyject/data/repositories/project_repositories_impl.dart';
import 'package:scyject/domain/repositories/project_repository.dart';
import 'package:scyject/domain/usecases/get_list_project.dart';
import 'package:scyject/domain/usecases/remove_project.dart';
import 'package:scyject/domain/usecases/save_project.dart';
import 'package:scyject/presentation/bloc/list_project_bloc/list_project_bloc.dart';
import 'package:scyject/presentation/bloc/project_bloc/project_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => ProjectBloc(
      saveProject: locator(),
      removeProject: locator(),
    ),
  );
  locator.registerFactory(
    () => ListProjectBloc(
      getListProject: locator(),
    ),
  );

  locator.registerLazySingleton(() => SaveProject(locator()));
  locator.registerLazySingleton(() => RemoveProject(locator()));
  locator.registerLazySingleton(() => GetListProject(locator()));

  locator.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoriesImpl(scyjectLocalDatasource: locator()),
  );

  locator.registerLazySingleton<ScyjectLocalDatasource>(
    () => ScyjectLocalDatasourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
