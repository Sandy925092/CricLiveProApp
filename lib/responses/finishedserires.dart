// class FinishedSeriesResponse {
//   final bool? success;
//   final String? message;
//   final List<Data>? data;
//
//   FinishedSeriesResponse({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   FinishedSeriesResponse.fromJson(Map<String, dynamic> json)
//       : success = json['success'] as bool?,
//         message = json['message'] as String?,
//         data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
//
//   Map<String, dynamic> toJson() => {
//     'success' : success,
//     'message' : message,
//     'data' : data?.map((e) => e.toJson()).toList()
//   };
// }
//
// class Data {
//   final int? seriesId;
//   final String? seriesName;
//   final String? fromDate;
//   final String? toDate;
//   final String? gender;
//   final String? seriesType;
//   final String? fixtureType;
//   final List<Fixtures>? fixtures;
//
//   Data({
//     this.seriesId,
//     this.seriesName,
//     this.fromDate,
//     this.toDate,
//     this.gender,
//     this.seriesType,
//     this.fixtureType,
//     this.fixtures,
//   });
//
//   Data.fromJson(Map<String, dynamic> json)
//       : seriesId = json['seriesId'] as int?,
//         seriesName = json['seriesName'] as String?,
//         fromDate = json['fromDate'] as String?,
//         toDate = json['toDate'] as String?,
//         gender = json['gender'] as String?,
//         seriesType = json['seriesType'] as String?,
//         fixtureType = json['fixtureType'] as String?,
//         fixtures = (json['fixtures'] as List?)?.map((dynamic e) => Fixtures.fromJson(e as Map<String,dynamic>)).toList();
//
//   Map<String, dynamic> toJson() => {
//     'seriesId' : seriesId,
//     'seriesName' : seriesName,
//     'fromDate' : fromDate,
//     'toDate' : toDate,
//     'gender' : gender,
//     'seriesType' : seriesType,
//     'fixtureType' : fixtureType,
//     'fixtures' : fixtures?.map((e) => e.toJson()).toList()
//   };
// }
//
// class Fixtures {
//   final int? fixtureId;
//   final String? status;
//   final List<StartTimes>? startTimes;
//   final HomeTeam? homeTeam;
//   final AwayTeam? awayTeam;
//   final dynamic winningTeam;
//   final dynamic totalScore;
//
//   Fixtures({
//     this.fixtureId,
//     this.status,
//     this.startTimes,
//     this.homeTeam,
//     this.awayTeam,
//     this.winningTeam,
//     this.totalScore,
//   });
//
//   Fixtures.fromJson(Map<String, dynamic> json)
//       : fixtureId = json['fixtureId'] as int?,
//         status = json['status'] as String?,
//         startTimes = (json['startTimes'] as List?)?.map((dynamic e) => StartTimes.fromJson(e as Map<String,dynamic>)).toList(),
//         homeTeam = (json['homeTeam'] as Map<String,dynamic>?) != null ? HomeTeam.fromJson(json['homeTeam'] as Map<String,dynamic>) : null,
//         awayTeam = (json['awayTeam'] as Map<String,dynamic>?) != null ? AwayTeam.fromJson(json['awayTeam'] as Map<String,dynamic>) : null,
//         winningTeam = json['winningTeam'],
//         totalScore = json['totalScore'];
//
//   Map<String, dynamic> toJson() => {
//     'fixtureId' : fixtureId,
//     'status' : status,
//     'startTimes' : startTimes?.map((e) => e.toJson()).toList(),
//     'homeTeam' : homeTeam?.toJson(),
//     'awayTeam' : awayTeam?.toJson(),
//     'winningTeam' : winningTeam,
//     'totalScore' : totalScore
//   };
// }
//
// class StartTimes {
//   final int? day;
//   final String? date;
//   final String? time;
//
//   StartTimes({
//     this.day,
//     this.date,
//     this.time,
//   });
//
//   StartTimes.fromJson(Map<String, dynamic> json)
//       : day = json['day'] as int?,
//         date = json['date'] as String?,
//         time = json['time'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'day' : day,
//     'date' : date,
//     'time' : time
//   };
// }
//
// class HomeTeam {
//   final int? id;
//   final String? name;
//   final String? ageCategory;
//   final String? gender;
//
//   HomeTeam({
//     this.id,
//     this.name,
//     this.ageCategory,
//     this.gender,
//   });
//
//   HomeTeam.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         ageCategory = json['ageCategory'] as String?,
//         gender = json['gender'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'ageCategory' : ageCategory,
//     'gender' : gender
//   };
// }
//
// class AwayTeam {
//   final int? id;
//   final String? name;
//   final String? ageCategory;
//   final String? gender;
//
//   AwayTeam({
//     this.id,
//     this.name,
//     this.ageCategory,
//     this.gender,
//   });
//
//   AwayTeam.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         ageCategory = json['ageCategory'] as String?,
//         gender = json['gender'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'ageCategory' : ageCategory,
//     'gender' : gender
//   };
// }

class FinishedSeriesResponse {
  final bool? success;
  final String? message;
  final Data? data;

  FinishedSeriesResponse({
    this.success,
    this.message,
    this.data,
  });

  FinishedSeriesResponse.fromJson(Map<String, dynamic> json)
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
  final List<SeriesName>? content;
  final Pageable? pageable;
  final int? totalPages;
  final int? totalElements;
  final bool? last;
  final int? numberOfElements;
  final bool? first;
  final int? size;
  final int? number;
  final Sort? sort;
  final bool? empty;

  Data({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.numberOfElements,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.empty,
  });

  Data.fromJson(Map<String, dynamic> json)
      : content = (json['content'] as List?)?.map((dynamic e) => SeriesName.fromJson(e as Map<String,dynamic>)).toList(),
        pageable = (json['pageable'] as Map<String,dynamic>?) != null ? Pageable.fromJson(json['pageable'] as Map<String,dynamic>) : null,
        totalPages = json['totalPages'] as int?,
        totalElements = json['totalElements'] as int?,
        last = json['last'] as bool?,
        numberOfElements = json['numberOfElements'] as int?,
        first = json['first'] as bool?,
        size = json['size'] as int?,
        number = json['number'] as int?,
        sort = (json['sort'] as Map<String,dynamic>?) != null ? Sort.fromJson(json['sort'] as Map<String,dynamic>) : null,
        empty = json['empty'] as bool?;

  Map<String, dynamic> toJson() => {
    'content' : content?.map((e) => e.toJson()).toList(),
    'pageable' : pageable?.toJson(),
    'totalPages' : totalPages,
    'totalElements' : totalElements,
    'last' : last,
    'numberOfElements' : numberOfElements,
    'first' : first,
    'size' : size,
    'number' : number,
    'sort' : sort?.toJson(),
    'empty' : empty
  };
}

class SeriesName {
  final String? id;
  final String? receivedAt;
  final int? id2;
  final String? name;
  final String? fromDate;
  final String? toDate;
  final String? gender;
  final String? seriesType;
  final String? fixtureType;
  final dynamic getEntityKey;

  SeriesName({
    this.id,
    this.receivedAt,
    this.id2,
    this.name,
    this.fromDate,
    this.toDate,
    this.gender,
    this.seriesType,
    this.fixtureType,
    this.getEntityKey,
  });

  SeriesName.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        receivedAt = json['receivedAt'] as String?,
        id2 = json['Id'] as int?,
        name = json['Name'] as String?,
        fromDate = json['FromDate'] as String?,
        toDate = json['ToDate'] as String?,
        gender = json['Gender'] as String?,
        seriesType = json['SeriesType'] as String?,
        fixtureType = json['FixtureType'] as String?,
        getEntityKey = json['GetEntityKey'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'receivedAt' : receivedAt,
    'Id' : id2,
    'Name' : name,
    'FromDate' : fromDate,
    'ToDate' : toDate,
    'Gender' : gender,
    'SeriesType' : seriesType,
    'FixtureType' : fixtureType,
    'GetEntityKey' : getEntityKey
  };
}

class Pageable {
  final int? pageNumber;
  final int? pageSize;
  final Sort2? sort;
  final int? offset;
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
      : pageNumber = json['pageNumber'] as int?,
        pageSize = json['pageSize'] as int?,
        sort = (json['sort'] as Map<String,dynamic>?) != null ? Sort2.fromJson(json['sort'] as Map<String,dynamic>) : null,
        offset = json['offset'] as int?,
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
  final bool? unsorted;
  final bool? empty;

  Sort2({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  Sort2.fromJson(Map<String, dynamic> json)
      : sorted = json['sorted'] as bool?,
        unsorted = json['unsorted'] as bool?,
        empty = json['empty'] as bool?;

  Map<String, dynamic> toJson() => {
    'sorted' : sorted,
    'unsorted' : unsorted,
    'empty' : empty
  };
}

class Sort {
  final bool? sorted;
  final bool? unsorted;
  final bool? empty;

  Sort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  Sort.fromJson(Map<String, dynamic> json)
      : sorted = json['sorted'] as bool?,
        unsorted = json['unsorted'] as bool?,
        empty = json['empty'] as bool?;

  Map<String, dynamic> toJson() => {
    'sorted' : sorted,
    'unsorted' : unsorted,
    'empty' : empty
  };
}