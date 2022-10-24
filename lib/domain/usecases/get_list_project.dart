import 'package:dartz/dartz.dart';
import 'package:scyject/common/failure.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/domain/repositories/project_repository.dart';

class GetListProject {
  final ProjectRepository repository;

  const GetListProject(this.repository);

  Future<Either<Failure, List<Project>>> execute() {
    return repository.getListProject();
  }
}
