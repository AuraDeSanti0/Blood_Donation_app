import 'package:flutter/material.dart';
class UserInfo {
  final String id;
  final String name;
  final String phone;
  final String bloodtype;
  //final String imageUrl;
  final String lastdate;

  const UserInfo({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.bloodtype,
    @required this.lastdate,
  });
}