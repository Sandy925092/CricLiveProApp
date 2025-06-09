class SeriesCategoryResponse {
  final bool? success;
  final String? message;
  final Data? data;

  SeriesCategoryResponse({
    this.success,
    this.message,
    this.data,
  });

  SeriesCategoryResponse.fromJson(Map<String, dynamic> json)
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
  final List<SeriesCategory>? content;
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
      : content = (json['content'] as List?)?.map((dynamic e) => SeriesCategory.fromJson(e as Map<String,dynamic>)).toList(),
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

class SeriesCategory {
  final String? id;
  final String? receivedAt;
  final num? id1;
  final String? name;
  final String? fromDate;
  final String? toDate;
  final String? gender;
  final String? seriesType;
  final String? fixtureType;
  final dynamic getEntityKey;

  SeriesCategory({
    this.id,
    this.receivedAt,
    this.id1,
    this.name,
    this.fromDate,
    this.toDate,
    this.gender,
    this.seriesType,
    this.fixtureType,
    this.getEntityKey,
  });

  SeriesCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        receivedAt = json['receivedAt'] as String?,
        id1 = json['Id'] as num?,
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
    'Id' : id,
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