import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeblocageApi {
  String apiUrl = dotenv.get('API_URL', fallback: '');

  Future deblocageApi(Object data) async {
    var headers = {'Accept': 'application/json'};

    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/deblocage');
    return http.post(uri, headers: headers, body: data);
  }

  // Future updateValidation(Object data) async {
  //   var headers = {'Accept': 'application/json'};
  //   Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/updateValidation');
  //   return http.post(uri, headers: headers, body: data);
  // }
}
