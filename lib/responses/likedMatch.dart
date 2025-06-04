class LikedMatchResponse {
  final bool? success;
  final String? message;
  final List<LikedMatchData>? data;

  LikedMatchResponse({
    this.success,
    this.message,
    this.data,
  });

  LikedMatchResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => LikedMatchData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class LikedMatchData {
  final num? seriesId;
  final String? seriesName;
  final List<LikedFixtures>? likedFixtures;

  LikedMatchData({
    this.seriesId,
    this.seriesName,
    this.likedFixtures,
  });

  LikedMatchData.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'] as num?,
        seriesName = json['seriesName'] as String?,
        likedFixtures = (json['likedFixtures'] as List?)?.map((dynamic e) => LikedFixtures.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'likedFixtures' : likedFixtures?.map((e) => e.toJson()).toList()
  };
}

class LikedFixtures {
  final num? seriesId;
  final String? seriesName;
  final num? fixtureId;
  final String? teamAName;
  final String? teamBName;
  final String? matchStatus;
  final String? matchDate;
  final String? likedAt;

  LikedFixtures({
    this.seriesId,
    this.seriesName,
    this.fixtureId,
    this.teamAName,
    this.teamBName,
    this.matchStatus,
    this.matchDate,
    this.likedAt,
  });

  LikedFixtures.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'] as num?,
        seriesName = json['seriesName'] as String?,
        fixtureId = json['fixtureId'] as num?,
        teamAName = json['teamAName'] as String?,
        teamBName = json['teamBName'] as String?,
        matchStatus = json['matchStatus'] as String?,
        matchDate = json['matchDate'] as String?,
        likedAt = json['likedAt'] as String?;

  Map<String, dynamic> toJson() => {
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'fixtureId' : fixtureId,
    'teamAName' : teamAName,
    'teamBName' : teamBName,
    'matchStatus' : matchStatus,
    'matchDate' : matchDate,
    'likedAt' : likedAt
  };
}