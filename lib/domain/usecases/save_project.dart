import 'package:dartz/dartz.dart';
import 'package:scyject/common/failure.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/domain/repositories/project_repository.dart';

class SaveProject {
  final ProjectRepository repository;

  const SaveProject(this.repository);

  Future<Either<Failure, String>> execute(Project project) {
    return repository.saveProject(project);
  }
}
