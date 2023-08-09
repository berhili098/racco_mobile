import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserApi {
  String apiUrl = dotenv.get('API_URL', fallback: '');

  Future getNotificationApi(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/notifications/$id');
    return http.get(
      uri,
      headers: headers,
    );
  }
  Future checkTechnicienIsBlockedApi(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/chectechnicienIsBlocked/$id');
    return http.get(
      uri,
      headers: headers,
    );
  }

  Future loginService(String email, String password) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/loginApi');
    return http.post(uri,
        headers: headers, body: {'email': email, 'password': password});
  }

  Future updateDeviseKeyService(String id, String deviseKey) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/updateDeviseKey');
    return http
        .post(uri, headers: headers, body: {'id': id, 'deviseKey': deviseKey});
  }

  
  Future updatePlayerIdService(String id, String playeriId) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/updatePlayerId');
    return http
        .post(uri, headers: headers, body: {'id': id, 'playeriId': playeriId});
  }


  Future deconnectUserService(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/deconnectUser');
    return http
        .post(uri, headers: headers, body: {'id': id});
  }
}
