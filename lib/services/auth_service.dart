import 'package:flutter/material.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends BaseService with ChangeNotifier {
  Future<Map<String, dynamic>> getEmailToken(String email) async {
    final url = Uri.parse('$baseUrl/auth/email');
    try {
      final response = await http.post(url, body: {'email': email});
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final responseData = json.decode(response.body);
      print('Decoded Response: $responseData');

      if (responseData['status'] == true) {
        print('Token Received: ${responseData['data']['token']}');
        return {'success': true, 'data': responseData['data']['token']};
      } else {
        print('Error Message: ${responseData['message']}');
        return {'success': false, 'message': responseData['message']};
      }
    } catch (error) {
      print('Exception Caught: $error');
      return {'success': false, 'message': error.toString()};
    }
  }


   Future<bool> verifyEmailToken(String email, String token) async {
    try {
      final responseData = await post('auth/email/verify', body: {'email': email, 'token': token});
      if (responseData['status'] == true) {
         print('Successful Response: $responseData');
        return true;
      } else {
         print('Failed Response: $responseData');
        return false;
      }
    } catch (error) {
      print('Error verifying email token: $error');
      return false;
    }
  }
}
