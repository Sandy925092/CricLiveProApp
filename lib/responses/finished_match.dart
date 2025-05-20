// class FinishedMatchResponse {
//   final bool? success;
//   final String? message;
//    Data? data;
//
//   FinishedMatchResponse({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   FinishedMatchResponse.fromJson(Map<String, dynamic> json)
//       : success = json['success'] as bool?,
//         message = json['message'] as String?,
//         data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
//
//   Map<String, dynamic> toJson() => {
//     'success' : success,
//     'message' : message,
//     'data' : data?.toJson()
//   };
// }
//
// class Data {
//   final List<Content>? content;
//   final Pageable? pageable;
//   final num? totalPages;
//   final num? totalElements;
//   final bool? last;
//   final num? size;
//   final num? number;
//   final Sort? sort;
//   final num? numberOfElements;
//   final bool? first;
//   final bool? empty;
//
//   Data({
//     this.content,
//     this.pageable,
//     this.totalPages,
//     this.totalElements,
//     this.last,
//     this.size,
//     this.number,
//     this.sort,
//     this.numberOfElements,
//     this.first,
//     this.empty,
//   });
//
//   Data.fromJson(Map<String, dynamic> json)
//       : content = (json['content'] as List?)?.map((dynamic e) => Content.fromJson(e as Map<String,dynamic>)).toList(),
//         pageable = (json['pageable'] as Map<String,dynamic>?) != null ? Pageable.fromJson(json['pageable'] as Map<String,dynamic>) : null,
//         totalPages = json['totalPages'] as num?,
//         totalElements = json['totalElements'] as num?,
//         last = json['last'] as bool?,
//         size = json['size'] as num?,
//         number = json['number'] as num?,
//         sort = (json['sort'] as Map<String,dynamic>?) != null ? Sort.fromJson(json['sort'] as Map<String,dynamic>) : null,
//         numberOfElements = json['numberOfElements'] as num?,
//         first = json['first'] as bool?,
//         empty = json['empty'] as bool?;
//
//   Map<String, dynamic> toJson() => {
//     'content' : content?.map((e) => e.toJson()).toList(),
//     'pageable' : pageable?.toJson(),
//     'totalPages' : totalPages,
//     'totalElements' : totalElements,
//     'last' : last,
//     'size' : size,
//     'number' : number,
//     'sort' : sort?.toJson(),
//     'numberOfElements' : numberOfElements,
//     'first' : first,
//     'empty' : empty
//   };
// }
//
// class Content {
//   final num? seriesId;
//   final String? seriesName;
//   final List<Matches>? matches;
//
//   Content({
//     this.seriesId,
//     this.seriesName,
//     this.matches,
//   });
//
//   Content.fromJson(Map<String, dynamic> json)
//       : seriesId = json['seriesId'] as num?,
//         seriesName = json['seriesName'] as String?,
//         matches = (json['matches'] as List?)?.map((dynamic e) => Matches.fromJson(e as Map<String,dynamic>)).toList();
//
//   Map<String, dynamic> toJson() => {
//     'seriesId' : seriesId,
//     'seriesName' : seriesName,
//     'matches' : matches?.map((e) => e.toJson()).toList()
//   };
// }
//
// class Matches {
//   final num? fixtureId;
//   final String? homeTeamName;
//   final String? awayTeamName;
//   final Scorecard? scorecard;
//
//   Matches({
//     this.fixtureId,
//     this.homeTeamName,
//     this.awayTeamName,
//     this.scorecard,
//   });
//
//   Matches.fromJson(Map<String, dynamic> json)
//       : fixtureId = json['fixtureId'] as num?,
//         homeTeamName = json['homeTeamName'] as String?,
//         awayTeamName = json['awayTeamName'] as String?,
//         scorecard = (json['scorecard'] as Map<String,dynamic>?) != null ? Scorecard.fromJson(json['scorecard'] as Map<String,dynamic>) : null;
//
//   Map<String, dynamic> toJson() => {
//     'fixtureId' : fixtureId,
//     'homeTeamName' : homeTeamName,
//     'awayTeamName' : awayTeamName,
//     'scorecard' : scorecard?.toJson()
//   };
// }
//
// class Scorecard {
//   final num? fixtureId;
//   final num? seriesId;
//   final String? seriesName;
//   final String? matchStatus;
//   final num? teamAId;
//   final String? teamAName;
//   final num? teamBId;
//   final String? teamBName;
//   final TossInfo? tossInfo;
//   final List<Innings>? innings;
//   final Result? result;
//   final List<dynamic>? teamLineups;
//   final String? updatedAt;
//
//   Scorecard({
//     this.fixtureId,
//     this.seriesId,
//     this.seriesName,
//     this.matchStatus,
//     this.teamAId,
//     this.teamAName,
//     this.teamBId,
//     this.teamBName,
//     this.tossInfo,
//     this.innings,
//     this.result,
//     this.teamLineups,
//     this.updatedAt,
//   });
//
//   Scorecard.fromJson(Map<String, dynamic> json)
//       : fixtureId = json['fixtureId'] as num?,
//         seriesId = json['seriesId'] as num?,
//         seriesName = json['seriesName'] as String?,
//         matchStatus = json['matchStatus'] as String?,
//         teamAId = json['teamAId'] as num?,
//         teamAName = json['teamAName'] as String?,
//         teamBId = json['teamBId'] as num?,
//         teamBName = json['teamBName'] as String?,
//         tossInfo = (json['tossInfo'] as Map<String,dynamic>?) != null ? TossInfo.fromJson(json['tossInfo'] as Map<String,dynamic>) : null,
//         innings = (json['innings'] as List?)?.map((dynamic e) => Innings.fromJson(e as Map<String,dynamic>)).toList(),
//         result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null,
//         teamLineups = json['teamLineups'] as List?,
//         updatedAt = json['updatedAt'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'fixtureId' : fixtureId,
//     'seriesId' : seriesId,
//     'seriesName' : seriesName,
//     'matchStatus' : matchStatus,
//     'teamAId' : teamAId,
//     'teamAName' : teamAName,
//     'teamBId' : teamBId,
//     'teamBName' : teamBName,
//     'tossInfo' : tossInfo?.toJson(),
//     'innings' : innings?.map((e) => e.toJson()).toList(),
//     'result' : result?.toJson(),
//     'teamLineups' : teamLineups,
//     'updatedAt' : updatedAt
//   };
// }
//
// class TossInfo {
//   final num? tossWinnerTeamId;
//   final String? decision;
//   final num? sequenceNumber;
//
//   TossInfo({
//     this.tossWinnerTeamId,
//     this.decision,
//     this.sequenceNumber,
//   });
//
//   TossInfo.fromJson(Map<String, dynamic> json)
//       : tossWinnerTeamId = json['tossWinnerTeamId'] as num?,
//         decision = json['decision'] as String?,
//         sequenceNumber = json['sequenceNumber'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'tossWinnerTeamId' : tossWinnerTeamId,
//     'decision' : decision,
//     'sequenceNumber' : sequenceNumber
//   };
// }
//
// class Innings {
//   final num? inningNumber;
//   final BattingTeam? battingTeam;
//   final BowlingTeam? bowlingTeam;
//   final List<Batters>? batters;
//   final List<Bowlers>? bowlers;
//   final Extras? extras;
//   final num? currentRunRate;
//   final dynamic requiredRunRate;
//   final num? target;
//   final List<dynamic>? fallOfWickets;
//   final List<Partnerships>? partnerships;
//   final dynamic maxOversPerDay;
//   final dynamic totalOvers;
//   final List<Powerplays>? powerplays;
//   final List<Interruptions>? interruptions;
//   final bool? ended;
//   final num? legalBalls;
//   final List<dynamic>? yetToBat;
//   final dynamic overSummaries;
//
//   Innings({
//     this.inningNumber,
//     this.battingTeam,
//     this.bowlingTeam,
//     this.batters,
//     this.bowlers,
//     this.extras,
//     this.currentRunRate,
//     this.requiredRunRate,
//     this.target,
//     this.fallOfWickets,
//     this.partnerships,
//     this.maxOversPerDay,
//     this.totalOvers,
//     this.powerplays,
//     this.interruptions,
//     this.ended,
//     this.legalBalls,
//     this.yetToBat,
//     this.overSummaries,
//   });
//
//   Innings.fromJson(Map<String, dynamic> json)
//       : inningNumber = json['inningNumber'] as num?,
//         battingTeam = (json['battingTeam'] as Map<String,dynamic>?) != null ? BattingTeam.fromJson(json['battingTeam'] as Map<String,dynamic>) : null,
//         bowlingTeam = (json['bowlingTeam'] as Map<String,dynamic>?) != null ? BowlingTeam.fromJson(json['bowlingTeam'] as Map<String,dynamic>) : null,
//         batters = (json['batters'] as List?)?.map((dynamic e) => Batters.fromJson(e as Map<String,dynamic>)).toList(),
//         bowlers = (json['bowlers'] as List?)?.map((dynamic e) => Bowlers.fromJson(e as Map<String,dynamic>)).toList(),
//         extras = (json['extras'] as Map<String,dynamic>?) != null ? Extras.fromJson(json['extras'] as Map<String,dynamic>) : null,
//         currentRunRate = json['currentRunRate'] as num?,
//         requiredRunRate = json['requiredRunRate'],
//         target = json['target'] as num?,
//         fallOfWickets = json['fallOfWickets'] as List?,
//         partnerships = (json['partnerships'] as List?)?.map((dynamic e) => Partnerships.fromJson(e as Map<String,dynamic>)).toList(),
//         maxOversPerDay = json['maxOversPerDay'],
//         totalOvers = json['totalOvers'],
//         powerplays = (json['powerplays'] as List?)?.map((dynamic e) => Powerplays.fromJson(e as Map<String,dynamic>)).toList(),
//         interruptions = (json['interruptions'] as List?)?.map((dynamic e) => Interruptions.fromJson(e as Map<String,dynamic>)).toList(),
//         ended = json['ended'] as bool?,
//         legalBalls = json['legalBalls'] as num?,
//         yetToBat = json['yetToBat'] as List?,
//         overSummaries = json['overSummaries'];
//
//   Map<String, dynamic> toJson() => {
//     'inningNumber' : inningNumber,
//     'battingTeam' : battingTeam?.toJson(),
//     'bowlingTeam' : bowlingTeam?.toJson(),
//     'batters' : batters?.map((e) => e.toJson()).toList(),
//     'bowlers' : bowlers?.map((e) => e.toJson()).toList(),
//     'extras' : extras?.toJson(),
//     'currentRunRate' : currentRunRate,
//     'requiredRunRate' : requiredRunRate,
//     'target' : target,
//     'fallOfWickets' : fallOfWickets,
//     'partnerships' : partnerships?.map((e) => e.toJson()).toList(),
//     'maxOversPerDay' : maxOversPerDay,
//     'totalOvers' : totalOvers,
//     'powerplays' : powerplays?.map((e) => e.toJson()).toList(),
//     'interruptions' : interruptions?.map((e) => e.toJson()).toList(),
//     'ended' : ended,
//     'legalBalls' : legalBalls,
//     'yetToBat' : yetToBat,
//     'overSummaries' : overSummaries
//   };
// }
//
// class BattingTeam {
//   final num? teamId;
//   final dynamic teamName;
//   final num? runs;
//   final num? wickets;
//   final num? overs;
//
//   BattingTeam({
//     this.teamId,
//     this.teamName,
//     this.runs,
//     this.wickets,
//     this.overs,
//   });
//
//   BattingTeam.fromJson(Map<String, dynamic> json)
//       : teamId = json['teamId'] as num?,
//         teamName = json['teamName'],
//         runs = json['runs'] as num?,
//         wickets = json['wickets'] as num?,
//         overs = json['overs'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'teamId' : teamId,
//     'teamName' : teamName,
//     'runs' : runs,
//     'wickets' : wickets,
//     'overs' : overs
//   };
// }
//
// class BowlingTeam {
//   final num? teamId;
//   final dynamic teamName;
//   final num? runs;
//   final num? wickets;
//   final num? overs;
//
//   BowlingTeam({
//     this.teamId,
//     this.teamName,
//     this.runs,
//     this.wickets,
//     this.overs,
//   });
//
//   BowlingTeam.fromJson(Map<String, dynamic> json)
//       : teamId = json['teamId'] as num?,
//         teamName = json['teamName'],
//         runs = json['runs'] as num?,
//         wickets = json['wickets'] as num?,
//         overs = json['overs'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'teamId' : teamId,
//     'teamName' : teamName,
//     'runs' : runs,
//     'wickets' : wickets,
//     'overs' : overs
//   };
// }
//
// class Batters {
//   final num? playerId;
//   final String? playerName;
//   final num? runs;
//   final num? balls;
//   final num? fours;
//   final num? sixes;
//   final num? strikeRate;
//   final String? playerStatus;
//   final String? dismissal;
//   final bool? isOut;
//
//   Batters({
//     this.playerId,
//     this.playerName,
//     this.runs,
//     this.balls,
//     this.fours,
//     this.sixes,
//     this.strikeRate,
//     this.playerStatus,
//     this.dismissal,
//     this.isOut,
//   });
//
//   Batters.fromJson(Map<String, dynamic> json)
//       : playerId = json['playerId'] as num?,
//         playerName = json['playerName'] as String?,
//         runs = json['runs'] as num?,
//         balls = json['balls'] as num?,
//         fours = json['fours'] as num?,
//         sixes = json['sixes'] as num?,
//         strikeRate = json['strikeRate'] as num?,
//         playerStatus = json['playerStatus'] as String?,
//         dismissal = json['dismissal'] as String?,
//         isOut = json['isOut'] as bool?;
//
//   Map<String, dynamic> toJson() => {
//     'playerId' : playerId,
//     'playerName' : playerName,
//     'runs' : runs,
//     'balls' : balls,
//     'fours' : fours,
//     'sixes' : sixes,
//     'strikeRate' : strikeRate,
//     'playerStatus' : playerStatus,
//     'dismissal' : dismissal,
//     'isOut' : isOut
//   };
// }
//
// class Bowlers {
//   final num? playerId;
//   final String? playerName;
//   final num? overs;
//   final num? maidens;
//   final num? runsConceded;
//   final num? wickets;
//   final num? economyRate;
//
//   Bowlers({
//     this.playerId,
//     this.playerName,
//     this.overs,
//     this.maidens,
//     this.runsConceded,
//     this.wickets,
//     this.economyRate,
//   });
//
//   Bowlers.fromJson(Map<String, dynamic> json)
//       : playerId = json['playerId'] as num?,
//         playerName = json['playerName'] as String?,
//         overs = json['overs'] as num?,
//         maidens = json['maidens'] as num?,
//         runsConceded = json['runsConceded'] as num?,
//         wickets = json['wickets'] as num?,
//         economyRate = json['economyRate'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'playerId' : playerId,
//     'playerName' : playerName,
//     'overs' : overs,
//     'maidens' : maidens,
//     'runsConceded' : runsConceded,
//     'wickets' : wickets,
//     'economyRate' : economyRate
//   };
// }
//
// class Extras {
//   final num? byes;
//   final num? legByes;
//   final num? wides;
//   final num? noBalls;
//   final num? penalty;
//   final num? total;
//
//   Extras({
//     this.byes,
//     this.legByes,
//     this.wides,
//     this.noBalls,
//     this.penalty,
//     this.total,
//   });
//
//   Extras.fromJson(Map<String, dynamic> json)
//       : byes = json['byes'] as num?,
//         legByes = json['legByes'] as num?,
//         wides = json['wides'] as num?,
//         noBalls = json['noBalls'] as num?,
//         penalty = json['penalty'] as num?,
//         total = json['total'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'byes' : byes,
//     'legByes' : legByes,
//     'wides' : wides,
//     'noBalls' : noBalls,
//     'penalty' : penalty,
//     'total' : total
//   };
// }
//
// class Partnerships {
//   final num? wicketNumber;
//   final Batsman1? batsman1;
//   final Batsman2? batsman2;
//   final num? totalRuns;
//   final num? totalBalls;
//
//   Partnerships({
//     this.wicketNumber,
//     this.batsman1,
//     this.batsman2,
//     this.totalRuns,
//     this.totalBalls,
//   });
//
//   Partnerships.fromJson(Map<String, dynamic> json)
//       : wicketNumber = json['wicketNumber'] as num?,
//         batsman1 = (json['batsman1'] as Map<String,dynamic>?) != null ? Batsman1.fromJson(json['batsman1'] as Map<String,dynamic>) : null,
//         batsman2 = (json['batsman2'] as Map<String,dynamic>?) != null ? Batsman2.fromJson(json['batsman2'] as Map<String,dynamic>) : null,
//         totalRuns = json['totalRuns'] as num?,
//         totalBalls = json['totalBalls'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'wicketNumber' : wicketNumber,
//     'batsman1' : batsman1?.toJson(),
//     'batsman2' : batsman2?.toJson(),
//     'totalRuns' : totalRuns,
//     'totalBalls' : totalBalls
//   };
// }
//
// class Batsman1 {
//   final num? playerId;
//   final String? playerName;
//   final num? runs;
//   final num? balls;
//
//   Batsman1({
//     this.playerId,
//     this.playerName,
//     this.runs,
//     this.balls,
//   });
//
//   Batsman1.fromJson(Map<String, dynamic> json)
//       : playerId = json['playerId'] as num?,
//         playerName = json['playerName'] as String?,
//         runs = json['runs'] as num?,
//         balls = json['balls'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'playerId' : playerId,
//     'playerName' : playerName,
//     'runs' : runs,
//     'balls' : balls
//   };
// }
//
// class Batsman2 {
//   final num? playerId;
//   final String? playerName;
//   final num? runs;
//   final num? balls;
//
//   Batsman2({
//     this.playerId,
//     this.playerName,
//     this.runs,
//     this.balls,
//   });
//
//   Batsman2.fromJson(Map<String, dynamic> json)
//       : playerId = json['playerId'] as num?,
//         playerName = json['playerName'] as String?,
//         runs = json['runs'] as num?,
//         balls = json['balls'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'playerId' : playerId,
//     'playerName' : playerName,
//     'runs' : runs,
//     'balls' : balls
//   };
// }
//
// class Powerplays {
//   final num? inningNumber;
//   final num? firstOver;
//   final num? lastOver;
//   final String? type;
//   final num? sequenceNumber;
//
//   Powerplays({
//     this.inningNumber,
//     this.firstOver,
//     this.lastOver,
//     this.type,
//     this.sequenceNumber,
//   });
//
//   Powerplays.fromJson(Map<String, dynamic> json)
//       : inningNumber = json['inningNumber'] as num?,
//         firstOver = json['firstOver'] as num?,
//         lastOver = json['lastOver'] as num?,
//         type = json['type'] as String?,
//         sequenceNumber = json['sequenceNumber'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'inningNumber' : inningNumber,
//     'firstOver' : firstOver,
//     'lastOver' : lastOver,
//     'type' : type,
//     'sequenceNumber' : sequenceNumber
//   };
// }
//
// class Interruptions {
//   final num? inningNumber;
//   final dynamic deliveryId;
//   final dynamic reason;
//   final num? sequenceNumber;
//   final String? timestamp;
//
//   Interruptions({
//     this.inningNumber,
//     this.deliveryId,
//     this.reason,
//     this.sequenceNumber,
//     this.timestamp,
//   });
//
//   Interruptions.fromJson(Map<String, dynamic> json)
//       : inningNumber = json['inningNumber'] as num?,
//         deliveryId = json['deliveryId'],
//         reason = json['reason'],
//         sequenceNumber = json['sequenceNumber'] as num?,
//         timestamp = json['timestamp'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'inningNumber' : inningNumber,
//     'deliveryId' : deliveryId,
//     'reason' : reason,
//     'sequenceNumber' : sequenceNumber,
//     'timestamp' : timestamp
//   };
// }
//
// class Result {
//   final String? type;
//   final num? winningTeamId;
//   final num? sequenceNumber;
//
//   Result({
//     this.type,
//     this.winningTeamId,
//     this.sequenceNumber,
//   });
//
//   Result.fromJson(Map<String, dynamic> json)
//       : type = json['type'] as String?,
//         winningTeamId = json['winningTeamId'] as num?,
//         sequenceNumber = json['sequenceNumber'] as num?;
//
//   Map<String, dynamic> toJson() => {
//     'type' : type,
//     'winningTeamId' : winningTeamId,
//     'sequenceNumber' : sequenceNumber
//   };
// }
//
// class Pageable {
//   final num? pageNumber;
//   final num? pageSize;
//   final Sort2? sort;
//   final num? offset;
//   final bool? paged;
//   final bool? unpaged;
//
//   Pageable({
//     this.pageNumber,
//     this.pageSize,
//     this.sort,
//     this.offset,
//     this.paged,
//     this.unpaged,
//   });
//
//   Pageable.fromJson(Map<String, dynamic> json)
//       : pageNumber = json['pageNumber'] as num?,
//         pageSize = json['pageSize'] as num?,
//         sort = (json['sort'] as Map<String,dynamic>?) != null ? Sort2.fromJson(json['sort'] as Map<String,dynamic>) : null,
//         offset = json['offset'] as num?,
//         paged = json['paged'] as bool?,
//         unpaged = json['unpaged'] as bool?;
//
//   Map<String, dynamic> toJson() => {
//     'pageNumber' : pageNumber,
//     'pageSize' : pageSize,
//     'sort' : sort?.toJson(),
//     'offset' : offset,
//     'paged' : paged,
//     'unpaged' : unpaged
//   };
// }
//
// class Sort {
//   final bool? sorted;
//   final bool? empty;
//   final bool? unsorted;
//
//   Sort({
//     this.sorted,
//     this.empty,
//     this.unsorted,
//   });
//
//   Sort.fromJson(Map<String, dynamic> json)
//       : sorted = json['sorted'] as bool?,
//         empty = json['empty'] as bool?,
//         unsorted = json['unsorted'] as bool?;
//
//   Map<String, dynamic> toJson() => {
//     'sorted' : sorted,
//     'empty' : empty,
//     'unsorted' : unsorted
//   };
// }
//
// class Sort2 {
//   final bool? sorted;
//   final bool? empty;
//   final bool? unsorted;
//
//   Sort2({
//     this.sorted,
//     this.empty,
//     this.unsorted,
//   });
//
//   Sort2.fromJson(Map<String, dynamic> json)
//       : sorted = json['sorted'] as bool?,
//         empty = json['empty'] as bool?,
//         unsorted = json['unsorted'] as bool?;
//
//   Map<String, dynamic> toJson() => {
//     'sorted' : sorted,
//     'empty' : empty,
//     'unsorted' : unsorted
//   };
// }



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
  final int? fixtureId;
  final String? homeTeam;
  final String? awayTeam;
  final dynamic homeTeamRuns;
  final dynamic homeTeamWickets;
  final dynamic awayTeamRuns;
  final dynamic awayTeamWickets;
  final dynamic winningTeamName;
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
      : fixtureId = json['fixtureId'] as int?,
        homeTeam = json['homeTeam'] as String?,
        awayTeam = json['awayTeam'] as String?,
        homeTeamRuns = json['homeTeamRuns'],
        homeTeamWickets = json['homeTeamWickets'],
        awayTeamRuns = json['awayTeamRuns'],
        awayTeamWickets = json['awayTeamWickets'],
        winningTeamName = json['winningTeamName'],
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