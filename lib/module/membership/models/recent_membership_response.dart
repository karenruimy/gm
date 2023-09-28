// To parse this JSON data, do
//
//     final recentMembershipModel = recentMembershipModelFromJson(jsonString);

import 'dart:convert';

List<RecentMembershipModel> recentMembershipModelFromJson(dynamic json) => List<RecentMembershipModel>.from(json.map((x) => RecentMembershipModel.fromJson(x)));

String recentMembershipModelToJson(List<RecentMembershipModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class RecentMembershipModel {
  String id;
  String userEmail;
  String userNicename;
  String membershipId;
  String membershipName;
  String status;
  DateTime modified;

  RecentMembershipModel({
    required this.id,
    required this.userEmail,
    required this.userNicename,
    required this.membershipId,
    required this.membershipName,
    required this.status,
    required this.modified,
  });

  factory RecentMembershipModel.fromJson(Map<String, dynamic> json) => RecentMembershipModel(
    id: json["id"],
    userEmail: json["user_email"],
    userNicename: json["user_nicename"],
    membershipId: json["membership_id"],
    membershipName: json["membership_name"],
    status: json["status"],
    modified: DateTime.parse(json["modified"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_email": userEmail,
    "user_nicename": userNicename,
    "membership_id": membershipId,
    "membership_name": membershipName,
    "status": status,
    "modified": modified.toIso8601String(),
  };
}
