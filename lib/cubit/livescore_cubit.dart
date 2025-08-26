import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisma_livescore/repository/livescore_repository.dart';
import 'package:kisma_livescore/responses/socketlivematch.dart';
import 'package:kisma_livescore/utils/response_status.dart';

part 'livescore_state.dart';

class LiveScoreCubit extends Cubit<LiveScoreState> {
  final LiveScoreRepository repository;

  LiveScoreCubit(this.repository) : super(const LiveScoreState());

  List<SocketLiveMatchResponse>? liveData;

  void updateLiveDataFromSocket(List<SocketLiveMatchResponse> data) {
    emit(state.copyWith(
      status: LiveScoreStatus.liveMatchSocketUpdate,
      socketLiveData: data,
    ));
  }

  Matches? getMatch(int seriesIndex, int matchIndex) {
    return liveData?[seriesIndex].matches?[matchIndex];
  }

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

  Future<void> getUpcomingSeries(
      String token, String pageNo, String filterName, String day) async {
    emit(state.copyWith(status: LiveScoreStatus.upcomingSeriesLoading));
    try {
      ResponseData response = await repository.getUpcomingSeriesData(
          token, pageNo, filterName, day);
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

  Future<void> getLikedMatch(
    String token,
  ) async {
    emit(state.copyWith(status: LiveScoreStatus.getLikedMatchLoading));
    try {
      ResponseData response = await repository.getLikedMatch(token);
      emit(state.copyWith(
          status: LiveScoreStatus.getLikedMatchSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.getLikedMatchError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.getLikedMatchError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getLiveMatchApiData() async {
    emit(state.copyWith(status: LiveScoreStatus.liveApiLoading));
    try {
      ResponseData response = await repository.getLiveMatch();
      emit(state.copyWith(
          status: LiveScoreStatus.liveApiSuccess, responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveApiError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.liveApiError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getSearchMatches(String query, String type) async {
    emit(state.copyWith(status: LiveScoreStatus.searchMatchesLoading));
    try {
      ResponseData response = await repository.searchMatches(query, type);
      emit(state.copyWith(
          status: LiveScoreStatus.searchMatchesSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.searchMatchesError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.searchMatchesError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getFinishedSeries(String pageno, String selectedFilter) async {
    emit(state.copyWith(status: LiveScoreStatus.finishedSeriesLoading));
    try {
      ResponseData response =
          await repository.getFinishesSeries(pageno, selectedFilter);
      emit(state.copyWith(
          status: LiveScoreStatus.finishedSeriesSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.finishedSeriesError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.finishedSeriesError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> seriesCategory(
    String pageno,
  ) async {
    emit(state.copyWith(status: LiveScoreStatus.seriesCategoryLoading));
    try {
      ResponseData response = await repository.seriesCategory(pageno);
      emit(state.copyWith(
          status: LiveScoreStatus.seriesCategorySuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.seriesCategoryError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.seriesCategoryError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getMatchDetails(
    String matchId,
  ) async {
    emit(state.copyWith(status: LiveScoreStatus.matchDetailsLoading));
    try {
      ResponseData response = await repository.getMatchDetails(matchId);
      emit(state.copyWith(
          status: LiveScoreStatus.matchDetailsSuccess, responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.matchDetailsError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.matchDetailsError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getFinishMatch(String pageno, String seriesId) async {
    emit(state.copyWith(status: LiveScoreStatus.finishedMatchLoading));
    try {
      ResponseData response =
          await repository.getFinishesMatch(pageno, seriesId);
      emit(state.copyWith(
          status: LiveScoreStatus.finishedMatchSuccess,
          responseData: response));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.finishedMatchError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.finishedMatchError,
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

  Future<void> getMyEvents(String date, String type, String pageNo, String filter) async {
    emit(state.copyWith(status: LiveScoreStatus.myEventsLoading));
    try {
      ResponseData responseData =
          await repository.getMyEventsMatches(date, type, pageNo, filter);
      emit(state.copyWith(
          status: LiveScoreStatus.myEventsSuccess, responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.myEventsError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.myEventsError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> seriesMatches(String id, String pageNo) async {
    emit(state.copyWith(status: LiveScoreStatus.seriesMatchesLoading));
    try {
      ResponseData responseData = await repository.seriesMatches(id, pageNo);
      emit(state.copyWith(
          status: LiveScoreStatus.seriesMatchesSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.seriesMatchesError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.seriesMatchesError,
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

  Future<void> loginCall(
      String email, String password, String deviceToken) async {
    emit(state.copyWith(status: LiveScoreStatus.loginLoading));
    try {
      ResponseData responseData =
          await repository.login(email, password, deviceToken);
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

  Future<void> likeMatch(
      String token, Map<String, dynamic> likeMatchDetails) async {
    emit(state.copyWith(status: LiveScoreStatus.likematchLoading));
    try {
      ResponseData responseData =
          await repository.likeMatch(token, likeMatchDetails);
      emit(state.copyWith(
          status: LiveScoreStatus.likematchSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.likematchError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.likematchError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> unLikeMatch(String token, String fixtureId) async {
    emit(state.copyWith(status: LiveScoreStatus.unLikematchLoading));
    try {
      ResponseData responseData =
          await repository.unLikeMatch(token, fixtureId);
      emit(state.copyWith(
          status: LiveScoreStatus.unLikematchSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.unLikematchError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.unLikematchError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getProfile(String token) async {
    emit(state.copyWith(status: LiveScoreStatus.getProfileLoading));
    try {
      ResponseData responseData = await repository.getProfile(token);
      emit(state.copyWith(
          status: LiveScoreStatus.getProfileSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.getProfileError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.getProfileError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> updateProfile(String token, FormData formData) async {
    emit(state.copyWith(status: LiveScoreStatus.updateProfileLoading));
    try {
      ResponseData responseData =
          await repository.updateProfile(token, formData);
      emit(state.copyWith(
          status: LiveScoreStatus.updateProfileSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.updateProfileError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.updateProfileError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> getNotifications(String token) async {
    emit(state.copyWith(status: LiveScoreStatus.getNotificationsLoading));
    try {
      ResponseData responseData = await repository.getNotifications(token);
      emit(state.copyWith(
          status: LiveScoreStatus.getNotificationsSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.getNotificationsError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.getNotificationsError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> logOut(String token) async {
    emit(state.copyWith(status: LiveScoreStatus.logOutLoading));
    try {
      ResponseData responseData = await repository.logOut(token);
      emit(state.copyWith(
          status: LiveScoreStatus.logOutSuccess, responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.logOutError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(state.copyWith(
          status: LiveScoreStatus.logOutError,
          error: e.toString(),
          errorData: null));
    }
  }

  Future<void> deleteAccount(String token) async {
    emit(state.copyWith(status: LiveScoreStatus.deleteAccountLoading));
    try {
      ResponseData responseData = await repository.deleteAccount(token);
      emit(state.copyWith(
          status: LiveScoreStatus.deleteAccountSuccess,
          responseData: responseData));
    } on ErrorData catch (errorData) {
      emit(state.copyWith(
          status: LiveScoreStatus.deleteAccountError,
          errorData: errorData,
          error: null));
    } catch (e) {
      emit(
          state.copyWith(
              status: LiveScoreStatus.deleteAccountError, error: e.toString(),
          errorData: null));
    }
  }
}
