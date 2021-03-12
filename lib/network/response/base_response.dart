import 'dart:convert';

class BaseResponse {
  Header header;

  BaseResponse(this.header);

  BaseResponse copyWith({
    Header header,
  }) =>
      BaseResponse(
        header ?? this.header,
      );

  factory BaseResponse.fromJson(String str) =>
      BaseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BaseResponse.fromMap(Map<String, dynamic> json) => BaseResponse(
        json["header"] == null ? null : Header.fromMap(json["header"]),
      );

  Map<String, dynamic> toMap() => {
        "header": header == null ? null : header.toMap(),
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

  Header copyWith({
    String status,
    String statusCode,
    String statusMessage,
  }) =>
      Header(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  factory Header.fromJson(String str) => Header.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Header.fromMap(Map<String, dynamic> json) => Header(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        statusMessage:
            json["statusMessage"] == null ? null : json["statusMessage"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "statusMessage": statusMessage == null ? null : statusMessage,
      };
}
