import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseService {
  // Base URL
  final String baseUrl = 'https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1';

  dynamic handleResponse(http.Response response) {
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseData;
    } else {
      throw Exception('Failed to load data!');
    }
  }

   Future<dynamic> post(String endpoint, {Map<String, String>? body}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(url, body: body);
    return handleResponse(response);
  }
}
