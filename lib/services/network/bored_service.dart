import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:sampleapi/services/model/bored_activity_model.dart';

class BoredService {
  // ignore: non_constant_identifier_names
  Future<BoredActivity> getBoredActivity() async {
    var url = dotenv.env['API_URL'];

    final response = await get(Uri.parse(url!));
    final activity = boredActivityFromJson(response.body);
    return activity;
  }
}
