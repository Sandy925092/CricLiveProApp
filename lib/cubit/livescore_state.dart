part of 'livescore_cubit.dart';

enum LiveScoreStatus {
  initial,

  upcomingSeriesLoading,
  upcomingSeriesSuccess,
  upcomingSeriesError,

  getLikedMatchLoading,
  getLikedMatchSuccess,
  getLikedMatchError,

  finishedSeriesLoading,
  finishedSeriesSuccess,
  finishedSeriesError,

  seriesCategoryLoading,
  seriesCategorySuccess,
  seriesCategoryError,

  liveApiLoading,
  liveApiSuccess,
  liveApiError,


  searchMatchesLoading,
  searchMatchesSuccess,
  searchMatchesError,

  matchDetailsLoading,
  matchDetailsSuccess,
  matchDetailsError,

  finishedMatchLoading,
  finishedMatchSuccess,
  finishedMatchError,

  privacyPolicyLoading,
  privacyPolicySuccess,
  privacyPolicyError,

  termsAndConditionsLoading,
  termsAndConditionsSuccess,
  termsAndConditionsError,

  helpAndSupportLoading,
  helpAndSupportSuccess,
  helpAndSupportError,

  liveScoreDashboardLoading,
  liveScoreDashboardSuccess,
  liveScoreDashboardError,

  liveScoreDashboardLoading1,
  liveScoreDashboardSuccess1,
  liveScoreDashboardError1,

  liveScoreLoading,
  liveScoreSuccess,
  liveScoreError,

  liveScoreLoading1,
  liveScoreSuccess1,
  liveScoreError1,

  getCountryCodeAndFlagLoading,
  getCountryCodeAndFlagSuccess,
  getCountryCodeAndFlagError,

  signUpLoading,
  signUpSuccess,
  signUpError,

  verifyOtpLoading,
  verifyOtpSuccess,
  verifyOtpError,

  myEventsLoading,
  myEventsSuccess,
  myEventsError,


  seriesMatchesLoading,
  seriesMatchesSuccess,
  seriesMatchesError,

  forgotPasswordLoading,
  forgotPasswordSuccess,
  forgotPasswordError,

  resendOtpLoading,
  resendOtpSuccess,
  resendOtpError,

  resetPasswordLoading,
  resetPasswordSuccess,
  resetPasswordError,

  loginLoading,
  loginSuccess,
  loginError,

  likematchLoading,
  likematchSuccess,
  likematchError,

  unLikematchLoading,
  unLikematchSuccess,
  unLikematchError,


  liveMatchSocketUpdate
}

class LiveScoreState extends Equatable {
  final LiveScoreStatus status;
  final ResponseData? responseData;
  final ErrorData? errorData;
  final String? error;
  final List<SocketLiveMatchResponse>? socketLiveData;

  const LiveScoreState({
    this.status = LiveScoreStatus.initial,
    this.responseData,
    this.errorData,
    this.error,
    this.socketLiveData,
  });

  @override
  List<Object?> get props => [
        status,
        responseData,
        errorData,
        error,
    socketLiveData
      ];

  LiveScoreState copyWith({
    LiveScoreStatus? status,
    ResponseData? responseData,
    ErrorData? errorData,
    String? error,
    String? message,
    List<SocketLiveMatchResponse>? socketLiveData,
  }) {
    return LiveScoreState(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
      errorData: errorData ?? this.errorData,
      error: error ?? this.error,
      socketLiveData: socketLiveData?? this.socketLiveData
    );
  }
}
