// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.data,
    this.links,
    this.meta,
    this.error,
    this.message,
  });

  List<Datum>? data;
  Links? links;
  Meta? meta;
  bool? error;
  String? message;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
        "error": error,
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.notifiableId,
    this.readAt,
    this.data,
    this.date,
  });

  String? id;
  int? notifiableId;
  dynamic readAt;
  Data? data;
  String? date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        notifiableId: json["notifiable_id"],
        readAt: json["read_at"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notifiable_id": notifiableId,
        "read_at": readAt,
        "data": data?.toJson(),
        "date": date,
      };
}

class Data {
  Data({
    this.title,
    this.propertyId,
    this.propertyAlertId,
    this.message,
  });

  String? title;
  int? propertyId;
  int? propertyAlertId;
  String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        propertyId: json["property_id"],
        propertyAlertId: json["property_alert_id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "property_id": propertyId,
        "property_alert_id": propertyAlertId,
        "message": message,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
