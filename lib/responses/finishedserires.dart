

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