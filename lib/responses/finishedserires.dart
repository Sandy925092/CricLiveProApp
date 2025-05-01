class FinishedSeriesResponse {
  final bool? success;
  final String? message;
  final List<Data>? data;

  FinishedSeriesResponse({
    this.success,
    this.message,
    this.data,
  });

  FinishedSeriesResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? seriesId;
  final String? seriesName;
  final String? fromDate;
  final String? toDate;
  final String? gender;
  final String? seriesType;
  final String? fixtureType;
  final List<Fixtures>? fixtures;

  Data({
    this.seriesId,
    this.seriesName,
    this.fromDate,
    this.toDate,
    this.gender,
    this.seriesType,
    this.fixtureType,
    this.fixtures,
  });

  Data.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'] as int?,
        seriesName = json['seriesName'] as String?,
        fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?,
        gender = json['gender'] as String?,
        seriesType = json['seriesType'] as String?,
        fixtureType = json['fixtureType'] as String?,
        fixtures = (json['fixtures'] as List?)?.map((dynamic e) => Fixtures.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'fromDate' : fromDate,
    'toDate' : toDate,
    'gender' : gender,
    'seriesType' : seriesType,
    'fixtureType' : fixtureType,
    'fixtures' : fixtures?.map((e) => e.toJson()).toList()
  };
}

class Fixtures {
  final int? fixtureId;
  final String? status;
  final List<StartTimes>? startTimes;
  final HomeTeam? homeTeam;
  final AwayTeam? awayTeam;
  final dynamic winningTeam;
  final dynamic totalScore;

  Fixtures({
    this.fixtureId,
    this.status,
    this.startTimes,
    this.homeTeam,
    this.awayTeam,
    this.winningTeam,
    this.totalScore,
  });

  Fixtures.fromJson(Map<String, dynamic> json)
      : fixtureId = json['fixtureId'] as int?,
        status = json['status'] as String?,
        startTimes = (json['startTimes'] as List?)?.map((dynamic e) => StartTimes.fromJson(e as Map<String,dynamic>)).toList(),
        homeTeam = (json['homeTeam'] as Map<String,dynamic>?) != null ? HomeTeam.fromJson(json['homeTeam'] as Map<String,dynamic>) : null,
        awayTeam = (json['awayTeam'] as Map<String,dynamic>?) != null ? AwayTeam.fromJson(json['awayTeam'] as Map<String,dynamic>) : null,
        winningTeam = json['winningTeam'],
        totalScore = json['totalScore'];

  Map<String, dynamic> toJson() => {
    'fixtureId' : fixtureId,
    'status' : status,
    'startTimes' : startTimes?.map((e) => e.toJson()).toList(),
    'homeTeam' : homeTeam?.toJson(),
    'awayTeam' : awayTeam?.toJson(),
    'winningTeam' : winningTeam,
    'totalScore' : totalScore
  };
}

class StartTimes {
  final int? day;
  final String? date;
  final String? time;

  StartTimes({
    this.day,
    this.date,
    this.time,
  });

  StartTimes.fromJson(Map<String, dynamic> json)
      : day = json['day'] as int?,
        date = json['date'] as String?,
        time = json['time'] as String?;

  Map<String, dynamic> toJson() => {
    'day' : day,
    'date' : date,
    'time' : time
  };
}

class HomeTeam {
  final int? id;
  final String? name;
  final String? ageCategory;
  final String? gender;

  HomeTeam({
    this.id,
    this.name,
    this.ageCategory,
    this.gender,
  });

  HomeTeam.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        ageCategory = json['ageCategory'] as String?,
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'ageCategory' : ageCategory,
    'gender' : gender
  };
}

class AwayTeam {
  final int? id;
  final String? name;
  final String? ageCategory;
  final String? gender;

  AwayTeam({
    this.id,
    this.name,
    this.ageCategory,
    this.gender,
  });

  AwayTeam.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        ageCategory = json['ageCategory'] as String?,
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'ageCategory' : ageCategory,
    'gender' : gender
  };
}