import 'package:flutter/material.dart';
import 'base_service.dart';
import 'api_exception.dart';

class AuthService extends BaseService with ChangeNotifier {

Future<Map<String, dynamic>> getEmailToken(String email) async {
    try {
      final responseData = await post('auth/email', body: {'email': email});
      return {'success': true, 'data': responseData['data']['token']};
    } catch (error) {
      return {'success': false, 'message': error.toString()};
    }
  }

  Future<bool> verifyEmailToken(String email, String token) async {
    try {
      final responseData = await post('auth/email/verify', body: {'email': email, 'token': token});
      return responseData['status'] == true;
    } catch (error) {
      print('Unexpected Error: $error');
      return false;
    }
  }

Future<Map<String, dynamic>> register({
    required String fullName,
    required String username,
    required String email,
    required String country,
    required String password,
    required String deviceName,
  }) async {
    try {
      final responseData = await post(
        'auth/register',
        body: {
          'full_name': fullName,
          'username': username,
          'email': email,
          'country': country,
          'password': password,
          'device_name': deviceName,
        },
      );

      if (responseData['status'] == true) {
        final String token = responseData['data']['token'];
        final Map<String, dynamic> user = responseData['data']['user'];

        return {
          'success': true,
          'token': token,
          'user': user
        };
      } else {
        return {'success': false, 'message': 'Unexpected status flag'};
      }
    } on ApiException catch (apiError) {
      // Handling API-specific errors.
      return {'success': false, 'message': apiError.message};
    } catch (error) {
      // Handling other unexpected errors.
      return {'success': false, 'message': 'An unexpected error occurred.'};
    }
  }
}
