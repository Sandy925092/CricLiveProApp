import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisma_livescore/repository/livescore_repository.dart';
import 'package:kisma_livescore/utils/response_status.dart';

part 'livescore_state.dart';

class LiveScoreCubit extends Cubit<LiveScoreState> {
  final LiveScoreRepository repository;

  LiveScoreCubit(this.repository) : super(const LiveScoreState());

  Future<void> privacyPolicyCall() async {
    emit(state.copyWith(status: LiveScoreStatus.privacyPolicyLoading));
    try {
      ResponseData response = await repository.getPrivacyPolicy();
      emit(state.copyWith(
          status: LiveScoreStatus.privacyPolicySuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.privacyPolicyError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.privacyPolicyError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> termsAndConditionCall() async {
    emit(state.copyWith(status: LiveScoreStatus.termsAndConditionsLoading));
    try {
      ResponseData response = await repository.getTermsAndConditions();
      emit(state.copyWith(
          status: LiveScoreStatus.termsAndConditionsSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.termsAndConditionsError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.termsAndConditionsError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> helpAndSupportCall(String query, String emailId) async {
    emit(state.copyWith(status: LiveScoreStatus.helpAndSupportLoading));
    try {
      ResponseData response = await repository.helpAndSupport(query, emailId);
      emit(state.copyWith(
          status: LiveScoreStatus.helpAndSupportSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.helpAndSupportError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.helpAndSupportError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getLiveScoreCall() async {
    emit(state.copyWith(status: LiveScoreStatus.liveScoreLoading));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreSuccess, responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getLiveScoreCall1() async {
    // emit(state.copyWith(status: LiveScoreStatus.liveScoreLoading2));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreSuccess1, responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreError1,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreError1,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getUpcomingSeries() async {
    emit(state.copyWith(status: LiveScoreStatus.upcomingSeriesLoading));
    try {
      ResponseData response = await repository.getUpcomingSeriesData();
      emit(state.copyWith(
          status: LiveScoreStatus.upcomingSeriesSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.upcomingSeriesError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.upcomingSeriesError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getLiveScoreDashboardCall() async {
    emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardLoading));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreDashboardSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreDashboardError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreDashboardError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getLiveScoreDashboardCall1() async {
    // emit(state.copyWith(status: LiveScoreStatus.liveScoreLoading1));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreDashboardSuccess1,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreDashboardError1,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveScoreDashboardError1,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getCountryCodeAndFlagCall() async {
    emit(state.copyWith(status: LiveScoreStatus.getCountryCodeAndFlagLoading));
    try {
      ResponseData response = await repository.getCountryCodeAndFlag();
      emit(state.copyWith(
          status: LiveScoreStatus.getCountryCodeAndFlagSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.getCountryCodeAndFlagError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.getCountryCodeAndFlagError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> signUpCall(Map<String, dynamic> signUpDetails) async {
    emit(state.copyWith(status: LiveScoreStatus.signUpLoading));
    try {
      ResponseData responseData = await repository.signUp(signUpDetails);
      emit(state.copyWith(
          status: LiveScoreStatus.signUpSuccess, responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.signUpError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.signUpError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> verifyOtpCall(String email, String otp) async {
    emit(state.copyWith(status: LiveScoreStatus.verifyOtpLoading));
    try {
      ResponseData responseData = await repository.verifyOtp(email, otp);
      emit(state.copyWith(
          status: LiveScoreStatus.verifyOtpSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.verifyOtpError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.verifyOtpError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> forgotPasswordCall(String email) async {
    emit(state.copyWith(status: LiveScoreStatus.forgotPasswordLoading));
    try {
      ResponseData responseData = await repository.forgotPassword(email);
      emit(state.copyWith(
          status: LiveScoreStatus.forgotPasswordSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.forgotPasswordError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.forgotPasswordError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> resendOtpCall(String email) async {
    emit(state.copyWith(status: LiveScoreStatus.resendOtpLoading));
    try {
      ResponseData responseData = await repository.forgotPassword(email);
      emit(state.copyWith(
          status: LiveScoreStatus.resendOtpSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.resendOtpError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.resendOtpError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> resetPasswordCall(
      String email, String newPassword, String confirmNewPassword) async {
    emit(state.copyWith(status: LiveScoreStatus.resetPasswordLoading));
    try {
      ResponseData responseData = await repository.resetPassword(
          email, newPassword, confirmNewPassword);
      emit(state.copyWith(
          status: LiveScoreStatus.resetPasswordSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.resetPasswordError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.resetPasswordError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> loginCall(String email, String password) async {
    emit(state.copyWith(status: LiveScoreStatus.loginLoading));
    try {
      ResponseData responseData = await repository.login(email, password);
      emit(state.copyWith(
          status: LiveScoreStatus.loginSuccess, responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.loginError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.loginError,
          error: e.toString(),
          errorData: null));
    }
  }
}
