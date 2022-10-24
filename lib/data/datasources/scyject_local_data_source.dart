import 'package:scyject/common/exception.dart';
import 'package:scyject/data/datasources/db/database_helper.dart';
import 'package:scyject/data/models/project_table.dart';

abstract class ScyjectLocalDatasource {
  Future<String> insertProject(ProjectTable project);
  Future<String> removeProject(ProjectTable project);
  Future<List<ProjectTable>> getListProject();
}

class ScyjectLocalDatasourceImpl implements ScyjectLocalDatasource {
  final DatabaseHelper databaseHelper;

  ScyjectLocalDatasourceImpl({required this.databaseHelper});

  @override
  Future<String> insertProject(ProjectTable project) async {
    try {
      await databaseHelper.insertProject(project);
      return 'Berhasil Menambahkan Project';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeProject(ProjectTable project) async {
    try {
      await databaseHelper.removeProject(project);
      return 'Berhasil Menghapus Project';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ProjectTable>> getListProject() async {
    final result = await databaseHelper.getListProject();
    return result.map((e) => ProjectTable.fromMap(e)).toList();
  }
}
