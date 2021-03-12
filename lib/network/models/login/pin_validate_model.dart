//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     data['statusMessage'] = this.statusMessage;
//     return data;
//   }
// }
/// model class for the AuthenticateUser
class PinResponse{
  int userId;
  String userName;
  String displayName;
  String token;
  String memberPin;
  String appPhoneNo;
  List<MemberRole> memberRole;
  String profilePhoto;
  String clientIP;
  String phiSessionId;
  int patientId;
  String dob;
  bool isErxMember;
  Header header;

  PinResponse(
      {this.userId,
        this.userName,
        this.displayName,
        this.token,
        this.memberPin,
        this.appPhoneNo,
        this.memberRole,
        this.profilePhoto,
        this.clientIP,
        this.phiSessionId,
        this.patientId,
        this.dob,
        this.isErxMember,
        this.header});

  PinResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    displayName = json['displayName'];
    token = json['token'];
    memberPin = json['memberPin'];
    appPhoneNo = json['appPhoneNo'];
    if (json['memberRole'] != null) {
      memberRole = new List<MemberRole>();
      json['memberRole'].forEach((v) {
        memberRole.add(new MemberRole.fromJson(v));
      });
    }
    profilePhoto = json['profilePhoto'];
    clientIP = json['clientIP'];
    phiSessionId = json['phiSessionId'];
    patientId = json['patientId'];
    dob = json['dob'];
    isErxMember = json['isErxMember'];
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['token'] = this.token;
    data['memberPin'] = this.memberPin;
    data['appPhoneNo'] = this.appPhoneNo;
    if (this.memberRole != null) {
      data['memberRole'] = this.memberRole.map((v) => v.toJson()).toList();
    }
    data['profilePhoto'] = this.profilePhoto;
    data['clientIP'] = this.clientIP;
    data['phiSessionId'] = this.phiSessionId;
    data['patientId'] = this.patientId;
    data['dob'] = this.dob;
    data['isErxMember'] = this.isErxMember;
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    return data;
  }
}

class MemberRole {
  int memberId;
  int roleId;
  String roleName;

  MemberRole({this.memberId, this.roleId, this.roleName});

  MemberRole.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    roleId = json['roleId'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    return data;
  }
}

class Header {
  String status;
  String statusCode;
  String statusMessage;

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