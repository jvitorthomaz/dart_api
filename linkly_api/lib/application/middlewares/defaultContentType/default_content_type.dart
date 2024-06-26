
import 'package:dart_application/application/middlewares/middlewares.dart';
import 'package:shelf/src/response.dart';
import 'package:shelf/src/request.dart';

class DefaultContentType extends Midlewares{
  final String contentType;

  DefaultContentType(this.contentType);

  @override
  Future<Response> execute(Request request) async{
    final response = await innerHandler(request);
    return response.change(headers: {'content-type': contentType});
  }
  
}
