import 'package:dart_frog_backend_crud_list_collection/models/student.dart';

// this concept it works when crud to real database
abstract class StudentRepo {
  Future<List<Student>> readAll();
  Future<Student?> read(int id);
  Future<bool> create(Student student);
  Future<bool> update(Student student,int id);
  Future<bool> delete(int id);
}