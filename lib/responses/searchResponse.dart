class SearchResponse {
  final bool? success;
  final String? message;
  final List<SearchData>? data;

  SearchResponse({
    this.success,
    this.message,
    this.data,
  });

  SearchResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => SearchData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class SearchData {
  final num? seriesId;
  final String? seriesName;
  final List<Matches>? matches;

  SearchData({
    this.seriesId,
    this.seriesName,
    this.matches,
  });

  SearchData.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'] as num?,
        seriesName = json['seriesName'] as String?,
        matches = (json['matches'] as List?)?.map((dynamic e) => Matches.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'matches' : matches?.map((e) => e.toJson()).toList()
  };
}

class Matches {
  final num? fixtureId;
  final String? homeTeam;
  final String? awayTeam;
  final bool? result;
  final List<num>? homeTeamRuns;
  final List<num>? homeTeamWickets;
  final List<num>? awayTeamRuns;
  final List<num>? awayTeamWickets;
  final String? winningTeamName;
  final String? startDateTime;
  final bool? upcoming;

  Matches({
    this.fixtureId,
    this.homeTeam,
    this.awayTeam,
    this.result,
    this.homeTeamRuns,
    this.homeTeamWickets,
    this.awayTeamRuns,
    this.awayTeamWickets,
    this.winningTeamName,
    this.startDateTime,
    this.upcoming,
  });

  Matches.fromJson(Map<String, dynamic> json)
      : fixtureId = json['fixtureId'] as num?,
        homeTeam = json['homeTeam'] as String?,
        awayTeam = json['awayTeam'] as String?,
        result = json['result'] as bool?,
        homeTeamRuns = (json['homeTeamRuns'] as List?)?.map((dynamic e) => e as num).toList(),
        homeTeamWickets = (json['homeTeamWickets'] as List?)?.map((dynamic e) => e as num).toList(),
        awayTeamRuns = (json['awayTeamRuns'] as List?)?.map((dynamic e) => e as num).toList(),
        awayTeamWickets = (json['awayTeamWickets'] as List?)?.map((dynamic e) => e as num).toList(),
        winningTeamName = json['winningTeamName'] as String?,
        startDateTime = json['startDateTime'] as String?,
        upcoming = json['upcoming'] as bool?;

  Map<String, dynamic> toJson() => {
    'fixtureId' : fixtureId,
    'homeTeam' : homeTeam,
    'awayTeam' : awayTeam,
    'result' : result,
    'homeTeamRuns' : homeTeamRuns,
    'homeTeamWickets' : homeTeamWickets,
    'awayTeamRuns' : awayTeamRuns,
    'awayTeamWickets' : awayTeamWickets,
    'winningTeamName' : winningTeamName,
    'startDateTime' : startDateTime,
    'upcoming' : upcoming
  };
}