import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/repository/api_service.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/responses/privacy_policy_response.dart';
import 'package:kisma_livescore/responses/terms_and_conditions_response.dart';
import 'package:kisma_livescore/utils/response_status.dart';
import 'package:kisma_livescore/utils/shared_preference.dart';


class LiveScoreRepository {
  String? token;

  LiveScoreRepository() {
    token = PreferenceManager.getStringValue(key: TOKEN);
  }

  String getToken() {
    print('token123:$token');
    return token = PreferenceManager.getStringValue(key: TOKEN) ?? '';
  }

  // Get Privacy Policy
  Future<ResponseData> getPrivacyPolicy() async {
    try {
      final response = await ApiService().sendRequest.get(
          "/api/privacy-policy/all");
      return ResponseData(
          statusCode: response.statusCode,
          response: PrivacyPolicyResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  // Get Term's and Conditions
  Future<ResponseData> getTermsAndConditions() async {
    try {
      final response = await ApiService().sendRequest.get("/api/terms-and-conditions/all");
      return ResponseData(
          statusCode: response.statusCode,
          response: TermsAndConditionsResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  // Help and Support
  Future<ResponseData> helpAndSupport(String query, String emailId) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post('/api/queries/create',
          data: {
            "query":query,
            "emailId":emailId,
          });
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["message"],);
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  // get Live score
  Future<ResponseData> getLiveScore() async {
    try {
      final response = await ApiService().sendRequest.get("/sqs/consume");
      return ResponseData(
          statusCode: response.statusCode,
          response: LiveScoreResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

}