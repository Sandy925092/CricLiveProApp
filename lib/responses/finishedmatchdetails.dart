class FinishedMatchDetailsResponse {
  final bool? success;
  final String? message;
  final Data? data;

  FinishedMatchDetailsResponse({
    this.success,
    this.message,
    this.data,
  });

  FinishedMatchDetailsResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final num? fixtureId;
  final num? seriesId;
  final String? seriesName;
  final String? matchStatus;
  final num? teamAId;
  final String? teamAName;
  final num? teamBId;
  final String? teamBName;
  final TossInfo? tossInfo;
  final List<InningsDetails>? innings;
  final Result? result;
  final List<TeamLineupsDetails>? teamLineups;
  final String? updatedAt;

  Data({
    this.fixtureId,
    this.seriesId,
    this.seriesName,
    this.matchStatus,
    this.teamAId,
    this.teamAName,
    this.teamBId,
    this.teamBName,
    this.tossInfo,
    this.innings,
    this.result,
    this.teamLineups,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : fixtureId = json['fixtureId'] as num?,
        seriesId = json['seriesId'] as num?,
        seriesName = json['seriesName'] as String?,
        matchStatus = json['matchStatus'] as String?,
        teamAId = json['teamAId'] as num?,
        teamAName = json['teamAName'] as String?,
        teamBId = json['teamBId'] as num?,
        teamBName = json['teamBName'] as String?,
        tossInfo = (json['tossInfo'] as Map<String,dynamic>?) != null ? TossInfo.fromJson(json['tossInfo'] as Map<String,dynamic>) : null,
        innings = (json['innings'] as List?)?.map((dynamic e) => InningsDetails.fromJson(e as Map<String,dynamic>)).toList(),
        result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null,
        teamLineups = (json['teamLineups'] as List?)?.map((dynamic e) => TeamLineupsDetails.fromJson(e as Map<String,dynamic>)).toList(),
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    'fixtureId' : fixtureId,
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'matchStatus' : matchStatus,
    'teamAId' : teamAId,
    'teamAName' : teamAName,
    'teamBId' : teamBId,
    'teamBName' : teamBName,
    'tossInfo' : tossInfo?.toJson(),
    'innings' : innings?.map((e) => e.toJson()).toList(),
    'result' : result?.toJson(),
    'teamLineups' : teamLineups?.map((e) => e.toJson()).toList(),
    'updatedAt' : updatedAt
  };
}

class TossInfo {
  final num? tossWinnerTeamId;
  final String? decision;
  final num? sequenceNumber;

  TossInfo({
    this.tossWinnerTeamId,
    this.decision,
    this.sequenceNumber,
  });

  TossInfo.fromJson(Map<String, dynamic> json)
      : tossWinnerTeamId = json['tossWinnerTeamId'] as num?,
        decision = json['decision'] as String?,
        sequenceNumber = json['sequenceNumber'] as num?;

  Map<String, dynamic> toJson() => {
    'tossWinnerTeamId' : tossWinnerTeamId,
    'decision' : decision,
    'sequenceNumber' : sequenceNumber
  };
}

class InningsDetails {
  final num? inningNumber;
  final BattingTeam? battingTeam;
  final BowlingTeam? bowlingTeam;
  final List<BattersDetails>? batters;
  final List<BowlersDetails>? bowlers;
  final ExtrasDetails? extras;
  final num? currentRunRate;
  final dynamic requiredRunRate;
  final num? target;
  final List<FallOfWicketsDetails>? fallOfWickets;
  final List<PartnershipsDetails>? partnerships;
  final dynamic maxOversPerDay;
  final dynamic totalOvers;
  final List<Powerplays>? powerplays;
  final List<Interruptions>? interruptions;
  final bool? ended;
  final num? legalBalls;
  final List<YetToBatDetails>? yetToBat;
  final List<OverSummariesDetails>? overSummaries;

  InningsDetails({
    this.inningNumber,
    this.battingTeam,
    this.bowlingTeam,
    this.batters,
    this.bowlers,
    this.extras,
    this.currentRunRate,
    this.requiredRunRate,
    this.target,
    this.fallOfWickets,
    this.partnerships,
    this.maxOversPerDay,
    this.totalOvers,
    this.powerplays,
    this.interruptions,
    this.ended,
    this.legalBalls,
    this.yetToBat,
    this.overSummaries,
  });

  InningsDetails.fromJson(Map<String, dynamic> json)
      : inningNumber = json['inningNumber'] as num?,
        battingTeam = (json['battingTeam'] as Map<String,dynamic>?) != null ? BattingTeam.fromJson(json['battingTeam'] as Map<String,dynamic>) : null,
        bowlingTeam = (json['bowlingTeam'] as Map<String,dynamic>?) != null ? BowlingTeam.fromJson(json['bowlingTeam'] as Map<String,dynamic>) : null,
        batters = (json['batters'] as List?)?.map((dynamic e) => BattersDetails.fromJson(e as Map<String,dynamic>)).toList(),
        bowlers = (json['bowlers'] as List?)?.map((dynamic e) => BowlersDetails.fromJson(e as Map<String,dynamic>)).toList(),
        extras = (json['extras'] as Map<String,dynamic>?) != null ? ExtrasDetails.fromJson(json['extras'] as Map<String,dynamic>) : null,
        currentRunRate = json['currentRunRate'] as num?,
        requiredRunRate = json['requiredRunRate'],
        target = json['target'] as num?,
        fallOfWickets = (json['fallOfWickets'] as List?)?.map((dynamic e) => FallOfWicketsDetails.fromJson(e as Map<String,dynamic>)).toList(),
        partnerships = (json['partnerships'] as List?)?.map((dynamic e) => PartnershipsDetails.fromJson(e as Map<String,dynamic>)).toList(),
        maxOversPerDay = json['maxOversPerDay'],
        totalOvers = json['totalOvers'],
        powerplays = (json['powerplays'] as List?)?.map((dynamic e) => Powerplays.fromJson(e as Map<String,dynamic>)).toList(),
        interruptions = (json['interruptions'] as List?)?.map((dynamic e) => Interruptions.fromJson(e as Map<String,dynamic>)).toList(),
        ended = json['ended'] as bool?,
        legalBalls = json['legalBalls'] as num?,
        yetToBat = (json['yetToBat'] as List?)?.map((dynamic e) => YetToBatDetails.fromJson(e as Map<String,dynamic>)).toList(),
        overSummaries = (json['overSummaries'] as List?)?.map((dynamic e) => OverSummariesDetails.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'inningNumber' : inningNumber,
    'battingTeam' : battingTeam?.toJson(),
    'bowlingTeam' : bowlingTeam?.toJson(),
    'batters' : batters?.map((e) => e.toJson()).toList(),
    'bowlers' : bowlers?.map((e) => e.toJson()).toList(),
    'extras' : extras?.toJson(),
    'currentRunRate' : currentRunRate,
    'requiredRunRate' : requiredRunRate,
    'target' : target,
    'fallOfWickets' : fallOfWickets?.map((e) => e.toJson()).toList(),
    'partnerships' : partnerships?.map((e) => e.toJson()).toList(),
    'maxOversPerDay' : maxOversPerDay,
    'totalOvers' : totalOvers,
    'powerplays' : powerplays?.map((e) => e.toJson()).toList(),
    'interruptions' : interruptions?.map((e) => e.toJson()).toList(),
    'ended' : ended,
    'legalBalls' : legalBalls,
    'yetToBat' : yetToBat?.map((e) => e.toJson()).toList(),
    'overSummaries' : overSummaries?.map((e) => e.toJson()).toList()
  };
}

class Interruptions {
  final num? inningNumber;
  final dynamic deliveryId;
  final dynamic reason;
  final num? sequenceNumber;
  final String? timestamp;

  Interruptions({
    this.inningNumber,
    this.deliveryId,
    this.reason,
    this.sequenceNumber,
    this.timestamp,
  });

  Interruptions.fromJson(Map<String, dynamic> json)
      : inningNumber = json['inningNumber'] as num?,
        deliveryId = json['deliveryId'],
        reason = json['reason'],
        sequenceNumber = json['sequenceNumber'] as num?,
        timestamp = json['timestamp'] as String?;

  Map<String, dynamic> toJson() => {
    'inningNumber' : inningNumber,
    'deliveryId' : deliveryId,
    'reason' : reason,
    'sequenceNumber' : sequenceNumber,
    'timestamp' : timestamp
  };
}


class BattingTeam {
  final num? teamId;
  final dynamic teamName;
  final num? runs;
  final num? wickets;
  final double? overs;

  BattingTeam({
    this.teamId,
    this.teamName,
    this.runs,
    this.wickets,
    this.overs,
  });

  BattingTeam.fromJson(Map<String, dynamic> json)
      : teamId = json['teamId'] as num?,
        teamName = json['teamName'],
        runs = json['runs'] as num?,
        wickets = json['wickets'] as num?,
        overs = json['overs'] as double?;

  Map<String, dynamic> toJson() => {
    'teamId' : teamId,
    'teamName' : teamName,
    'runs' : runs,
    'wickets' : wickets,
    'overs' : overs
  };
}

class BowlingTeam {
  final num? teamId;
  final dynamic teamName;
  final num? runs;
  final num? wickets;
  final num? overs;

  BowlingTeam({
    this.teamId,
    this.teamName,
    this.runs,
    this.wickets,
    this.overs,
  });

  BowlingTeam.fromJson(Map<String, dynamic> json)
      : teamId = json['teamId'] as num?,
        teamName = json['teamName'],
        runs = json['runs'] as num?,
        wickets = json['wickets'] as num?,
        overs = json['overs'] as num?;

  Map<String, dynamic> toJson() => {
    'teamId' : teamId,
    'teamName' : teamName,
    'runs' : runs,
    'wickets' : wickets,
    'overs' : overs
  };
}

class BattersDetails {
  final num? playerId;
  final String? playerName;
  final num? runs;
  final num? balls;
  final num? fours;
  final num? sixes;
  final num? strikeRate;
  final String? playerStatus;
  final String? dismissal;
  final bool? isOut;

  BattersDetails({
    this.playerId,
    this.playerName,
    this.runs,
    this.balls,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.playerStatus,
    this.dismissal,
    this.isOut,
  });

  BattersDetails.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'] as num?,
        playerName = json['playerName'] as String?,
        runs = json['runs'] as num?,
        balls = json['balls'] as num?,
        fours = json['fours'] as num?,
        sixes = json['sixes'] as num?,
        strikeRate = json['strikeRate'] as num?,
        playerStatus = json['playerStatus'] as String?,
        dismissal = json['dismissal'] as String?,
        isOut = json['isOut'] as bool?;

  Map<String, dynamic> toJson() => {
    'playerId' : playerId,
    'playerName' : playerName,
    'runs' : runs,
    'balls' : balls,
    'fours' : fours,
    'sixes' : sixes,
    'strikeRate' : strikeRate,
    'playerStatus' : playerStatus,
    'dismissal' : dismissal,
    'isOut' : isOut
  };
}

class BowlersDetails {
  final num? playerId;
  final String? playerName;
  final num? overs;
  final num? maidens;
  final num? runsConceded;
  final num? wickets;
  final double? economyRate;

  BowlersDetails({
    this.playerId,
    this.playerName,
    this.overs,
    this.maidens,
    this.runsConceded,
    this.wickets,
    this.economyRate,
  });

  BowlersDetails.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'] as num?,
        playerName = json['playerName'] as String?,
        overs = json['overs'] as num?,
        maidens = json['maidens'] as num?,
        runsConceded = json['runsConceded'] as num?,
        wickets = json['wickets'] as num?,
        economyRate = json['economyRate'] as double?;

  Map<String, dynamic> toJson() => {
    'playerId' : playerId,
    'playerName' : playerName,
    'overs' : overs,
    'maidens' : maidens,
    'runsConceded' : runsConceded,
    'wickets' : wickets,
    'economyRate' : economyRate
  };
}

class ExtrasDetails {
  final num? byes;
  final num? legByes;
  final num? wides;
  final num? noBalls;
  final num? penalty;
  final num? total;

  ExtrasDetails({
    this.byes,
    this.legByes,
    this.wides,
    this.noBalls,
    this.penalty,
    this.total,
  });

  ExtrasDetails.fromJson(Map<String, dynamic> json)
      : byes = json['byes'] as num?,
        legByes = json['legByes'] as num?,
        wides = json['wides'] as num?,
        noBalls = json['noBalls'] as num?,
        penalty = json['penalty'] as num?,
        total = json['total'] as num?;

  Map<String, dynamic> toJson() => {
    'byes' : byes,
    'legByes' : legByes,
    'wides' : wides,
    'noBalls' : noBalls,
    'penalty' : penalty,
    'total' : total
  };
}

class FallOfWicketsDetails {
  final num? wicketNumber;
  final num? scoreAtFall;
  final double? overAtFall;
  final num? playerId;
  final String? playerName;

  FallOfWicketsDetails({
    this.wicketNumber,
    this.scoreAtFall,
    this.overAtFall,
    this.playerId,
    this.playerName,
  });

  FallOfWicketsDetails.fromJson(Map<String, dynamic> json)
      : wicketNumber = json['wicketNumber'] as num?,
        scoreAtFall = json['scoreAtFall'] as num?,
        overAtFall = json['overAtFall'] as double?,
        playerId = json['playerId'] as num?,
        playerName = json['playerName'] as String?;

  Map<String, dynamic> toJson() => {
    'wicketNumber' : wicketNumber,
    'scoreAtFall' : scoreAtFall,
    'overAtFall' : overAtFall,
    'playerId' : playerId,
    'playerName' : playerName
  };
}

class PartnershipsDetails {
  final num? wicketNumber;
  final Batsman1? batsman1;
  final Batsman2? batsman2;
  final num? totalRuns;
  final num? totalBalls;

  PartnershipsDetails({
    this.wicketNumber,
    this.batsman1,
    this.batsman2,
    this.totalRuns,
    this.totalBalls,
  });

  PartnershipsDetails.fromJson(Map<String, dynamic> json)
      : wicketNumber = json['wicketNumber'] as num?,
        batsman1 = (json['batsman1'] as Map<String,dynamic>?) != null ? Batsman1.fromJson(json['batsman1'] as Map<String,dynamic>) : null,
        batsman2 = (json['batsman2'] as Map<String,dynamic>?) != null ? Batsman2.fromJson(json['batsman2'] as Map<String,dynamic>) : null,
        totalRuns = json['totalRuns'] as num?,
        totalBalls = json['totalBalls'] as num?;

  Map<String, dynamic> toJson() => {
    'wicketNumber' : wicketNumber,
    'batsman1' : batsman1?.toJson(),
    'batsman2' : batsman2?.toJson(),
    'totalRuns' : totalRuns,
    'totalBalls' : totalBalls
  };
}

class Batsman1 {
  final num? playerId;
  final String? playerName;
  final num? runs;
  final num? balls;

  Batsman1({
    this.playerId,
    this.playerName,
    this.runs,
    this.balls,
  });

  Batsman1.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'] as num?,
        playerName = json['playerName'] as String?,
        runs = json['runs'] as num?,
        balls = json['balls'] as num?;

  Map<String, dynamic> toJson() => {
    'playerId' : playerId,
    'playerName' : playerName,
    'runs' : runs,
    'balls' : balls
  };
}

class Batsman2 {
  final num? playerId;
  final String? playerName;
  final num? runs;
  final num? balls;

  Batsman2({
    this.playerId,
    this.playerName,
    this.runs,
    this.balls,
  });

  Batsman2.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'] as num?,
        playerName = json['playerName'] as String?,
        runs = json['runs'] as num?,
        balls = json['balls'] as num?;

  Map<String, dynamic> toJson() => {
    'playerId' : playerId,
    'playerName' : playerName,
    'runs' : runs,
    'balls' : balls
  };
}

class Powerplays {
  final num? inningNumber;
  final num? firstOver;
  final num? lastOver;
  final String? type;
  final num? sequenceNumber;

  Powerplays({
    this.inningNumber,
    this.firstOver,
    this.lastOver,
    this.type,
    this.sequenceNumber,
  });

  Powerplays.fromJson(Map<String, dynamic> json)
      : inningNumber = json['inningNumber'] as num?,
        firstOver = json['firstOver'] as num?,
        lastOver = json['lastOver'] as num?,
        type = json['type'] as String?,
        sequenceNumber = json['sequenceNumber'] as num?;

  Map<String, dynamic> toJson() => {
    'inningNumber' : inningNumber,
    'firstOver' : firstOver,
    'lastOver' : lastOver,
    'type' : type,
    'sequenceNumber' : sequenceNumber
  };
}

class numerruptions {
  final num? inningNumber;
  final dynamic deliveryId;
  final dynamic reason;
  final num? sequenceNumber;
  final String? timestamp;

  numerruptions({
    this.inningNumber,
    this.deliveryId,
    this.reason,
    this.sequenceNumber,
    this.timestamp,
  });

  numerruptions.fromJson(Map<String, dynamic> json)
      : inningNumber = json['inningNumber'] as num?,
        deliveryId = json['deliveryId'],
        reason = json['reason'],
        sequenceNumber = json['sequenceNumber'] as num?,
        timestamp = json['timestamp'] as String?;

  Map<String, dynamic> toJson() => {
    'inningNumber' : inningNumber,
    'deliveryId' : deliveryId,
    'reason' : reason,
    'sequenceNumber' : sequenceNumber,
    'timestamp' : timestamp
  };
}

class YetToBatDetails {
  final num? id;
  final String? name;
  final num? batOrder;
  final String? role;
  final String? battingHandedness;
  final String? bowlingHandedness;
  final String? bowlingStyle;

  YetToBatDetails({
    this.id,
    this.name,
    this.batOrder,
    this.role,
    this.battingHandedness,
    this.bowlingHandedness,
    this.bowlingStyle,
  });

  YetToBatDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num?,
        name = json['name'] as String?,
        batOrder = json['batOrder'] as num?,
        role = json['role'] as String?,
        battingHandedness = json['battingHandedness'] as String?,
        bowlingHandedness = json['bowlingHandedness'] as String?,
        bowlingStyle = json['bowlingStyle'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'batOrder' : batOrder,
    'role' : role,
    'battingHandedness' : battingHandedness,
    'bowlingHandedness' : bowlingHandedness,
    'bowlingStyle' : bowlingStyle
  };
}

class OverSummariesDetails {
  final num? overNumber;
  final List<String>? balls;
  final num? totalRuns;

  OverSummariesDetails({
    this.overNumber,
    this.balls,
    this.totalRuns,
  });

  OverSummariesDetails.fromJson(Map<String, dynamic> json)
      : overNumber = json['overNumber'] as num?,
        balls = (json['balls'] as List?)?.map((dynamic e) => e as String).toList(),
        totalRuns = json['totalRuns'] as num?;

  Map<String, dynamic> toJson() => {
    'overNumber' : overNumber,
    'balls' : balls,
    'totalRuns' : totalRuns
  };
}

class Result {
  final String? type;
  final num? winningTeamId;
  final num? marginRuns;
  final dynamic marginWickets;
  final num? sequenceNumber;

  Result({
    this.type,
    this.winningTeamId,
    this.marginRuns,
    this.marginWickets,
    this.sequenceNumber,
  });

  Result.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        winningTeamId = json['winningTeamId'] as num?,
        marginRuns = json['marginRuns'] as num?,
        marginWickets = json['marginWickets'],
        sequenceNumber = json['sequenceNumber'] as num?;

  Map<String, dynamic> toJson() => {
    'type' : type,
    'winningTeamId' : winningTeamId,
    'marginRuns' : marginRuns,
    'marginWickets' : marginWickets,
    'sequenceNumber' : sequenceNumber
  };
}

class TeamLineupsDetails {
  final num? teamId;
  final num? sequenceNumber;
  final num? captainId;
  final String? captainName;
  final num? wicketKeeperId;
  final String? wicketKeeperName;
  final List<Lineup>? lineup;

  TeamLineupsDetails({
    this.teamId,
    this.sequenceNumber,
    this.captainId,
    this.captainName,
    this.wicketKeeperId,
    this.wicketKeeperName,
    this.lineup,
  });

  TeamLineupsDetails.fromJson(Map<String, dynamic> json)
      : teamId = json['teamId'] as num?,
        sequenceNumber = json['sequenceNumber'] as num?,
        captainId = json['captainId'] as num?,
        captainName = json['captainName'] as String?,
        wicketKeeperId = json['wicketKeeperId'] as num?,
        wicketKeeperName = json['wicketKeeperName'] as String?,
        lineup = (json['lineup'] as List?)?.map((dynamic e) => Lineup.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'teamId' : teamId,
    'sequenceNumber' : sequenceNumber,
    'captainId' : captainId,
    'captainName' : captainName,
    'wicketKeeperId' : wicketKeeperId,
    'wicketKeeperName' : wicketKeeperName,
    'lineup' : lineup?.map((e) => e.toJson()).toList()
  };
}

class Lineup {
  final num? id;
  final String? name;
  final num? batOrder;
  final String? role;
  final String? battingHandedness;
  final String? bowlingHandedness;
  final String? bowlingStyle;

  Lineup({
    this.id,
    this.name,
    this.batOrder,
    this.role,
    this.battingHandedness,
    this.bowlingHandedness,
    this.bowlingStyle,
  });

  Lineup.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num?,
        name = json['name'] as String?,
        batOrder = json['batOrder'] as num?,
        role = json['role'] as String?,
        battingHandedness = json['battingHandedness'] as String?,
        bowlingHandedness = json['bowlingHandedness'] as String?,
        bowlingStyle = json['bowlingStyle'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'batOrder' : batOrder,
    'role' : role,
    'battingHandedness' : battingHandedness,
    'bowlingHandedness' : bowlingHandedness,
    'bowlingStyle' : bowlingStyle
  };
}