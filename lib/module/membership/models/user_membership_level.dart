// To parse this JSON data, do
//
//     final userMembershipLevelModel = userMembershipLevelModelFromJson(jsonString);

import 'dart:convert';

List<UserMembershipLevelModel> userMembershipLevelModelFromJson(dynamic json) => List<UserMembershipLevelModel>.from(json.map((x) => UserMembershipLevelModel.fromJson(x)));

String userMembershipLevelModelToJson(List<UserMembershipLevelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserMembershipLevelModel {
  String id;
  String userMembershipLevelModelId;
  String subscriptionId;
  String name;
  String description;
  String confirmation;
  String expirationNumber;
  String expirationPeriod;
  int initialPayment;
  int billingAmount;
  String cycleNumber;
  String cyclePeriod;
  String billingLimit;
  int trialAmount;
  String trialLimit;
  String codeId;
  String startdate;
  dynamic enddate;

  UserMembershipLevelModel({
    required this.id,
    required this.userMembershipLevelModelId,
    required this.subscriptionId,
    required this.name,
    required this.description,
    required this.confirmation,
    required this.expirationNumber,
    required this.expirationPeriod,
    required this.initialPayment,
    required this.billingAmount,
    required this.cycleNumber,
    required this.cyclePeriod,
    required this.billingLimit,
    required this.trialAmount,
    required this.trialLimit,
    required this.codeId,
    required this.startdate,
    required this.enddate,
  });

  factory UserMembershipLevelModel.fromJson(Map<String, dynamic> json) => UserMembershipLevelModel(
    id: json["ID"],
    userMembershipLevelModelId: json["id"],
    subscriptionId: json["subscription_id"],
    name: json["name"],
    description: json["description"],
    confirmation: json["confirmation"],
    expirationNumber: json["expiration_number"],
    expirationPeriod: json["expiration_period"],
    initialPayment: json["initial_payment"],
    billingAmount: json["billing_amount"],
    cycleNumber: json["cycle_number"],
    cyclePeriod: json["cycle_period"],
    billingLimit: json["billing_limit"],
    trialAmount: json["trial_amount"],
    trialLimit: json["trial_limit"],
    codeId: json["code_id"],
    startdate: json["startdate"],
    enddate: json["enddate"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "id": userMembershipLevelModelId,
    "subscription_id": subscriptionId,
    "name": name,
    "description": description,
    "confirmation": confirmation,
    "expiration_number": expirationNumber,
    "expiration_period": expirationPeriod,
    "initial_payment": initialPayment,
    "billing_amount": billingAmount,
    "cycle_number": cycleNumber,
    "cycle_period": cyclePeriod,
    "billing_limit": billingLimit,
    "trial_amount": trialAmount,
    "trial_limit": trialLimit,
    "code_id": codeId,
    "startdate": startdate,
    "enddate": enddate,
  };
}
