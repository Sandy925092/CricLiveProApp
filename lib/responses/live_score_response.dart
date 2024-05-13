class LiveScoreResponse {
  final bool? success;
  final String? message;
  final Data? data;

  LiveScoreResponse({
    this.success,
    this.message,
    this.data,
  });

  LiveScoreResponse.fromJson(Map<String, dynamic> json)
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
  final String? messageId;
  final String? timeStamp;
  final dynamic csdId;
  final dynamic bfId;
  final dynamic cricInfoId;
  final bool? preDelivery;
  final String? status;
  final TossWinner? tossWinner;
  final HomeTeam? homeTeam;
  final AwayTeam? awayTeam;
  final CurrentBall? currentBall;
  final CurrentOver? currentOver;
  final LastOver? lastOver;
  final List<BBB>? bBB;
  final List<Batsmen>? batsmen;
  final Bowler? bowler;
  final LastBatsmanOut? lastBatsmanOut;
  final dynamic remainingBalls;
  final dynamic currentInning;
  final dynamic oversPerInning;
  final dynamic result;

  Data({
    this.messageId,
    this.timeStamp,
    this.csdId,
    this.bfId,
    this.cricInfoId,
    this.preDelivery,
    this.status,
    this.tossWinner,
    this.homeTeam,
    this.awayTeam,
    this.currentBall,
    this.currentOver,
    this.lastOver,
    this.bBB,
    this.batsmen,
    this.bowler,
    this.lastBatsmanOut,
    this.remainingBalls,
    this.currentInning,
    this.oversPerInning,
    this.result,
  });

  Data.fromJson(Map<String, dynamic> json)
      : messageId = json['MessageId'] as String?,
        timeStamp = json['TimeStamp'] as String?,
        csdId = json['CsdId'] as dynamic,
        bfId = json['BfId'] as dynamic,
        cricInfoId = json['CricInfoId'] as dynamic,
        preDelivery = json['PreDelivery'] as bool?,
        status = json['Status'] as String?,
        tossWinner = (json['TossWinner'] as Map<String,dynamic>?) != null ? TossWinner.fromJson(json['TossWinner'] as Map<String,dynamic>) : null,
        homeTeam = (json['HomeTeam'] as Map<String,dynamic>?) != null ? HomeTeam.fromJson(json['HomeTeam'] as Map<String,dynamic>) : null,
        awayTeam = (json['AwayTeam'] as Map<String,dynamic>?) != null ? AwayTeam.fromJson(json['AwayTeam'] as Map<String,dynamic>) : null,
        currentBall = (json['CurrentBall'] as Map<String,dynamic>?) != null ? CurrentBall.fromJson(json['CurrentBall'] as Map<String,dynamic>) : null,
        currentOver = (json['CurrentOver'] as Map<String,dynamic>?) != null ? CurrentOver.fromJson(json['CurrentOver'] as Map<String,dynamic>) : null,
        lastOver = (json['LastOver'] as Map<String,dynamic>?) != null ? LastOver.fromJson(json['LastOver'] as Map<String,dynamic>) : null,
        bBB = (json['BBB'] as List?)?.map((dynamic e) => BBB.fromJson(e as Map<String,dynamic>)).toList(),
        batsmen = (json['Batsmen'] as List?)?.map((dynamic e) => Batsmen.fromJson(e as Map<String,dynamic>)).toList(),
        bowler = (json['Bowler'] as Map<String,dynamic>?) != null ? Bowler.fromJson(json['Bowler'] as Map<String,dynamic>) : null,
        lastBatsmanOut = (json['LastBatsmanOut'] as Map<String,dynamic>?) != null ? LastBatsmanOut.fromJson(json['LastBatsmanOut'] as Map<String,dynamic>) : null,
        remainingBalls = json['RemainingBalls'] as dynamic,
        currentInning = json['CurrentInning'] as dynamic,
        oversPerInning = json['OversPerInning'] as dynamic,
        result = json['Result'];

  Map<String, dynamic> toJson() => {
    'MessageId' : messageId,
    'TimeStamp' : timeStamp,
    'CsdId' : csdId,
    'BfId' : bfId,
    'CricInfoId' : cricInfoId,
    'PreDelivery' : preDelivery,
    'Status' : status,
    'TossWinner' : tossWinner?.toJson(),
    'HomeTeam' : homeTeam?.toJson(),
    'AwayTeam' : awayTeam?.toJson(),
    'CurrentBall' : currentBall?.toJson(),
    'CurrentOver' : currentOver?.toJson(),
    'LastOver' : lastOver?.toJson(),
    'BBB' : bBB?.map((e) => e.toJson()).toList(),
    'Batsmen' : batsmen?.map((e) => e.toJson()).toList(),
    'Bowler' : bowler?.toJson(),
    'LastBatsmanOut' : lastBatsmanOut?.toJson(),
    'RemainingBalls' : remainingBalls,
    'CurrentInning' : currentInning,
    'OversPerInning' : oversPerInning,
    'Result' : result
  };
}

class TossWinner {
  final dynamic csdId;
  final String? decision;

  TossWinner({
    this.csdId,
    this.decision,
  });

  TossWinner.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        decision = json['Decision'] as String?;

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'Decision' : decision
  };
}

class HomeTeam {
  final dynamic csdId;
  final String? name;
  final List<Players>? players;
  final bool? isBattingTeam;
  final dynamic score;
  final dynamic wickets;
  final dynamic runRate;
  final dynamic partnershipScore;
  final dynamic partnershipBalls;
  final dynamic requiredRunRate;
  final dynamic target;
  final bool? adjusted;
  final dynamic overs;
  final dynamic balls;
  final dynamic requiredRuns;
  final dynamic projectedScore;
  final bool? declared;
  final List<FOW>? fOW;
  final dynamic legByes;
  final dynamic byes;
  final dynamic noBalls;
  final dynamic wides;

  HomeTeam({
    this.csdId,
    this.name,
    this.players,
    this.isBattingTeam,
    this.score,
    this.wickets,
    this.runRate,
    this.partnershipScore,
    this.partnershipBalls,
    this.requiredRunRate,
    this.target,
    this.adjusted,
    this.overs,
    this.balls,
    this.requiredRuns,
    this.projectedScore,
    this.declared,
    this.fOW,
    this.legByes,
    this.byes,
    this.noBalls,
    this.wides,
  });

  HomeTeam.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        name = json['Name'] as String?,
        players = (json['Players'] as List?)?.map((dynamic e) => Players.fromJson(e as Map<String,dynamic>)).toList(),
        isBattingTeam = json['IsBattingTeam'] as bool?,
        score = json['Score'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        runRate = json['RunRate'] as dynamic,
        partnershipScore = json['PartnershipScore'] as dynamic,
        partnershipBalls = json['PartnershipBalls'] as dynamic,
        requiredRunRate = json['RequiredRunRate'],
        target = json['Target'],
        adjusted = json['Adjusted'] as bool?,
        overs = json['Overs'] as dynamic,
        balls = json['Balls'] as dynamic,
        requiredRuns = json['RequiredRuns'],
        projectedScore = json['ProjectedScore'] as dynamic,
        declared = json['Declared'] as bool?,
        fOW = (json['FOW'] as List?)?.map((dynamic e) => FOW.fromJson(e as Map<String,dynamic>)).toList(),
        legByes = json['LegByes'] as dynamic,
        byes = json['Byes'] as dynamic,
        noBalls = json['NoBalls'] as dynamic,
        wides = json['Wides'] as dynamic;

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'Name' : name,
    'Players' : players?.map((e) => e.toJson()).toList(),
    'IsBattingTeam' : isBattingTeam,
    'Score' : score,
    'Wickets' : wickets,
    'RunRate' : runRate,
    'PartnershipScore' : partnershipScore,
    'PartnershipBalls' : partnershipBalls,
    'RequiredRunRate' : requiredRunRate,
    'Target' : target,
    'Adjusted' : adjusted,
    'Overs' : overs,
    'Balls' : balls,
    'RequiredRuns' : requiredRuns,
    'ProjectedScore' : projectedScore,
    'Declared' : declared,
    'FOW' : fOW?.map((e) => e.toJson()).toList(),
    'LegByes' : legByes,
    'Byes' : byes,
    'NoBalls' : noBalls,
    'Wides' : wides
  };
}

class Players {
  final dynamic csdId;
  final String? fullName;
  final String? nickName;
  final String? firstName;
  final String? lastName;
  final String? shortName;
  final bool? isOnStrike;
  final dynamic batsmanRuns;
  final dynamic balls;
  final dynamic fours;
  final dynamic sixes;
  final dynamic strikeRate;
  final dynamic overs;
  final dynamic maidens;
  final dynamic wickets;
  final dynamic bowlerRuns;
  final dynamic economy;
  final bool? isCap;
  final bool? isWK;
  final dynamic expBatOrder;
  final dynamic actBatOrder;
  final dynamic bowlOrder;
  final dynamic foursConc;
  final dynamic sixesConc;
  final dynamic dotBalls;
  final dynamic widesConc;
  final dynamic noBalls;
  final dynamic howOut;
  final dynamic bowled;
  final dynamic caught;

  Players({
    this.csdId,
    this.fullName,
    this.nickName,
    this.firstName,
    this.lastName,
    this.shortName,
    this.isOnStrike,
    this.batsmanRuns,
    this.balls,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.overs,
    this.maidens,
    this.wickets,
    this.bowlerRuns,
    this.economy,
    this.isCap,
    this.isWK,
    this.expBatOrder,
    this.actBatOrder,
    this.bowlOrder,
    this.foursConc,
    this.sixesConc,
    this.dotBalls,
    this.widesConc,
    this.noBalls,
    this.howOut,
    this.bowled,
    this.caught,
  });

  Players.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        fullName = json['FullName'] as String?,
        nickName = json['NickName'] as String?,
        firstName = json['FirstName'] as String?,
        lastName = json['LastName'] as String?,
        shortName = json['ShortName'] as String?,
        isOnStrike = json['IsOnStrike'] as bool?,
        batsmanRuns = json['BatsmanRuns'] as dynamic,
        balls = json['Balls'] as dynamic,
        fours = json['Fours'] as dynamic,
        sixes = json['Sixes'] as dynamic,
        strikeRate = json['StrikeRate'],
        overs = json['Overs'] as dynamic,
        maidens = json['Maidens'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        bowlerRuns = json['BowlerRuns'] as dynamic,
        economy = json['Economy'],
        isCap = json['IsCap'] as bool?,
        isWK = json['IsWK'] as bool?,
        expBatOrder = json['ExpBatOrder'] as dynamic,
        actBatOrder = json['ActBatOrder'] as dynamic,
        bowlOrder = json['BowlOrder'] as dynamic,
        foursConc = json['FoursConc'] as dynamic,
        sixesConc = json['SixesConc'] as dynamic,
        dotBalls = json['DotBalls'] as dynamic,
        widesConc = json['WidesConc'] as dynamic,
        noBalls = json['NoBalls'] as dynamic,
        howOut = json['HowOut'],
        bowled = json['Bowled'],
        caught = json['Caught'];

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'FullName' : fullName,
    'NickName' : nickName,
    'FirstName' : firstName,
    'LastName' : lastName,
    'ShortName' : shortName,
    'IsOnStrike' : isOnStrike,
    'BatsmanRuns' : batsmanRuns,
    'Balls' : balls,
    'Fours' : fours,
    'Sixes' : sixes,
    'StrikeRate' : strikeRate,
    'Overs' : overs,
    'Maidens' : maidens,
    'Wickets' : wickets,
    'BowlerRuns' : bowlerRuns,
    'Economy' : economy,
    'IsCap' : isCap,
    'IsWK' : isWK,
    'ExpBatOrder' : expBatOrder,
    'ActBatOrder' : actBatOrder,
    'BowlOrder' : bowlOrder,
    'FoursConc' : foursConc,
    'SixesConc' : sixesConc,
    'DotBalls' : dotBalls,
    'WidesConc' : widesConc,
    'NoBalls' : noBalls,
    'HowOut' : howOut,
    'Bowled' : bowled,
    'Caught' : caught
  };
}

class FOW {
  final dynamic wkt;
  final dynamic runs;
  final String? overs;
  final dynamic bat;

  FOW({
    this.wkt,
    this.runs,
    this.overs,
    this.bat,
  });

  FOW.fromJson(Map<String, dynamic> json)
      : wkt = json['Wkt'] as dynamic,
        runs = json['Runs'] as dynamic,
        overs = json['Overs'] as String?,
        bat = json['Bat'] as dynamic;

  Map<String, dynamic> toJson() => {
    'Wkt' : wkt,
    'Runs' : runs,
    'Overs' : overs,
    'Bat' : bat
  };
}

class AwayTeam {
  final dynamic csdId;
  final String? name;
  final List<Players>? players;
  final bool? isBattingTeam;
  final dynamic score;
  final dynamic wickets;
  final dynamic runRate;
  final dynamic partnershipScore;
  final dynamic partnershipBalls;
  final dynamic requiredRunRate;
  final dynamic target;
  final bool? adjusted;
  final dynamic overs;
  final dynamic balls;
  final dynamic requiredRuns;
  final dynamic projectedScore;
  final bool? declared;
  final List<dynamic>? fOW;
  final dynamic legByes;
  final dynamic byes;
  final dynamic noBalls;
  final dynamic wides;

  AwayTeam({
    this.csdId,
    this.name,
    this.players,
    this.isBattingTeam,
    this.score,
    this.wickets,
    this.runRate,
    this.partnershipScore,
    this.partnershipBalls,
    this.requiredRunRate,
    this.target,
    this.adjusted,
    this.overs,
    this.balls,
    this.requiredRuns,
    this.projectedScore,
    this.declared,
    this.fOW,
    this.legByes,
    this.byes,
    this.noBalls,
    this.wides,
  });

  AwayTeam.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        name = json['Name'] as String?,
        players = (json['Players'] as List?)?.map((dynamic e) => Players.fromJson(e as Map<String,dynamic>)).toList(),
        isBattingTeam = json['IsBattingTeam'] as bool?,
        score = json['Score'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        runRate = json['RunRate'] as dynamic,
        partnershipScore = json['PartnershipScore'] as dynamic,
        partnershipBalls = json['PartnershipBalls'] as dynamic,
        requiredRunRate = json['RequiredRunRate'],
        target = json['Target'] as dynamic,
        adjusted = json['Adjusted'] as bool?,
        overs = json['Overs'] as dynamic,
        balls = json['Balls'] as dynamic,
        requiredRuns = json['RequiredRuns'],
        projectedScore = json['ProjectedScore'],
        declared = json['Declared'] as bool?,
        fOW = json['FOW'] as List?,
        legByes = json['LegByes'] as dynamic,
        byes = json['Byes'] as dynamic,
        noBalls = json['NoBalls'] as dynamic,
        wides = json['Wides'] as dynamic;

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'Name' : name,
    'Players' : players?.map((e) => e.toJson()).toList(),
    'IsBattingTeam' : isBattingTeam,
    'Score' : score,
    'Wickets' : wickets,
    'RunRate' : runRate,
    'PartnershipScore' : partnershipScore,
    'PartnershipBalls' : partnershipBalls,
    'RequiredRunRate' : requiredRunRate,
    'Target' : target,
    'Adjusted' : adjusted,
    'Overs' : overs,
    'Balls' : balls,
    'RequiredRuns' : requiredRuns,
    'ProjectedScore' : projectedScore,
    'Declared' : declared,
    'FOW' : fOW,
    'LegByes' : legByes,
    'Byes' : byes,
    'NoBalls' : noBalls,
    'Wides' : wides
  };
}


class CurrentBall {
  final dynamic innings;
  final dynamic over;
  final dynamic ballNumber;
  final dynamic noBallNumber;
  final Runs? runs;
  final dynamic wicket;
  final bool? isWicket;
  final bool? review;
  final bool? isFreeHit;

  CurrentBall({
    this.innings,
    this.over,
    this.ballNumber,
    this.noBallNumber,
    this.runs,
    this.wicket,
    this.isWicket,
    this.review,
    this.isFreeHit,
  });

  CurrentBall.fromJson(Map<String, dynamic> json)
      : innings = json['Innings'] as dynamic,
        over = json['Over'] as dynamic,
        ballNumber = json['BallNumber'] as dynamic,
        noBallNumber = json['NoBallNumber'] as dynamic,
        runs = (json['Runs'] as Map<String,dynamic>?) != null ? Runs.fromJson(json['Runs'] as Map<String,dynamic>) : null,
        wicket = json['Wicket'],
        isWicket = json['IsWicket'] as bool?,
        review = json['Review'] as bool?,
        isFreeHit = json['IsFreeHit'] as bool?;

  Map<String, dynamic> toJson() => {
    'Innings' : innings,
    'Over' : over,
    'BallNumber' : ballNumber,
    'NoBallNumber' : noBallNumber,
    'Runs' : runs?.toJson(),
    'Wicket' : wicket,
    'IsWicket' : isWicket,
    'Review' : review,
    'IsFreeHit' : isFreeHit
  };
}

class Runs {
  final dynamic inField;
  final dynamic boundary;
  final dynamic noBall;
  final dynamic wide;
  final dynamic bye;
  final dynamic legBye;
  final dynamic penalty;

  Runs({
    this.inField,
    this.boundary,
    this.noBall,
    this.wide,
    this.bye,
    this.legBye,
    this.penalty,
  });

  Runs.fromJson(Map<String, dynamic> json)
      : inField = json['InField'] as dynamic,
        boundary = json['Boundary'] as dynamic,
        noBall = json['NoBall'] as dynamic,
        wide = json['Wide'] as dynamic,
        bye = json['Bye'] as dynamic,
        legBye = json['LegBye'] as dynamic,
        penalty = json['Penalty'] as dynamic;

  Map<String, dynamic> toJson() => {
    'InField' : inField,
    'Boundary' : boundary,
    'NoBall' : noBall,
    'Wide' : wide,
    'Bye' : bye,
    'LegBye' : legBye,
    'Penalty' : penalty
  };
}

class CurrentOver {
  final dynamic overNumber;
  final dynamic score;
  final dynamic wickets;
  final dynamic runs;
  final String? bowlerName;
  final List<String>? batsmenNames;
  final List<BallByBall>? ballByBall;
  final dynamic innings;

  CurrentOver({
    this.overNumber,
    this.score,
    this.wickets,
    this.runs,
    this.bowlerName,
    this.batsmenNames,
    this.ballByBall,
    this.innings,
  });

  CurrentOver.fromJson(Map<String, dynamic> json)
      : overNumber = json['OverNumber'] as dynamic,
        score = json['Score'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        runs = json['Runs'] as dynamic,
        bowlerName = json['BowlerName'] as String?,
        batsmenNames = (json['BatsmenNames'] as List?)?.map((dynamic e) => e as String).toList(),
        ballByBall = (json['BallByBall'] as List?)?.map((dynamic e) => BallByBall.fromJson(e as Map<String,dynamic>)).toList(),
        innings = json['Innings'] as dynamic;

  Map<String, dynamic> toJson() => {
    'OverNumber' : overNumber,
    'Score' : score,
    'Wickets' : wickets,
    'Runs' : runs,
    'BowlerName' : bowlerName,
    'BatsmenNames' : batsmenNames,
    'BallByBall' : ballByBall?.map((e) => e.toJson()).toList(),
    'Innings' : innings
  };
}

class BallByBall {
  final dynamic innings;
  final dynamic over;
  final dynamic ballNumber;
  final dynamic noBallNumber;
  final Runs? runs;
  final dynamic wicket;
  final bool? isWicket;
  final bool? review;
  final bool? isFreeHit;

  BallByBall({
    this.innings,
    this.over,
    this.ballNumber,
    this.noBallNumber,
    this.runs,
    this.wicket,
    this.isWicket,
    this.review,
    this.isFreeHit,
  });

  BallByBall.fromJson(Map<String, dynamic> json)
      : innings = json['Innings'] as dynamic,
        over = json['Over'] as dynamic,
        ballNumber = json['BallNumber'] as dynamic,
        noBallNumber = json['NoBallNumber'] as dynamic,
        runs = (json['Runs'] as Map<String,dynamic>?) != null ? Runs.fromJson(json['Runs'] as Map<String,dynamic>) : null,
        wicket = json['Wicket'],
        isWicket = json['IsWicket'] as bool?,
        review = json['Review'] as bool?,
        isFreeHit = json['IsFreeHit'] as bool?;

  Map<String, dynamic> toJson() => {
    'Innings' : innings,
    'Over' : over,
    'BallNumber' : ballNumber,
    'NoBallNumber' : noBallNumber,
    'Runs' : runs?.toJson(),
    'Wicket' : wicket,
    'IsWicket' : isWicket,
    'Review' : review,
    'IsFreeHit' : isFreeHit
  };
}



class LastOver {
  final dynamic overNumber;
  final dynamic score;
  final dynamic wickets;
  final dynamic runs;
  final String? bowlerName;
  final List<String>? batsmenNames;
  final List<BallByBall>? ballByBall;
  final dynamic innings;

  LastOver({
    this.overNumber,
    this.score,
    this.wickets,
    this.runs,
    this.bowlerName,
    this.batsmenNames,
    this.ballByBall,
    this.innings,
  });

  LastOver.fromJson(Map<String, dynamic> json)
      : overNumber = json['OverNumber'] as dynamic,
        score = json['Score'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        runs = json['Runs'] as dynamic,
        bowlerName = json['BowlerName'] as String?,
        batsmenNames = (json['BatsmenNames'] as List?)?.map((dynamic e) => e as String).toList(),
        ballByBall = (json['BallByBall'] as List?)?.map((dynamic e) => BallByBall.fromJson(e as Map<String,dynamic>)).toList(),
        innings = json['Innings'] as dynamic;

  Map<String, dynamic> toJson() => {
    'OverNumber' : overNumber,
    'Score' : score,
    'Wickets' : wickets,
    'Runs' : runs,
    'BowlerName' : bowlerName,
    'BatsmenNames' : batsmenNames,
    'BallByBall' : ballByBall?.map((e) => e.toJson()).toList(),
    'Innings' : innings
  };
}



class BBB {
  final dynamic overNumber;
  final dynamic score;
  final dynamic wickets;
  final dynamic runs;
  final String? bowlerName;
  final List<String>? batsmenNames;
  final List<BallByBall>? ballByBall;
  final dynamic innings;

  BBB({
    this.overNumber,
    this.score,
    this.wickets,
    this.runs,
    this.bowlerName,
    this.batsmenNames,
    this.ballByBall,
    this.innings,
  });

  BBB.fromJson(Map<String, dynamic> json)
      : overNumber = json['OverNumber'] as dynamic,
        score = json['Score'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        runs = json['Runs'] as dynamic,
        bowlerName = json['BowlerName'] as String?,
        batsmenNames = (json['BatsmenNames'] as List?)?.map((dynamic e) => e as String).toList(),
        ballByBall = (json['BallByBall'] as List?)?.map((dynamic e) => BallByBall.fromJson(e as Map<String,dynamic>)).toList(),
        innings = json['Innings'] as dynamic;

  Map<String, dynamic> toJson() => {
    'OverNumber' : overNumber,
    'Score' : score,
    'Wickets' : wickets,
    'Runs' : runs,
    'BowlerName' : bowlerName,
    'BatsmenNames' : batsmenNames,
    'BallByBall' : ballByBall?.map((e) => e.toJson()).toList(),
    'Innings' : innings
  };
}


class Batsmen {
  final dynamic csdId;
  final String? fullName;
  final String? nickName;
  final String? firstName;
  final String? lastName;
  final String? shortName;
  final bool? isOnStrike;
  final dynamic batsmanRuns;
  final dynamic balls;
  final dynamic fours;
  final dynamic sixes;
  final dynamic strikeRate;
  final dynamic overs;
  final dynamic maidens;
  final dynamic wickets;
  final dynamic bowlerRuns;
  final dynamic economy;
  final bool? isCap;
  final bool? isWK;
  final dynamic expBatOrder;
  final dynamic actBatOrder;
  final dynamic bowlOrder;
  final dynamic foursConc;
  final dynamic sixesConc;
  final dynamic dotBalls;
  final dynamic widesConc;
  final dynamic noBalls;
  final dynamic howOut;
  final dynamic bowled;
  final dynamic caught;

  Batsmen({
    this.csdId,
    this.fullName,
    this.nickName,
    this.firstName,
    this.lastName,
    this.shortName,
    this.isOnStrike,
    this.batsmanRuns,
    this.balls,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.overs,
    this.maidens,
    this.wickets,
    this.bowlerRuns,
    this.economy,
    this.isCap,
    this.isWK,
    this.expBatOrder,
    this.actBatOrder,
    this.bowlOrder,
    this.foursConc,
    this.sixesConc,
    this.dotBalls,
    this.widesConc,
    this.noBalls,
    this.howOut,
    this.bowled,
    this.caught,
  });

  Batsmen.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        fullName = json['FullName'] as String?,
        nickName = json['NickName'] as String?,
        firstName = json['FirstName'] as String?,
        lastName = json['LastName'] as String?,
        shortName = json['ShortName'] as String?,
        isOnStrike = json['IsOnStrike'] as bool?,
        batsmanRuns = json['BatsmanRuns'] as dynamic,
        balls = json['Balls'] as dynamic,
        fours = json['Fours'] as dynamic,
        sixes = json['Sixes'] as dynamic,
        strikeRate = json['StrikeRate'] as dynamic,
        overs = json['Overs'] as dynamic,
        maidens = json['Maidens'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        bowlerRuns = json['BowlerRuns'] as dynamic,
        economy = json['Economy'],
        isCap = json['IsCap'] as bool?,
        isWK = json['IsWK'] as bool?,
        expBatOrder = json['ExpBatOrder'] as dynamic,
        actBatOrder = json['ActBatOrder'] as dynamic,
        bowlOrder = json['BowlOrder'] as dynamic,
        foursConc = json['FoursConc'] as dynamic,
        sixesConc = json['SixesConc'] as dynamic,
        dotBalls = json['DotBalls'] as dynamic,
        widesConc = json['WidesConc'] as dynamic,
        noBalls = json['NoBalls'] as dynamic,
        howOut = json['HowOut'],
        bowled = json['Bowled'],
        caught = json['Caught'];

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'FullName' : fullName,
    'NickName' : nickName,
    'FirstName' : firstName,
    'LastName' : lastName,
    'ShortName' : shortName,
    'IsOnStrike' : isOnStrike,
    'BatsmanRuns' : batsmanRuns,
    'Balls' : balls,
    'Fours' : fours,
    'Sixes' : sixes,
    'StrikeRate' : strikeRate,
    'Overs' : overs,
    'Maidens' : maidens,
    'Wickets' : wickets,
    'BowlerRuns' : bowlerRuns,
    'Economy' : economy,
    'IsCap' : isCap,
    'IsWK' : isWK,
    'ExpBatOrder' : expBatOrder,
    'ActBatOrder' : actBatOrder,
    'BowlOrder' : bowlOrder,
    'FoursConc' : foursConc,
    'SixesConc' : sixesConc,
    'DotBalls' : dotBalls,
    'WidesConc' : widesConc,
    'NoBalls' : noBalls,
    'HowOut' : howOut,
    'Bowled' : bowled,
    'Caught' : caught
  };
}

class Bowler {
  final dynamic csdId;
  final String? fullName;
  final String? nickName;
  final String? firstName;
  final String? lastName;
  final String? shortName;
  final bool? isOnStrike;
  final dynamic batsmanRuns;
  final dynamic balls;
  final dynamic fours;
  final dynamic sixes;
  final dynamic strikeRate;
  final dynamic overs;
  final dynamic maidens;
  final dynamic wickets;
  final dynamic bowlerRuns;
  final dynamic economy;
  final bool? isCap;
  final bool? isWK;
  final dynamic expBatOrder;
  final dynamic actBatOrder;
  final dynamic bowlOrder;
  final dynamic foursConc;
  final dynamic sixesConc;
  final dynamic dotBalls;
  final dynamic widesConc;
  final dynamic noBalls;
  final dynamic howOut;
  final dynamic bowled;
  final dynamic caught;

  Bowler({
    this.csdId,
    this.fullName,
    this.nickName,
    this.firstName,
    this.lastName,
    this.shortName,
    this.isOnStrike,
    this.batsmanRuns,
    this.balls,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.overs,
    this.maidens,
    this.wickets,
    this.bowlerRuns,
    this.economy,
    this.isCap,
    this.isWK,
    this.expBatOrder,
    this.actBatOrder,
    this.bowlOrder,
    this.foursConc,
    this.sixesConc,
    this.dotBalls,
    this.widesConc,
    this.noBalls,
    this.howOut,
    this.bowled,
    this.caught,
  });

  Bowler.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        fullName = json['FullName'] as String?,
        nickName = json['NickName'] as String?,
        firstName = json['FirstName'] as String?,
        lastName = json['LastName'] as String?,
        shortName = json['ShortName'] as String?,
        isOnStrike = json['IsOnStrike'] as bool?,
        batsmanRuns = json['BatsmanRuns'] as dynamic,
        balls = json['Balls'] as dynamic,
        fours = json['Fours'] as dynamic,
        sixes = json['Sixes'] as dynamic,
        strikeRate = json['StrikeRate'],
        overs = json['Overs'] as dynamic,
        maidens = json['Maidens'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        bowlerRuns = json['BowlerRuns'] as dynamic,
        economy = json['Economy'] as dynamic,
        isCap = json['IsCap'] as bool?,
        isWK = json['IsWK'] as bool?,
        expBatOrder = json['ExpBatOrder'] as dynamic,
        actBatOrder = json['ActBatOrder'] as dynamic,
        bowlOrder = json['BowlOrder'] as dynamic,
        foursConc = json['FoursConc'] as dynamic,
        sixesConc = json['SixesConc'] as dynamic,
        dotBalls = json['DotBalls'] as dynamic,
        widesConc = json['WidesConc'] as dynamic,
        noBalls = json['NoBalls'] as dynamic,
        howOut = json['HowOut'],
        bowled = json['Bowled'],
        caught = json['Caught'];

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'FullName' : fullName,
    'NickName' : nickName,
    'FirstName' : firstName,
    'LastName' : lastName,
    'ShortName' : shortName,
    'IsOnStrike' : isOnStrike,
    'BatsmanRuns' : batsmanRuns,
    'Balls' : balls,
    'Fours' : fours,
    'Sixes' : sixes,
    'StrikeRate' : strikeRate,
    'Overs' : overs,
    'Maidens' : maidens,
    'Wickets' : wickets,
    'BowlerRuns' : bowlerRuns,
    'Economy' : economy,
    'IsCap' : isCap,
    'IsWK' : isWK,
    'ExpBatOrder' : expBatOrder,
    'ActBatOrder' : actBatOrder,
    'BowlOrder' : bowlOrder,
    'FoursConc' : foursConc,
    'SixesConc' : sixesConc,
    'DotBalls' : dotBalls,
    'WidesConc' : widesConc,
    'NoBalls' : noBalls,
    'HowOut' : howOut,
    'Bowled' : bowled,
    'Caught' : caught
  };
}

class LastBatsmanOut {
  final dynamic csdId;
  final String? fullName;
  final String? nickName;
  final String? firstName;
  final String? lastName;
  final String? shortName;
  final bool? isOnStrike;
  final dynamic batsmanRuns;
  final dynamic balls;
  final dynamic fours;
  final dynamic sixes;
  final dynamic strikeRate;
  final dynamic overs;
  final dynamic maidens;
  final dynamic wickets;
  final dynamic bowlerRuns;
  final dynamic economy;
  final bool? isCap;
  final bool? isWK;
  final dynamic expBatOrder;
  final dynamic actBatOrder;
  final dynamic bowlOrder;
  final dynamic foursConc;
  final dynamic sixesConc;
  final dynamic dotBalls;
  final dynamic widesConc;
  final dynamic noBalls;
  final dynamic howOut;
  final dynamic bowled;
  final dynamic caught;

  LastBatsmanOut({
    this.csdId,
    this.fullName,
    this.nickName,
    this.firstName,
    this.lastName,
    this.shortName,
    this.isOnStrike,
    this.batsmanRuns,
    this.balls,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.overs,
    this.maidens,
    this.wickets,
    this.bowlerRuns,
    this.economy,
    this.isCap,
    this.isWK,
    this.expBatOrder,
    this.actBatOrder,
    this.bowlOrder,
    this.foursConc,
    this.sixesConc,
    this.dotBalls,
    this.widesConc,
    this.noBalls,
    this.howOut,
    this.bowled,
    this.caught,
  });

  LastBatsmanOut.fromJson(Map<String, dynamic> json)
      : csdId = json['CsdId'] as dynamic,
        fullName = json['FullName'] as String?,
        nickName = json['NickName'] as String?,
        firstName = json['FirstName'] as String?,
        lastName = json['LastName'] as String?,
        shortName = json['ShortName'] as String?,
        isOnStrike = json['IsOnStrike'] as bool?,
        batsmanRuns = json['BatsmanRuns'] as dynamic,
        balls = json['Balls'] as dynamic,
        fours = json['Fours'] as dynamic,
        sixes = json['Sixes'] as dynamic,
        strikeRate = json['StrikeRate'] as dynamic,
        overs = json['Overs'] as dynamic,
        maidens = json['Maidens'] as dynamic,
        wickets = json['Wickets'] as dynamic,
        bowlerRuns = json['BowlerRuns'] as dynamic,
        economy = json['Economy'],
        isCap = json['IsCap'] as bool?,
        isWK = json['IsWK'] as bool?,
        expBatOrder = json['ExpBatOrder'] as dynamic,
        actBatOrder = json['ActBatOrder'] as dynamic,
        bowlOrder = json['BowlOrder'] as dynamic,
        foursConc = json['FoursConc'] as dynamic,
        sixesConc = json['SixesConc'] as dynamic,
        dotBalls = json['DotBalls'] as dynamic,
        widesConc = json['WidesConc'] as dynamic,
        noBalls = json['NoBalls'] as dynamic,
        howOut = json['HowOut'] as dynamic,
        bowled = json['Bowled'] as dynamic,
        caught = json['Caught'] as dynamic;

  Map<String, dynamic> toJson() => {
    'CsdId' : csdId,
    'FullName' : fullName,
    'NickName' : nickName,
    'FirstName' : firstName,
    'LastName' : lastName,
    'ShortName' : shortName,
    'IsOnStrike' : isOnStrike,
    'BatsmanRuns' : batsmanRuns,
    'Balls' : balls,
    'Fours' : fours,
    'Sixes' : sixes,
    'StrikeRate' : strikeRate,
    'Overs' : overs,
    'Maidens' : maidens,
    'Wickets' : wickets,
    'BowlerRuns' : bowlerRuns,
    'Economy' : economy,
    'IsCap' : isCap,
    'IsWK' : isWK,
    'ExpBatOrder' : expBatOrder,
    'ActBatOrder' : actBatOrder,
    'BowlOrder' : bowlOrder,
    'FoursConc' : foursConc,
    'SixesConc' : sixesConc,
    'DotBalls' : dotBalls,
    'WidesConc' : widesConc,
    'NoBalls' : noBalls,
    'HowOut' : howOut,
    'Bowled' : bowled,
    'Caught' : caught
  };
}