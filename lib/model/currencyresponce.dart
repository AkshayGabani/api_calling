// To parse this JSON data, do
//
//     final currencyuserresponse = currencyuserresponseFromJson(jsonString);

import 'dart:convert';

Currencyuserresponse currencyuserresponseFromJson(String str) => Currencyuserresponse.fromJson(json.decode(str));

String currencyuserresponseToJson(Currencyuserresponse data) => json.encode(data.toJson());

class Currencyuserresponse {
  Currencyuserresponse({
    this.success,
    this.query,
    this.info,
    this.date,
    this.result,
  });

  bool? success;
  Query? query;
  Info? info;
  DateTime? date;
  double? result;

  factory Currencyuserresponse.fromJson(Map<String, dynamic> json) => Currencyuserresponse(
    success: json["success"],
    query: json["query"] == null ? null : Query.fromJson(json["query"]),
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    result: json["result"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "query": query?.toJson(),
    "info": info?.toJson(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "result": result,
  };
}

class Info {
  Info({
    this.timestamp,
    this.rate,
  });

  int? timestamp;
  double? rate;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    timestamp: json["timestamp"],
    rate: json["rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "rate": rate,
  };
}

class Query {
  Query({
    this.from,
    this.to,
    this.amount,
  });

  String? from;
  String? to;
  int? amount;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    from: json["from"],
    to: json["to"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "amount": amount,
  };
}
