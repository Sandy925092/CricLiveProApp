class MyEventsResponse {
  final bool? success;
  final String? message;
  final Data? data;

  MyEventsResponse({
    this.success,
    this.message,
    this.data,
  });

  MyEventsResponse.fromJson(Map<String, dynamic> json)
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
  final List<MyEventsData>? content;
  final Pageable? pageable;
  final bool? last;
  final num? totalElements;
  final num? totalPages;
  final num? size;
  final num? number;
  final Sort? sort;
  final bool? first;
  final num? numberOfElements;
  final bool? empty;

  Data({
    this.content,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  Data.fromJson(Map<String, dynamic> json)
      : content = (json['content'] as List?)?.map((dynamic e) => MyEventsData.fromJson(e as Map<String,dynamic>)).toList(),
        pageable = (json['pageable'] as Map<String,dynamic>?) != null ? Pageable.fromJson(json['pageable'] as Map<String,dynamic>) : null,
        last = json['last'] as bool?,
        totalElements = json['totalElements'] as num?,
        totalPages = json['totalPages'] as num?,
        size = json['size'] as num?,
        number = json['number'] as num?,
        sort = (json['sort'] as Map<String,dynamic>?) != null ? Sort.fromJson(json['sort'] as Map<String,dynamic>) : null,
        first = json['first'] as bool?,
        numberOfElements = json['numberOfElements'] as num?,
        empty = json['empty'] as bool?;

  Map<String, dynamic> toJson() => {
    'content' : content?.map((e) => e.toJson()).toList(),
    'pageable' : pageable?.toJson(),
    'last' : last,
    'totalElements' : totalElements,
    'totalPages' : totalPages,
    'size' : size,
    'number' : number,
    'sort' : sort?.toJson(),
    'first' : first,
    'numberOfElements' : numberOfElements,
    'empty' : empty
  };
}

class MyEventsData {
  final num? seriesId;
  final String? seriesName;
  final num? fixtureId;
  final String? homeTeam;
  final String? awayTeam;
  final String? status;
  final String? matchDateTime;
  final String? homeTeamFlag;
  final String? awayTeamFlag;
  final List<num>? homeTeamRuns;
  final List<num>? homeTeamWickets;
  final List<num>? awayTeamRuns;
  final List<num>? awayTeamWickets;
  final dynamic winningTeamName;
  final bool? result;

  MyEventsData({
    this.seriesId,
    this.seriesName,
    this.fixtureId,
    this.homeTeam,
    this.awayTeam,
    this.status,
    this.matchDateTime,
    this.homeTeamFlag,
    this.awayTeamFlag,
    this.homeTeamRuns,
    this.homeTeamWickets,
    this.awayTeamRuns,
    this.awayTeamWickets,
    this.winningTeamName,
    this.result,
  });

  MyEventsData.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'] as num?,
        seriesName = json['seriesName'] as String?,
        fixtureId = json['fixtureId'] as num?,
        homeTeam = json['homeTeam'] as String?,
        awayTeam = json['awayTeam'] as String?,
        status = json['status'] as String?,
        matchDateTime = json['matchDateTime'] as String?,
        homeTeamFlag = json['homeTeamFlag'] as String?,
        awayTeamFlag = json['awayTeamFlag'] as String?,
        homeTeamRuns = (json['homeTeamRuns'] as List?)?.map((dynamic e) => e as num).toList(),
        homeTeamWickets = (json['homeTeamWickets'] as List?)?.map((dynamic e) => e as num).toList(),
        awayTeamRuns = (json['awayTeamRuns'] as List?)?.map((dynamic e) => e as num).toList(),
        awayTeamWickets = (json['awayTeamWickets'] as List?)?.map((dynamic e) => e as num).toList(),
        winningTeamName = json['winningTeamName'],
        result = json['result'] as bool?;

  Map<String, dynamic> toJson() => {
    'seriesId' : seriesId,
    'seriesName' : seriesName,
    'fixtureId' : fixtureId,
    'homeTeam' : homeTeam,
    'awayTeam' : awayTeam,
    'status' : status,
    'matchDateTime' : matchDateTime,
    'homeTeamFlag' : homeTeamFlag,
    'awayTeamFlag' : awayTeamFlag,
    'homeTeamRuns' : homeTeamRuns,
    'homeTeamWickets' : homeTeamWickets,
    'awayTeamRuns' : awayTeamRuns,
    'awayTeamWickets' : awayTeamWickets,
    'winningTeamName' : winningTeamName,
    'result' : result
  };
}

class Pageable {
  final num? pageNumber;
  final num? pageSize;
  final Sort2? sort;
  final num? offset;
  final bool? paged;
  final bool? unpaged;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  Pageable.fromJson(Map<String, dynamic> json)
      : pageNumber = json['pageNumber'] as num?,
        pageSize = json['pageSize'] as num?,
        sort = (json['sort'] as Map<String,dynamic>?) != null ? Sort2.fromJson(json['sort'] as Map<String,dynamic>) : null,
        offset = json['offset'] as num?,
        paged = json['paged'] as bool?,
        unpaged = json['unpaged'] as bool?;

  Map<String, dynamic> toJson() => {
    'pageNumber' : pageNumber,
    'pageSize' : pageSize,
    'sort' : sort?.toJson(),
    'offset' : offset,
    'paged' : paged,
    'unpaged' : unpaged
  };
}

class Sort2 {
  final bool? sorted;
  final bool? empty;
  final bool? unsorted;

  Sort2({
    this.sorted,
    this.empty,
    this.unsorted,
  });

  Sort2.fromJson(Map<String, dynamic> json)
      : sorted = json['sorted'] as bool?,
        empty = json['empty'] as bool?,
        unsorted = json['unsorted'] as bool?;

  Map<String, dynamic> toJson() => {
    'sorted' : sorted,
    'empty' : empty,
    'unsorted' : unsorted
  };
}

class Sort {
  final bool? sorted;
  final bool? empty;
  final bool? unsorted;

  Sort({
    this.sorted,
    this.empty,
    this.unsorted,
  });

  Sort.fromJson(Map<String, dynamic> json)
      : sorted = json['sorted'] as bool?,
        empty = json['empty'] as bool?,
        unsorted = json['unsorted'] as bool?;

  Map<String, dynamic> toJson() => {
    'sorted' : sorted,
    'empty' : empty,
    'unsorted' : unsorted
  };
}