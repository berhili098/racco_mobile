import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ClientApi {
  String apiUrl = dotenv.get('API_URL', fallback: '');

  Future getClients(String idTechnicien,String nbBuild) async {
    var headers = {'Accept': 'application/json'};
   
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/getClients/$idTechnicien/$nbBuild');
    return http.get(uri, headers: headers);
  }

  Future getAffectationTechnicien(String id) async {

    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/getClientsThecnicien/$id');
    return http.get(uri, headers: headers);
  }

  Future createLogTechnicien(Object? body) async {

    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/createLogTechnicien');
    return http.post(uri, headers: headers,body: body);
  }

  Future createAffectation(String clientId, String technicienId, String lat ,String lng) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/createAffectation');
    return http.post(uri,
        headers: headers,
        body: {'client_id': clientId, 'technicien_id': technicienId,
        
        'lat' : lat ,
        'lng' : lng
        
        });
  }

  
}
