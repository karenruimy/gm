// To parse this JSON data, do
//
//     final levelsModel = levelsModelFromJson(jsonString);

import 'dart:convert';

MembershipLevelModel levelsModelFromJson(dynamic json) => MembershipLevelModel.fromJson(json);

String levelsModelToJson(MembershipLevelModel data) => json.encode(data.toJson());

class MembershipLevelModel {
  String id;
  String levelsModelId;
  String name;
  String description;
  String confirmation;
  String initialPayment;
  String billingAmount;
  String cycleNumber;
  String cyclePeriod;
  String billingLimit;
  String trialAmount;
  String trialLimit;
  String allowSignups;
  String expirationNumber;
  String expirationPeriod;
  List<int> categories;

  MembershipLevelModel({
    required this.id,
    required this.levelsModelId,
    required this.name,
    required this.description,
    required this.confirmation,
    required this.initialPayment,
    required this.billingAmount,
    required this.cycleNumber,
    required this.cyclePeriod,
    required this.billingLimit,
    required this.trialAmount,
    required this.trialLimit,
    required this.allowSignups,
    required this.expirationNumber,
    required this.expirationPeriod,
    required this.categories,
  });

  factory MembershipLevelModel.fromJson(Map<String, dynamic> json) => MembershipLevelModel(
    id: json["ID"],
    levelsModelId: json["id"],
    name: json["name"],
    description: json["description"],
    confirmation: json["confirmation"],
    initialPayment: json["initial_payment"],
    billingAmount: json["billing_amount"],
    cycleNumber: json["cycle_number"],
    cyclePeriod: json["cycle_period"],
    billingLimit: json["billing_limit"],
    trialAmount: json["trial_amount"],
    trialLimit: json["trial_limit"],
    allowSignups: json["allow_signups"],
    expirationNumber: json["expiration_number"],
    expirationPeriod: json["expiration_period"],
    categories: List<int>.from(json["categories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "id": levelsModelId,
    "name": name,
    "description": description,
    "confirmation": confirmation,
    "initial_payment": initialPayment,
    "billing_amount": billingAmount,
    "cycle_number": cycleNumber,
    "cycle_period": cyclePeriod,
    "billing_limit": billingLimit,
    "trial_amount": trialAmount,
    "trial_limit": trialLimit,
    "allow_signups": allowSignups,
    "expiration_number": expirationNumber,
    "expiration_period": expirationPeriod,
    "categories": List<dynamic>.from(categories.map((x) => x)),
  };

}
