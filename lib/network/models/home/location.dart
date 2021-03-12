import 'dart:convert';

import 'package:equatable/equatable.dart';

Locations LocationFromJson(String str) => Locations.fromJson(json.decode(str));

String LocationToJson(Locations data) => json.encode(data.toJson());

class Locations {
  Locations({
    this.header,
    this.locationList,
  });

  Header header;
  List<LocationList> locationList;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        locationList: json["locationList"] == null
            ? null
            : List<LocationList>.from(
                json["locationList"].map((x) => LocationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "header": header == null ? null : header.toJson(),
        "locationList": locationList == null
            ? null
            : List<dynamic>.from(locationList.map((x) => x.toJson())),
      };
}

class Header {
  Header({
    this.status,
    this.statusCode,
    this.statusMessage,
  });

  String status;
  String statusCode;
  String statusMessage;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        statusMessage:
            json["statusMessage"] == null ? null : json["statusMessage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "statusMessage": statusMessage == null ? null : statusMessage,
      };
}

class LocationList extends Equatable {
  LocationList({
    this.locationId,
    this.locationName,
    this.memberId,
  });

  int locationId;
  String locationName;
  int memberId;

  factory LocationList.fromJson(Map<String, dynamic> json) => LocationList(
        locationId: json["locationId"] == null ? null : json["locationId"],
        locationName:
            json["locationName"] == null ? null : json["locationName"],
        memberId: json["memberId"] == null ? null : json["memberId"],
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId == null ? null : locationId,
        "locationName": locationName == null ? null : locationName,
        "memberId": memberId == null ? null : memberId,
      };

  @override
  String toString() {
    return 'LocationList{locationId: $locationId, locationName: $locationName, memberId: $memberId}';
  }

  @override
// TODO: implement props
  List<Object> get props => [
        this.locationId,
        this.locationName,
        this.memberId,
      ];
}
