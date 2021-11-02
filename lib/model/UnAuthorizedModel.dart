// To parse this JSON data, do
//
//     final unAuthorizedModel = unAuthorizedModelFromJson(jsonString);

import 'dart:convert';

UnAuthorizedModel unAuthorizedModelFromJson(String str) => UnAuthorizedModel.fromJson(json.decode(str));

String unAuthorizedModelToJson(UnAuthorizedModel data) => json.encode(data.toJson());

class UnAuthorizedModel {
  UnAuthorizedModel({
    this.successResonse,
    this.failedResponse,
  });

  dynamic successResonse;
  FailedResponse failedResponse;

  factory UnAuthorizedModel.fromJson(Map<String, dynamic> json) => UnAuthorizedModel(
    successResonse: json["successResonse"],
    failedResponse: FailedResponse.fromJson(json["failedResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "successResonse": successResonse,
    "failedResponse": failedResponse.toJson(),
  };
}

class FailedResponse {
  FailedResponse({
    this.error,
    this.token,
  });

  int error;
  String token;

  factory FailedResponse.fromJson(Map<String, dynamic> json) => FailedResponse(
    error: json["error"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "token": token,
  };
}
