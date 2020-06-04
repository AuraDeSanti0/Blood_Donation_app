import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

String url = "192.168.43.188:8080";

String Bname(File image){
  final bname = basename(image.path);
  return bname;
}