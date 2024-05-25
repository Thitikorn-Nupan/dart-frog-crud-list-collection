import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend_crud_list_collection/repositories/student_repo.dart';
import 'package:dart_frog_backend_crud_list_collection/services/student_service.dart';

// ********
// try to understand
final _studentRepo = StudentService();

Handler middleware(Handler handler) {
  // work like cdi in spring boot
  // now i can access any method on StudentRepo by pass context
  // ex , Future<Response> _get(RequestContext context) async
  // ex , final students = await context.read<StudentRepo>().readAll();
  return handler.use(provider<StudentRepo>((_)  => _studentRepo));
}