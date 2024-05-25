import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend_crud_list_collection/log/logger.dart'; // set up logger now can use log.<some method>
import 'package:dart_frog_backend_crud_list_collection/models/student.dart';
import 'package:dart_frog_backend_crud_list_collection/repositories/student_repo.dart';
import 'package:dart_frog_backend_crud_list_collection/services/student_service.dart';


// index.dart this file it hidden when run dart_frog dev
// in this path it will be only http://localhost:8080/student (POST,GET can access) or http://localhost:8080/student/sid/[sid] (GET,PUT)
FutureOr<Response> onRequest(RequestContext context) {
  /*
    In this route handler, we only want to handle GET and POST requests so
    we're using a switch statement on context.request.method.
    If the HttpMethod is not GET or POST, our route handler responds with a 405 status code.
  */
  // So http://localhost:8080/student can retrieve all students and add student (same path difference http method)
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final students = await context.read<StudentRepo>().readAll();
  log.d('Requested by GET Method');
  return Response.json(statusCode: HttpStatus.accepted,body: students);
}

Future<Response> _post(RequestContext context) async {
  log.d('Requested by POST Method and sent parameter');
  // this way uses for convert json body to student obj
  Map map = (await context.request.json()) as Map;
  List mapSkills = map['skills'] as List;
  List<String> skills = [];
  for (int c = 0; c < mapSkills.length; c++) {
    skills.add(mapSkills.elementAtOrNull(c) as String);
  }
  Student student = Student(
      sid: int.parse(map['sid'].toString()),
      fullname: map['fullname'].toString(),
      age: int.parse(map['age'].toString()),
      skills: skills);
  // print(await context.request.json()); // {sid: 3, fullname: kevin owner, age: 19, skills: [Java]}
  return Response.json(
    statusCode: HttpStatus.created,
    body: await context.read<StudentRepo>().create(student),
  );
}
