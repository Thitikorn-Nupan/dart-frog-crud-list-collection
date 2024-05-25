import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend_crud_list_collection/models/student.dart';
import 'package:dart_frog_backend_crud_list_collection/repositories/student_repo.dart';
import 'package:dart_frog_backend_crud_list_collection/services/student_service.dart';
import 'package:dart_frog_backend_crud_list_collection/log/logger.dart'; // set up logger now can use log.<some method>

// this path can access 3 http method (GET,PUT,DELETE)

FutureOr<Response> onRequest(RequestContext context, String sid) {
  // it mapped arg to the same name [sid] dart file
  final id = int.parse(sid);
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, id);
    case HttpMethod.post:
    case HttpMethod.delete:
      return _delete(context, id);
    case HttpMethod.put:
      return _put(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, int sid) async {
  log.d('Requested by GET Method and sent parameter');
  return Response.json(body:await context.read<StudentRepo>().read(sid));
}

Future<Response> _delete(RequestContext context, int sid) async {
  log.d('Requested by DELETE Method and sent parameter');
  return Response.json(body:await context.read<StudentRepo>().delete(sid));
}

Future<Response> _put(RequestContext context, int sid) async {
  log.d('Requested by PUT Method and sent parameter');
  Map map = (await context.request.json()) as Map;
  List mapSkills = map['skills'] as List;
  List<String> skills = [];
  for (int c = 0; c < mapSkills.length; c++) {
    skills.add(mapSkills.elementAtOrNull(c) as String);
  }
  Student student = Student(
      sid: sid,
      fullname: map['fullname'].toString(),
      age: int.parse(map['age'].toString()),
      skills: skills);
  return Response.json(
    statusCode: HttpStatus.accepted,
    body: await context.read<StudentRepo>().update(student,sid),
  );
}