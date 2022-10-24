import 'package:dartz/dartz.dart';
import 'package:scyject/common/exception.dart';
import 'package:scyject/common/failure.dart';
import 'package:scyject/data/datasources/scyject_local_data_source.dart';
import 'package:scyject/data/models/project_table.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/domain/repositories/project_repository.dart';

class ProjectRepositoriesImpl implements ProjectRepository {
  final ScyjectLocalDatasource scyjectLocalDatasource;

  ProjectRepositoriesImpl({required this.scyjectLocalDatasource});

  @override
  Future<Either<Failure, String>> saveProject(Project project) async {
    try {
      final result = await scyjectLocalDatasource
          .insertProject(ProjectTable.fromEntity(project));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeProject(Project project) async {
    try {
      final result = await scyjectLocalDatasource
          .removeProject(ProjectTable.fromEntity(project));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getListProject() async {
    final result = await scyjectLocalDatasource.getListProject();
    return Right(result.map((e) => e.toEntity()).toList());
  }
}
