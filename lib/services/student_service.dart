import 'package:dart_frog_backend_crud_list_collection/log/logger.dart';
import 'package:dart_frog_backend_crud_list_collection/models/student.dart';
import 'package:dart_frog_backend_crud_list_collection/repositories/student_repo.dart';

class StudentService implements StudentRepo {
  List<Student> students = [
    Student(
        sid: 1, fullname: 'peter parker', age: 19, skills: ['C,C++', 'Java']),
    Student(
        sid: 2,
        fullname: 'alex ryder',
        age: 20,
        skills: ['Java', 'Python', 'Js,Ts'])
  ];

  @override
  Future<Student?> read(int id) async {
    Student? student;
    for (int i = 0; i < students.length; i++) {
      student = students.elementAt(i);
      if (student.sid == id) {
        return student;
      }
    }
  }

  @override
  Future<List<Student>> readAll() async {
    return students;
  }

  @override
  Future<bool> create(Student student) async {
    students.add(student);
    return true;
  }

  @override
  Future<bool> update(Student student, int id) async {
    Student? old = await read(id);
    if (old == null) {
      return false;
    } else {
      students.remove(old);
      student.sid = id;
      students.add(student);
      return true;
    }
  }

  @override
  Future<bool> delete(int id) async {
    Student? old = await read(id);
    if (old == null) {
      return false;
    } else {
      students.remove(old);
      return true;
    }
  }
}
