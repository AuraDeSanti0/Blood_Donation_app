import 'package:flutter/material.dart';

class DonorInfo{
  final String id;
  final String dName;
  final String sfz;
  final String phone;
  final String bloodtype;
  final String city;
  final String pwd;

  DonorInfo({
    @required this.id,
    @required this.dName,
    @required this.sfz,
    @required this.phone,
    @required this.bloodtype,
    @required this.city,
    @required this.pwd,
  });
}
