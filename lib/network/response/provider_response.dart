import 'dart:convert';

import 'package:YOURDRS_FlutterAPP/network/response/base_response.dart';

class TeamInvitesResponse extends BaseResponse {
  TeamInvitesResponse({
    this.teamInvitesList,
    Header header,
  }) : super(header);

  List<TeamInvitesList> teamInvitesList;

  TeamInvitesResponse copyWith({
    List<TeamInvitesList> teamInvitesList,
    Header header,
  }) =>
      TeamInvitesResponse(
        teamInvitesList: teamInvitesList ?? this.teamInvitesList,
        header: header ?? this.header,
      );

  factory TeamInvitesResponse.fromJson(String str) =>
      TeamInvitesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamInvitesResponse.fromMap(Map<String, dynamic> json) =>
      TeamInvitesResponse(
        teamInvitesList: json["teamInvitesList"] == null
            ? null
            : List<TeamInvitesList>.from(
                json["teamInvitesList"].map((x) => TeamInvitesList.fromMap(x))),
        header: json["header"] == null ? null : Header.fromMap(json["header"]),
      );

  Map<String, dynamic> toMap() => {
        "teamInvitesList": teamInvitesList == null
            ? null
            : List<dynamic>.from(teamInvitesList.map((x) => x.toMap())),
        "header": header == null ? null : header.toMap(),
      };
}

class TeamInvitesList {
  TeamInvitesList({
    this.teamId,
    this.teamName,
    this.iconPath,
    this.iconPathSignedUrl,
    this.inviteId,
    this.invitedMemberName,
    this.sectionName,
    this.memberCount,
    this.inviteAccepted,
    this.inviteRejected,
    this.inviteWithdrawn,
    this.inviteDate,
  });

  int teamId;
  String teamName;
  String iconPath;
  String iconPathSignedUrl;
  int inviteId;
  String invitedMemberName;
  String sectionName;
  int memberCount;
  bool inviteAccepted;
  bool inviteRejected;
  bool inviteWithdrawn;
  DateTime inviteDate;

  TeamInvitesList copyWith({
    int teamId,
    String teamName,
    String iconPath,
    String iconPathSignedUrl,
    int inviteId,
    String invitedMemberName,
    String sectionName,
    int memberCount,
    bool inviteAccepted,
    bool inviteRejected,
    bool inviteWithdrawn,
    DateTime inviteDate,
  }) =>
      TeamInvitesList(
        teamId: teamId ?? this.teamId,
        teamName: teamName ?? this.teamName,
        iconPath: iconPath ?? this.iconPath,
        iconPathSignedUrl: iconPathSignedUrl ?? this.iconPathSignedUrl,
        inviteId: inviteId ?? this.inviteId,
        invitedMemberName: invitedMemberName ?? this.invitedMemberName,
        sectionName: sectionName ?? this.sectionName,
        memberCount: memberCount ?? this.memberCount,
        inviteAccepted: inviteAccepted ?? this.inviteAccepted,
        inviteRejected: inviteRejected ?? this.inviteRejected,
        inviteWithdrawn: inviteWithdrawn ?? this.inviteWithdrawn,
        inviteDate: inviteDate ?? this.inviteDate,
      );

  factory TeamInvitesList.fromMap(Map<String, dynamic> json) => TeamInvitesList(
        teamId: json["teamId"] == null ? null : json["teamId"],
        teamName: json["teamName"] == null ? null : json["teamName"],
        iconPath: json["iconPath"] == null ? null : json["iconPath"],
        iconPathSignedUrl: json["iconPathSignedUrl"] == null
            ? null
            : json["iconPathSignedUrl"],
        inviteId: json["inviteId"] == null ? null : json["inviteId"],
        invitedMemberName: json["invitedMemberName"] == null
            ? null
            : json["invitedMemberName"],
        sectionName: json["sectionName"] == null ? null : json["sectionName"],
        memberCount: json["memberCount"] == null ? null : json["memberCount"],
        inviteAccepted:
            json["inviteAccepted"] == null ? null : json["inviteAccepted"],
        inviteRejected:
            json["inviteRejected"] == null ? null : json["inviteRejected"],
        inviteWithdrawn:
            json["inviteWithdrawn"] == null ? null : json["inviteWithdrawn"],
        inviteDate: json["inviteDate"] == null
            ? null
            : DateTime.parse(json["inviteDate"]),
      );

  Map<String, dynamic> toMap() => {
        "teamId": teamId == null ? null : teamId,
        "teamName": teamName == null ? null : teamName,
        "iconPath": iconPath == null ? null : iconPath,
        "iconPathSignedUrl":
            iconPathSignedUrl == null ? null : iconPathSignedUrl,
        "inviteId": inviteId == null ? null : inviteId,
        "invitedMemberName":
            invitedMemberName == null ? null : invitedMemberName,
        "sectionName": sectionName == null ? null : sectionName,
        "memberCount": memberCount == null ? null : memberCount,
        "inviteAccepted": inviteAccepted == null ? null : inviteAccepted,
        "inviteRejected": inviteRejected == null ? null : inviteRejected,
        "inviteWithdrawn": inviteWithdrawn == null ? null : inviteWithdrawn,
        "inviteDate": inviteDate == null ? null : inviteDate.toIso8601String(),
      };
}
