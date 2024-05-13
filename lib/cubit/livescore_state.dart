
part of 'livescore_cubit.dart';



enum LiveScoreStatus {
  initial,

  privacyPolicyLoading,
  privacyPolicySuccess,
  privacyPolicyError,

  termsAndConditionsLoading,
  termsAndConditionsSuccess,
  termsAndConditionsError,

  helpAndSupportLoading,
  helpAndSupportSuccess,
  helpAndSupportError,

  liveScoreLoading,
  liveScoreSuccess,
  liveScoreError,

  liveScoreLoading1,
  liveScoreSuccess1,
  liveScoreError1,



}


class LiveScoreState extends Equatable {
  final LiveScoreStatus status;
  final ResponseData? responseData;
  final ErrorData? errorData;
  final String? error;

  const LiveScoreState({
    this.status = LiveScoreStatus.initial,
    this.responseData,
    this.errorData,
    this.error,

  });

  @override
  List<Object?> get props => [
    status,
    responseData,
    errorData,
    error,

  ];

  LiveScoreState copyWith({
    LiveScoreStatus? status,
    ResponseData? responseData,
    ErrorData? errorData,
    String? error,
    String? message,
  }) {
    return LiveScoreState(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
      errorData: errorData ?? this.errorData,
      error: error ?? this.error,

    );
  }
}


