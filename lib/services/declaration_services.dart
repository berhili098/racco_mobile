import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeclarationApi {
  String apiUrl = dotenv.get('API_URL', fallback: '');

  Future getDeclaration(String id) async {
    var headers = {'Accept': 'application/json'};

    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/declaration/$id');
    return http.get(uri, headers: headers);
  }



   Future updateDeclaration(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/updateDeclaration');
    return http.post(uri, headers: headers, body: data);

     
  }
}
