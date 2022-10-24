import 'package:dartz/dartz.dart';
import 'package:scyject/common/failure.dart';
import 'package:scyject/domain/entities/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, String>> saveProject(Project project);
  Future<Either<Failure, String>> removeProject(Project project);
  Future<Either<Failure, List<Project>>> getListProject();
}
