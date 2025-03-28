class UpcomingSeriesResponse {
  bool? success;
  String? message;
  List<Data>? data;

  UpcomingSeriesResponse({this.success, this.message, this.data});

  UpcomingSeriesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? seriesId;
  String? seriesName;
  String? fromDate;
  String? toDate;
  String? gender;
  String? seriesType;
  String? fixtureType;
  List<Fixtures>? fixtures;

  Data(
      {this.seriesId,
      this.seriesName,
      this.fromDate,
      this.toDate,
      this.gender,
      this.seriesType,
      this.fixtureType,
      this.fixtures});

  Data.fromJson(Map<String, dynamic> json) {
    seriesId = json['seriesId'];
    seriesName = json['seriesName'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    gender = json['gender'];
    seriesType = json['seriesType'];
    fixtureType = json['fixtureType'];
    if (json['fixtures'] != null) {
      fixtures = <Fixtures>[];
      json['fixtures'].forEach((v) {
        fixtures!.add(new Fixtures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seriesId'] = this.seriesId;
    data['seriesName'] = this.seriesName;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['gender'] = this.gender;
    data['seriesType'] = this.seriesType;
    data['fixtureType'] = this.fixtureType;
    if (this.fixtures != null) {
      data['fixtures'] = this.fixtures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fixtures {
  int? fixtureId;
  String? status;
  List<StartTimes>? startTimes;
  HomeTeam? homeTeam;
  HomeTeam? awayTeam;

  Fixtures(
      {this.fixtureId,
      this.status,
      this.startTimes,
      this.homeTeam,
      this.awayTeam});

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
  String? ageCategory;
  String? gender;

  HomeTeam({this.id, this.name, this.ageCategory, this.gender});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ageCategory = json['ageCategory'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ageCategory'] = this.ageCategory;
    data['gender'] = this.gender;
    return data;
  }
}
