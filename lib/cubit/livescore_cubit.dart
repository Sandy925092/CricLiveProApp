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
      emit(state.copyWith(status: LiveScoreStatus.privacyPolicySuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.privacyPolicyError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.privacyPolicyError, error: e.toString(), errorData: null));
    }
  }

  Future<void> termsAndConditionCall() async {
    emit(state.copyWith(status: LiveScoreStatus.termsAndConditionsLoading));
    try {
      ResponseData response = await repository.getTermsAndConditions();
      emit(state.copyWith(status: LiveScoreStatus.termsAndConditionsSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.termsAndConditionsError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.termsAndConditionsError, error: e.toString(), errorData: null));
    }
  }


  Future<void> helpAndSupportCall(String query, String emailId) async {
    emit(state.copyWith(status: LiveScoreStatus.helpAndSupportLoading));
    try {
      ResponseData response = await repository.helpAndSupport(query, emailId);
      emit(state.copyWith(status: LiveScoreStatus.helpAndSupportSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.helpAndSupportError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.helpAndSupportError, error: e.toString(), errorData: null));
    }
  }


  Future<void> getLiveScoreCall() async {
    emit(state.copyWith(status: LiveScoreStatus.liveScoreLoading));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(status: LiveScoreStatus.liveScoreSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreError, error: e.toString(), errorData: null));
    }
  }

  Future<void> getLiveScoreCall1() async {
    // emit(state.copyWith(status: LiveScoreStatus.liveScoreLoading2));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(status: LiveScoreStatus.liveScoreSuccess1, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreError1, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreError1, error: e.toString(), errorData: null));
    }
  }

  Future<void> getLiveScoreDashboardCall() async {
    emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardLoading));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardError, error: e.toString(), errorData: null));
    }
  }

  Future<void> getLiveScoreDashboardCall1() async {
    // emit(state.copyWith(status: LiveScoreStatus.liveScoreLoading1));
    try {
      ResponseData response = await repository.getLiveScore();
      emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardSuccess1, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardError1, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.liveScoreDashboardError1, error: e.toString(), errorData: null));
    }
  }



  Future<void> getCountryCodeAndFlagCall() async {
    emit(state.copyWith(status: LiveScoreStatus.getCountryCodeAndFlagLoading));
    try {
      ResponseData response = await repository.getCountryCodeAndFlag();
      emit(state.copyWith(status: LiveScoreStatus.getCountryCodeAndFlagSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: LiveScoreStatus.getCountryCodeAndFlagError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: LiveScoreStatus.getCountryCodeAndFlagError, error: e.toString(), errorData: null));
    }
  }


}
