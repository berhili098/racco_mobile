import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AffectationsApi {
  String apiUrl = dotenv.get('API_URL', fallback: '');
  String savapiUrl = dotenv.get('SAV_URL', fallback: '');

  Future getAffectation() async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/getAffectation');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationTechnicien(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/getAffectation/$id');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getSavTicketTechnicien(String id) async { 
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.parse("$savapiUrl/getSavTickets/$id");

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationPromoteurTechnicien(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(
        apiUrl, '/~newera22/app/public/api/getAffectationPromoteurApi/$id');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationPlanifier(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(
        apiUrl, '/~newera22/app/public/api/getAffectationPlanifier/$id');

    // post the data
    return http.get(uri, headers: headers);
  }
  Future getSavTicketPlanifier(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.parse(
        "$savapiUrl/getPlanifiedTicket/$id");

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationValider(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri =
        Uri.http(apiUrl, '/~newera22/app/public/api/getAffectationValider/$id');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationDeclarer(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(
        apiUrl, '/~newera22/app/public/api/getAffectationDeclarer/$id');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationBlocage(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri =
        Uri.http(apiUrl, '/~newera22/app/public/api/getAffectationBlocage/$id');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getAffectationBlocageBeforeValidation(String id) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl,
        '/~newera22/app/public/api/getAffectationBlocageAfterDeclared/$id');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future getRouteurs() async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/getRouteurs');

    // post the data
    return http.get(uri, headers: headers);
  }

  Future addRouteur(Object data) async {
    var headers = {'Accept': 'application/json'};
    // init the url
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/addRouteur');

    // post the data
    return http.post(uri, headers: headers, body: data);
  }

  static Future addImageAffectation(String id, String path) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(
        '127.0.0.1:8000', '/~newera22/app/public/api/storeImageAffectation');
    return http.post(uri,
        headers: headers, body: {'affectations_id': "121", 'img_path': path});
  }

  Future planifierAffectation(
      String id, String datePlanification, String technicienId) async {
    var headers = {'Accept': 'application/json'};
    Uri uri =
        Uri.http(apiUrl, '/~newera22/app/public/api/planifierAffectation');
    return http.post(uri, headers: headers, body: {
      'id': id,
      'planification_date': datePlanification,
      'technicien_id': technicienId
    });
  }
  

  Future declarerAffectation(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri =
        Uri.http(apiUrl, '/~newera22/app/public/api/declarationAffectation');

    return http.post(uri, headers: headers, body: data);
  }

  Future validationAffectation(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri =
        Uri.http(apiUrl, '/~newera22/app/public/api/validationAffectation');
    return http.post(uri, headers: headers, body: data);
  }
}
