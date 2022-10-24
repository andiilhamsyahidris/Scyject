import 'package:dartz/dartz.dart';
import 'package:scyject/common/failure.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/domain/repositories/project_repository.dart';

class RemoveProject {
  final ProjectRepository repository;

  const RemoveProject(this.repository);

  Future<Either<Failure, String>> execute(Project project) {
    return repository.removeProject(project);
  }
}
