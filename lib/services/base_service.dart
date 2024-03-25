import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_exception.dart';

class BaseService {
  final String baseUrl = 'https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1';

  dynamic handleResponse(http.Response response) {
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      print('ResponseData: $responseData');
      return responseData;
    } else {
      String errorMessage = 'Unknown error occurred';
      if (responseData['message'] != null) {
        errorMessage = responseData['message'];
        if (responseData['errors'] != null) {
          final errors = responseData['errors'] as Map<String, dynamic>;
          final errorMessages = errors.values.map((e) => e.join(', ')).join('; ');
          errorMessage += ': $errorMessages';
        }

        print('Unexpected Error: $errorMessage');
      }
      throw ApiException(errorMessage, response.statusCode);
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, {Map<String, String>? body}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(url, body: body, headers: {"Content-Type": "application/x-www-form-urlencoded"});
    return handleResponse(response);
  }
}
