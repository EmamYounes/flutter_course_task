import 'dart:convert';

import 'package:flutter_course_task/base/BaseModel.dart';

class CourseDetailsModel extends BaseModel<CourseDetailsModel> {
  final int id;
  final String title;
  final List<String> img;
  final String interest;
  final int price;
  final String date;
  final String address;
  final String trainerName;
  final String trainerImg;
  final String trainerInfo;
  final String occasionDetail;
  final String latitude;
  final String longitude;
  final bool isLiked;
  final bool isSold;
  final bool isPrivateEvent;
  final bool hiddenCashPayment;
  final List<ReservTypes> reservTypes;

  CourseDetailsModel(
      {this.id,
      this.title,
      this.img,
      this.interest,
      this.price,
      this.date,
      this.address,
      this.trainerName,
      this.trainerImg,
      this.trainerInfo,
      this.occasionDetail,
      this.latitude,
      this.longitude,
      this.isLiked,
      this.isSold,
      this.isPrivateEvent,
      this.hiddenCashPayment,
      this.reservTypes});

  factory CourseDetailsModel.fromRawJson(String str) =>
      CourseDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailsModel(
        id: json["id"],
        title: json["title"],
        img: List<String>.from(json["img"].map((x) => x)),
        interest: json["interest"],
        price: json["price"],
        date: json["date"],
        address: json["address"],
        trainerName: json["trainerName"],
        trainerImg: json["trainerImg"],
        trainerInfo: json["trainerInfo"],
        occasionDetail: json["occasionDetail"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isLiked: json["isLiked"],
        isSold: json["isSold"],
        isPrivateEvent: json["isPrivateEvent"],
        hiddenCashPayment: json["hiddenCashPayment"],
        reservTypes: List<ReservTypes>.from(
            json["reservTypes"].map((x) => ReservTypes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": List<dynamic>.from(img.map((x) => x)),
        "interest": interest,
        "price": price,
        "date": date,
        "address": address,
        "trainerName": trainerName,
        "trainerImg": trainerImg,
        "trainerInfo": trainerInfo,
        "occasionDetail": occasionDetail,
        "latitude": latitude,
        "longitude": longitude,
        "isLiked": isLiked,
        "isSold": isSold,
        "isPrivateEvent": isPrivateEvent,
        "hiddenCashPayment": hiddenCashPayment,
        "reservTypes": List<dynamic>.from(reservTypes.map((x) => x.toJson())),
      };

  @override
  CourseDetailsModel fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel.fromJson(json);
  }
}

class ReservTypes extends BaseModel<ReservTypes> {
  final int id;
  final String name;
  final int count;
  final int price;

  ReservTypes({
    this.id,
    this.name,
    this.count,
    this.price,
  });

  factory ReservTypes.fromRawJson(String str) =>
      ReservTypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReservTypes.fromJson(Map<String, dynamic> json) => ReservTypes(
        id: json["id"],
        name: json["name"],
        count: json["count"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
        "price": price,
      };

  @override
  ReservTypes fromJson(Map<String, dynamic> json) {
    return ReservTypes.fromJson(json);
  }
}
