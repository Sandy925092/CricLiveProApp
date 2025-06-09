class FinishedMatchResponse {
  final bool? success;
  final String? message;
  final List<MatchData>? data;

  FinishedMatchResponse({
    this.success,
    this.message,
    this.data,
  });

  FinishedMatchResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => MatchData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class MatchData {
  final num? fixtureId;
  final String? homeTeam;
  final String? awayTeam;
  final List<num>? homeTeamRuns;
  final List<num>? homeTeamWickets;
  final List<num>? awayTeamRuns;
  final List<num>? awayTeamWickets;
  final String? winningTeamName;
  final bool? result;

  MatchData({
    this.fixtureId,
    this.homeTeam,
    this.awayTeam,
    this.homeTeamRuns,
    this.homeTeamWickets,
    this.awayTeamRuns,
    this.awayTeamWickets,
    this.winningTeamName,
    this.result,
  });

  MatchData.fromJson(Map<String, dynamic> json)
      : fixtureId = json['fixtureId'] as num?,
        homeTeam = json['homeTeam'] as String?,
        awayTeam = json['awayTeam'] as String?,
        homeTeamRuns = (json['homeTeamRuns'] as List?)?.map((dynamic e) => e as num).toList(),
        homeTeamWickets = (json['homeTeamWickets'] as List?)?.map((dynamic e) => e as num).toList(),
        awayTeamRuns = (json['awayTeamRuns'] as List?)?.map((dynamic e) => e as num).toList(),
        awayTeamWickets = (json['awayTeamWickets'] as List?)?.map((dynamic e) => e as num).toList(),
        winningTeamName = json['winningTeamName'] as String?,
        result = json['result'] as bool?;

  Map<String, dynamic> toJson() => {
    'fixtureId' : fixtureId,
    'homeTeam' : homeTeam,
    'awayTeam' : awayTeam,
    'homeTeamRuns' : homeTeamRuns,
    'homeTeamWickets' : homeTeamWickets,
    'awayTeamRuns' : awayTeamRuns,
    'awayTeamWickets' : awayTeamWickets,
    'winningTeamName' : winningTeamName,
    'result' : result
  };
}