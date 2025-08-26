class UpcomingSeriesResponse {
  bool? success;
  String? message;
  final Data? data;

  UpcomingSeriesResponse({this.success, this.message, this.data});

  UpcomingSeriesResponse.fromJson(Map<String, dynamic> json)
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
  final List<UpComingContent>? content;
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
      : content = (json['content'] as List?)?.map((dynamic e) => UpComingContent.fromJson(e as Map<String, dynamic>)).toList(),
        pageable = (json['pageable'] as Map<String, dynamic>?) != null ? Pageable.fromJson(json['pageable'] as Map<String, dynamic>) : null,
        totalPages = json['totalPages'] as int?,
        totalElements = json['totalElements'] as int?,
        last = json['last'] as bool?,
        numberOfElements = json['numberOfElements'] as int?,
        first = json['first'] as bool?,
        size = json['size'] as int?,
        number = json['number'] as int?,
        sort = (json['sort'] as Map<String, dynamic>?) != null ? Sort.fromJson(json['sort'] as Map<String, dynamic>) : null,
        empty = json['empty'] as bool?;

  // ✅ Move this inside the class
  Map<String, dynamic> toJson() => {
    'content': content?.map((e) => e.toJson()).toList(),
    'pageable': pageable?.toJson(),
    'totalPages': totalPages,
    'totalElements': totalElements,
    'last': last,
    'numberOfElements': numberOfElements,
    'first': first,
    'size': size,
    'number': number,
    'sort': sort?.toJson(),
    'empty': empty,
  };
}


class UpComingContent {
  int? seriesId;
  String? seriesName;
  String? fromDate;
  String? toDate;
  String? gender;
  String? seriesType;
  String? fixtureType;
  List<Fixtures>? fixtures;

  UpComingContent({
    this.seriesId,
    this.seriesName,
    this.fromDate,
    this.toDate,
    this.gender,
    this.seriesType,
    this.fixtureType,
    this.fixtures,
  });

  UpComingContent.fromJson(Map<String, dynamic> json)
      : seriesId = json['seriesId'] as int?,
        seriesName = json['seriesName'] as String?,
        fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?,
        gender = json['gender'] as String?,
        seriesType = json['seriesType'] as String?,
        fixtureType = json['fixtureType'] as String?,
        fixtures = (json['fixtures'] as List?)?.map((dynamic e) => Fixtures.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'seriesId': seriesId,
    'seriesName': seriesName,
    'fromDate': fromDate,
    'toDate': toDate,
    'gender': gender,
    'seriesType': seriesType,
    'fixtureType': fixtureType,
    'fixtures': fixtures?.map((e) => e.toJson()).toList(),
  };
}


class Fixtures {
  int? fixtureId;
  String? status;
  List<StartTimes>? startTimes;
  HomeTeam? homeTeam;
  HomeTeam? awayTeam;
  bool? liked;

  Fixtures(
      {this.fixtureId,
      this.status,
      this.startTimes,
      this.homeTeam,
      this.awayTeam,
      this.liked
      });

  Fixtures.fromJson(Map<String, dynamic> json) {
    fixtureId = json['fixtureId'];
    status = json['status'];
    if (json['startTimes'] != null) {
      startTimes = <StartTimes>[];
      json['startTimes'].forEach((v) {
        startTimes!.add(new StartTimes.fromJson(v));
      });
    }
    homeTeam = json['homeTeam'] != null
        ? new HomeTeam.fromJson(json['homeTeam'])
        : null;
    awayTeam = json['awayTeam'] != null
        ? new HomeTeam.fromJson(json['awayTeam'])
        : null;
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fixtureId'] = this.fixtureId;
    data['status'] = this.status;
    if (this.startTimes != null) {
      data['startTimes'] = this.startTimes!.map((v) => v.toJson()).toList();
    }
    if (this.homeTeam != null) {
      data['homeTeam'] = this.homeTeam!.toJson();
    }
    if (this.awayTeam != null) {
      data['awayTeam'] = this.awayTeam!.toJson();
    }
    data['liked'] = this.liked;
    return data;
  }
}

class StartTimes {
  int? day;
  String? date;
  String? time;

  StartTimes({this.day, this.date, this.time});

  StartTimes.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

class HomeTeam {
  int? id;
  String? name;
  String? flagUrl;
  String? ageCategory;
  String? gender;

  HomeTeam({this.id, this.name,this.flagUrl, this.ageCategory, this.gender});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    flagUrl = json['flagUrl'];
    ageCategory = json['ageCategory'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flagUrl'] = this.flagUrl;
    data['name'] = this.name;
    data['ageCategory'] = this.ageCategory;
    data['gender'] = this.gender;
    return data;
  }
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
