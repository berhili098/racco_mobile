import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BlocageApi {
  String apiUrl = dotenv.get('API_URL', fallback: '');

  Future<http.Response> declarationBlocage(String affectationId, String cause,
      String justification, String lng, String lat) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/declarationBlocage');
    return http.post(uri, headers: headers, body: {
      'affectation_id': affectationId,
      'cause': cause,
      'justification': justification,
      'lng': lng,
      'lat': lat
    });
  }

  Future insertImageBlocage(
      String image, String imageData, String blocageId) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.http(apiUrl, '/~newera22/app/public/api/storeImageBlocage');
    return http.post(uri, headers: headers, body: {
      'image': image,
      'image_data': imageData,
      'blocage_id': blocageId
    });
  }
}
