class PinGenerateModel {
  int memberId;
  String pin;
  int createdBy;
  Header header;

  PinGenerateModel({this.memberId, this.pin, this.createdBy, this.header});

  PinGenerateModel.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    pin = json['pin'];
    createdBy = json['createdBy'];
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['pin'] = this.pin;
    data['createdBy'] = this.createdBy;
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    return data;
  }
}

class Header {
  String status;
  String statusCode;
  Null statusMessage;

  Header({this.status, this.statusCode, this.statusMessage});

  Header.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    return data;
  }
}



// class PinGenerateModel {
//   Header header;
//   int memberId;
//   String pin;
//   int createdBy;
//
//   PinGenerateModel({this.header, this.memberId, this.pin, this.createdBy});
//
//   PinGenerateModel.fromJson(Map<String, dynamic> json) {
//     header =
//     json['header'] != null ? new Header.fromJson(json['header']) : null;
//     memberId = json['memberId'];
//     pin = json['pin'];
//     createdBy = json['createdBy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.header != null) {
//       data['header'] = this.header.toJson();
//     }
//     data['memberId'] = this.memberId;
//     data['pin'] = this.pin;
//     data['createdBy'] = this.createdBy;
//     return data;
//   }
// }
//
// class Header {
//   String status;
//   String statusCode;
//   String statusMessage;
//
//   Header({this.status, this.statusCode, this.statusMessage});
//
//   Header.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     statusCode = json['statusCode'];
//     statusMessage = json['statusMessage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     data['statusMessage'] = this.statusMessage;
//     return data;
//   }
// }