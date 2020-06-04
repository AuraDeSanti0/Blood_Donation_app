import 'package:flutter/material.dart';

class HospitalInfo{
  final String id;
  final String hName;
  final String license;
  final String phone;
  final String city;
  final String pwd;

  HospitalInfo({
    @required this.id,
    @required this.hName,
    @required this.license,
    @required this.phone,
    @required this.city,
    @required this.pwd,
});
}
