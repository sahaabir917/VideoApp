// To parse this JSON data, do
//
//     final badRequestModel = badRequestModelFromJson(jsonString);

import 'dart:convert';

BadRequestModel badRequestModelFromJson(String str) => BadRequestModel.fromJson(json.decode(str));

String badRequestModelToJson(BadRequestModel data) => json.encode(data.toJson());

class BadRequestModel {
  BadRequestModel({
    this.value,
    this.formatters,
    this.contentTypes,
    this.declaredType,
    this.statusCode,
  });

  Value value;
  List<dynamic> formatters;
  List<dynamic> contentTypes;
  dynamic declaredType;
  int statusCode;

  factory BadRequestModel.fromJson(Map<String, dynamic> json) => BadRequestModel(
    value: Value.fromJson(json["value"]),
    formatters: List<dynamic>.from(json["formatters"].map((x) => x)),
    contentTypes: List<dynamic>.from(json["contentTypes"].map((x) => x)),
    declaredType: json["declaredType"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "value": value.toJson(),
    "formatters": List<dynamic>.from(formatters.map((x) => x)),
    "contentTypes": List<dynamic>.from(contentTypes.map((x) => x)),
    "declaredType": declaredType,
    "statusCode": statusCode,
  };
}

class Value {
  Value({
    this.errors,
    this.type,
    this.title,
    this.status,
    this.traceId,
  });

  Errors errors;
  String type;
  String title;
  int status;
  String traceId;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    errors: Errors.fromJson(json["errors"]),
    type: json["type"],
    title: json["title"],
    status: json["status"],
    traceId: json["traceId"],
  );

  Map<String, dynamic> toJson() => {
    "errors": errors.toJson(),
    "type": type,
    "title": title,
    "status": status,
    "traceId": traceId,
  };
}

class Errors {
  Errors({
    this.propertyName,
  });

  List<String> propertyName;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    propertyName: List<String>.from(json["property_name"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "property_name": List<dynamic>.from(propertyName.map((x) => x)),
  };
}
