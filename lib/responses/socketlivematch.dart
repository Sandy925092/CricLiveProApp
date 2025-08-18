class SocketLiveMatchResponse {
  final dynamic seriesId;
  final dynamic seriesName;
  final List<Matches>? matches;

  SocketLiveMatchResponse({
    this.seriesId,
    this.seriesName,
    this.matches,
  });

  SocketLiveMatchResponse.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'],
        seriesName = json['seriesName'],
        matches = (json['matches'] as List?)?.map((dynamic e) => Matches.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'matches' : matches?.map((e) => e.toJson()).toList()
  };
}

class Matches {
  final num? fixtureId;
  final dynamic seriesId;
  final dynamic seriesName;
  final String? matchStatus;
  final num? teamAId;
  final String? teamAName;
  final num? teamBId;
  final String? teamBName;
  final String? teamAFlagUrl;
  final String? teamBFlagUrl;
  final TossInfo? tossInfo;
  final List<Innings>? innings;
  final Interruptions? interruptions;
  final Result? result;
  final List<TeamLineups>? teamLineups;
  final String? updatedAt;

  Matches({
    this.fixtureId,
    this.seriesId,
    this.seriesName,
    this.matchStatus,
    this.teamAId,
    this.teamAName,
    this.teamBId,
    this.teamBName,
    this.teamAFlagUrl,
    this.teamBFlagUrl,
    this.tossInfo,
    this.innings,
    this.interruptions,
    this.result,
    this.teamLineups,
    this.updatedAt,
  });

  Matches.fromJson(Map<String, dynamic> json)
      : fixtureId = json['fixtureId'] as int?,
        seriesId = json['seriesId'],
        seriesName = json['seriesName'],
        matchStatus = json['matchStatus'] as String?,
        teamAId = json['teamAId'] as int?,
        teamAName = json['teamAName'] as String?,
        teamBId = json['teamBId'] as int?,
        teamBName = json['teamBName'] as String?,
        teamAFlagUrl = json['teamAFlagUrl'] as String?,
        teamBFlagUrl = json['teamBFlagUrl'] as String?,
        tossInfo = (json['tossInfo'] as Map<String,dynamic>?) != null ? TossInfo.fromJson(json['tossInfo'] as Map<String,dynamic>) : null,
        innings = (json['innings'] as List?)?.map((dynamic e) => Innings.fromJson(e as Map<String,dynamic>)).toList(),
        interruptions = (json['interruption'] as Map<String,dynamic>?) != null ? Interruptions.fromJson(json['interruption'] as Map<String,dynamic>) : null,
      result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null,
        teamLineups = (json['teamLineups'] as List?)?.map((dynamic e) => TeamLineups.fromJson(e as Map<String,dynamic>)).toList(),
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
    'teamAFlagUrl' : teamAFlagUrl,
    'teamBFlagUrl' : teamBFlagUrl,
    'tossInfo' : tossInfo?.toJson(),
    'innings' : innings?.map((e) => e.toJson()).toList(),
    'interruption' : interruptions?.toJson(),
    'result' : result?.toJson(),

    'teamLineups' : teamLineups?.map((e) => e.toJson()).toList(),
    'updatedAt' : updatedAt
  };
}

class TossInfo {
  final int? tossWinnerTeamId;
  final String? decision;
  final int? sequenceNumber;

  TossInfo({
    this.tossWinnerTeamId,
    this.decision,
    this.sequenceNumber,
  });

  TossInfo.fromJson(Map<String, dynamic> json)
      : tossWinnerTeamId = json['tossWinnerTeamId'] as int?,
        decision = json['decision'] as String?,
        sequenceNumber = json['sequenceNumber'] as int?;

  Map<String, dynamic> toJson() => {
    'tossWinnerTeamId' : tossWinnerTeamId,
    'decision' : decision,
    'sequenceNumber' : sequenceNumber
  };
}

class Innings {
  final num? inningNumber;
  final BattingTeam? battingTeam;
  final BowlingTeam? bowlingTeam;
  final List<Batters>? batters;
  final List<Bowlers>? bowlers;
  final Extras? extras;
  final num? currentRunRate;
  final dynamic requiredRunRate;
  final dynamic target;
  final List<FallOfWickets>? fallOfWickets;
  final List<Partnerships>? partnerships;
  final List<MaxOversPerDay>? maxOversPerDay;
  final List<YetToBat>? yetToBat;
  final num? totalOvers;
  final List<dynamic>? powerplays;

  final List<OverSummaries>? overSummaries;
  final bool? ended;
  final num? legalBalls;

  Innings({
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
    this.yetToBat,
    this.totalOvers,
    this.powerplays,
    this.overSummaries,
    this.ended,
    this.legalBalls,
  });

  Innings.fromJson(Map<String, dynamic> json)
      : inningNumber = json['inningNumber'] as num?,
        battingTeam = (json['battingTeam'] as Map<String,dynamic>?) != null ? BattingTeam.fromJson(json['battingTeam'] as Map<String,dynamic>) : null,
        bowlingTeam = (json['bowlingTeam'] as Map<String,dynamic>?) != null ? BowlingTeam.fromJson(json['bowlingTeam'] as Map<String,dynamic>) : null,
        batters = (json['batters'] as List?)?.map((dynamic e) => Batters.fromJson(e as Map<String,dynamic>)).toList(),
        bowlers = (json['bowlers'] as List?)?.map((dynamic e) => Bowlers.fromJson(e as Map<String,dynamic>)).toList(),
        extras = (json['extras'] as Map<String,dynamic>?) != null ? Extras.fromJson(json['extras'] as Map<String,dynamic>) : null,
        currentRunRate = json['currentRunRate'] as num?,
        requiredRunRate = json['requiredRunRate'],
        target = json['target'],
        fallOfWickets = (json['fallOfWickets'] as List?)?.map((dynamic e) => FallOfWickets.fromJson(e as Map<String,dynamic>)).toList(),
        partnerships = (json['partnerships'] as List?)?.map((dynamic e) => Partnerships.fromJson(e as Map<String,dynamic>)).toList(),
        maxOversPerDay = (json['maxOversPerDay'] as List?)?.map((dynamic e) => MaxOversPerDay.fromJson(e as Map<String,dynamic>)).toList(),
        yetToBat = (json['yetToBat'] as List?)?.map((dynamic e) => YetToBat.fromJson(e as Map<String,dynamic>)).toList(),
        totalOvers = json['totalOvers'] as num?,
        powerplays = json['powerplays'] as List?,
        overSummaries = (json['overSummaries'] as List?)?.map((dynamic e) => OverSummaries.fromJson(e as Map<String,dynamic>)).toList(),
        ended = json['ended'] as bool?,
        legalBalls = json['legalBalls'] as num?;

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
    'maxOversPerDay' : maxOversPerDay?.map((e) => e.toJson()).toList(),
    'yetToBat' : yetToBat?.map((e) => e.toJson()).toList(),
    'totalOvers' : totalOvers,
    'powerplays' : powerplays,
    'overSummaries' : overSummaries?.map((e) => e.toJson()).toList(),
    'ended' : ended,
    'legalBalls' : legalBalls
  };
}

class BattingTeam {
  final num? teamId;
  final dynamic teamName;
  final num? runs;
  final num? wickets;
  final num? overs;

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
        overs = json['overs'] as num?;

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

class Batters {
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

  Batters({
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

  Batters.fromJson(Map<String, dynamic> json)
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

class Bowlers {
  final num? playerId;
  final String? playerName;
  final num? overs;
  final num? maidens;
  final num? runsConceded;
  final num? wickets;
  final num? economyRate;

  Bowlers({
    this.playerId,
    this.playerName,
    this.overs,
    this.maidens,
    this.runsConceded,
    this.wickets,
    this.economyRate,
  });

  Bowlers.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'] as num?,
        playerName = json['playerName'] as String?,
        overs = json['overs'] as num?,
        maidens = json['maidens'] as num?,
        runsConceded = json['runsConceded'] as num?,
        wickets = json['wickets'] as num?,
        economyRate = json['economyRate'] as num?;

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

class Extras {
  final num? byes;
  final num? legByes;
  final num? wides;
  final num? noBalls;
  final num? penalty;
  final num? total;

  Extras({
    this.byes,
    this.legByes,
    this.wides,
    this.noBalls,
    this.penalty,
    this.total,
  });

  Extras.fromJson(Map<String, dynamic> json)
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

class FallOfWickets {
  final num? wicketNumber;
  final num? scoreAtFall;
  final num? overAtFall;
  final num? playerId;
  final String? playerName;

  FallOfWickets({
    this.wicketNumber,
    this.scoreAtFall,
    this.overAtFall,
    this.playerId,
    this.playerName,
  });

  FallOfWickets.fromJson(Map<String, dynamic> json)
      : wicketNumber = json['wicketNumber'] as num?,
        scoreAtFall = json['scoreAtFall'] as num?,
        overAtFall = json['overAtFall'] as num?,
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

class Partnerships {
  final num? wicketNumber;
  final Batsman1? batsman1;
  final Batsman2? batsman2;
  final num? totalRuns;
  final num? totalBalls;

  Partnerships({
    this.wicketNumber,
    this.batsman1,
    this.batsman2,
    this.totalRuns,
    this.totalBalls,
  });

  Partnerships.fromJson(Map<String, dynamic> json)
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

class MaxOversPerDay {
  final num? inningNumber;
  final num? day;
  final num? maxOvers;
  final num? sequenceNumber;

  MaxOversPerDay({
    this.inningNumber,
    this.day,
    this.maxOvers,
    this.sequenceNumber,
  });

  MaxOversPerDay.fromJson(Map<String, dynamic> json)
      : inningNumber = json['inningNumber'] as num?,
        day = json['day'] as num?,
        maxOvers = json['maxOvers'] as num?,
        sequenceNumber = json['sequenceNumber'] as num?;

  Map<String, dynamic> toJson() => {
    'inningNumber' : inningNumber,
    'day' : day,
    'maxOvers' : maxOvers,
    'sequenceNumber' : sequenceNumber
  };
}

class YetToBat {
  final num? id;
  final String? name;
  final num? batOrder;
  final String? role;
  final String? battingHandedness;
  final String? bowlingHandedness;
  final String? bowlingStyle;

  YetToBat({
    this.id,
    this.name,
    this.batOrder,
    this.role,
    this.battingHandedness,
    this.bowlingHandedness,
    this.bowlingStyle,
  });

  YetToBat.fromJson(Map<String, dynamic> json)
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
    'bowlingStyle' : bowlingStyle,
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
class OverSummaries {
  final num? overNumber;
  final List<dynamic>? balls;
  final num? totalRuns;

  OverSummaries({
    this.overNumber,
    this.balls,
    this.totalRuns,
  });

  OverSummaries.fromJson(Map<String, dynamic> json)
      : overNumber = json['overNumber'] as num?,
        balls = json['balls'] as List<dynamic>?,
        totalRuns = json['totalRuns'];
  Map<String, dynamic> toJson() => {
    'overNumber' : overNumber,
    'balls' : balls,
    'totalRuns' : totalRuns
  };
}

class Result {
  final String? type;
  final num? winningTeamId;
  final num? sequenceNumber;

  Result({
    this.type,
    this.winningTeamId,
    this.sequenceNumber,
  });

  Result.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        winningTeamId = json['winningTeamId'] as num?,
        sequenceNumber = json['sequenceNumber'] as num?;

  Map<String, dynamic> toJson() => {
    'type' : type,
    'winningTeamId' : winningTeamId,
    'sequenceNumber' : sequenceNumber
  };
}

class TeamLineups {
  final num? teamId;
  final num? sequenceNumber;
  final num? captainId;
  final String? captainName;
  final num? wicketKeeperId;
  final String? wicketKeeperName;
  final List<Lineup>? lineup;

  TeamLineups({
    this.teamId,
    this.sequenceNumber,
    this.captainId,
    this.captainName,
    this.wicketKeeperId,
    this.wicketKeeperName,
    this.lineup,
  });

  TeamLineups.fromJson(Map<String, dynamic> json)
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
  final String? role;
  final String? battingHandedness;
  final String? bowlingHandedness;
  final String? bowlingStyle;
  final num? batOrder;

  Lineup({
    this.id,
    this.name,
    this.role,
    this.battingHandedness,
    this.bowlingHandedness,
    this.bowlingStyle,
    this.batOrder,
  });

  Lineup.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num?,
        name = json['name'] as String?,
        role = json['role'] as String?,
        battingHandedness = json['battingHandedness'] as String?,
        bowlingHandedness = json['bowlingHandedness'] as String?,
        bowlingStyle = json['bowlingStyle'] as String?,
        batOrder = json['batOrder'] as num?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'role' : role,
    'battingHandedness' : battingHandedness,
    'bowlingHandedness' : bowlingHandedness,
    'bowlingStyle' : bowlingStyle,
    'batOrder' : batOrder
  };
}