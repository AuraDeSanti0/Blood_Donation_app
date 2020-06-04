import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './hospital_info.dart';
import './donor_info.dart';
import '../models/db_url.dart';
Map<String, String> _h = {
  'hName': '',
  'license': '',
  'phone': '',
  'city': '',
  'pwd': '',
};
Map<String, String> _d = {
  'dName': '',
  'sfz': '',
  'bloodtype': '',
  'phone': '',
  'city': '',
  'pwd': '',
};

HospitalInfo _hospitalInfo;
DonorInfo _donorInfo;

class Auth with ChangeNotifier {
  String urlL = url;

  Map<String, String> get h{
    return _h;
  }

  Map<String, String> get d{
    return _d;
  }
  Map<String, String> getHInfo(){
    return h;
  }

  Future<String> hlogin(String phone, String pwd) async {
      final response = await http.post("http://$urlL/blood/login_hospital.php",
          body: {
            "phone": phone,
            "pwd": pwd,
          });
      //print(response.body);
      var datauser = json.decode(response.body);
      if(response.statusCode == 200){
        if(datauser.length > 2){
          print(datauser);
          _h['id'] = datauser['id'];
          _h['hName'] = datauser['name'];
          _h['license'] = datauser['license'];
          _h['phone'] = datauser['phone'];
          _h['city'] = datauser['city'];
          _h['pwd'] = datauser['pwd'];
          notifyListeners();
          return('1');
        }else{
          if( datauser['code']=='2'){
            return('2');
          }
          if( datauser['code']=='3'){
            return('3');
          }
        }
      } else{
        return '4';
      }
    }

  Future<String> dlogin(String phone, String pwd) async {
        final response = await http.post("http://$urlL/blood/login_donor.php",
          //  headers: {'Content-Type',' application/json'},
          //  encoding: Encoding.getByName("utf-8"),
            body: {
              "phone": phone,
              "pwd": pwd,
            });
        //print(response.body); json.decode(utf8.decode(response.bodyBytes));
        var datauser = json.decode(utf8.decode(response.bodyBytes));
        if(response.statusCode == 200){
          if(datauser.length > 2){
          //  print(datauser.length);
            _d['id']= datauser['id'];
            _d['dName'] = datauser['name'];
            _d['sfz'] = datauser['sfz'];
            _d['birthday'] = datauser['birthday'];
            _d['sex'] = datauser['sex'];
            _d['bloodtype'] = datauser['bloodtype'];
            _d['phone'] = datauser['phone'];
            _d['city'] = datauser['city'];
            _d['pwd'] = datauser['pwd'];
            notifyListeners();
            return('1');
          }else{
             if( datauser['code']=='2'){
               return('2');
             }
             if( datauser['code']=='3'){
               return('3');
             }
          }
        } else{
          return '4';
        }
       //print(_d['id']);
       // _d['birthday'] is String ? print('s') : print('d');
    }

  Future<void> getDonorInfo() async {
    try{
      final response = await http.post("http://$urlL/blood/getDonorInfo.php",
          //  headers: {'Content-Type',' application/json'},
          //  encoding: Encoding.getByName("utf-8"),
          body: {
            "id": _d['id'],
          });
      //print(response.body); json.decode(utf8.decode(response.bodyBytes));
      var datauser = json.decode(utf8.decode(response.bodyBytes));
      print(datauser);
      _d['id']= datauser['id'];
      _d['dName'] = datauser['name'];
      _d['sfz'] = datauser['sfz'];
      _d['birthday'] = datauser['birthday'];
      _d['sex'] = datauser['sex'];
      _d['bloodtype'] = datauser['bloodtype'];
      _d['phone'] = datauser['phone'];
      _d['city'] = datauser['city'];
      _d['pwd'] = datauser['pwd'];

      //print(_d['id']);
      // _d['birthday'] is String ? print('s') : print('d');
      notifyListeners();
    }catch(error){
      throw error;
    }
  }
  Future<void> getHositalInfo() async {
    try{
      final response = await http.post("http://$urlL/blood/getDonorInfo.php",
          //  headers: {'Content-Type',' application/json'},
          //  encoding: Encoding.getByName("utf-8"),
          body: {
            "id": _h['id'],
          });
      //print(response.body); json.decode(utf8.decode(response.bodyBytes));
      var datauser = json.decode(utf8.decode(response.bodyBytes));
    //  print(datauser);
      _h['id'] = datauser['id'];
      _h['hName'] = datauser['name'];
      _h['license'] = datauser['license'];
      _h['phone'] = datauser['phone'];
      _h['city'] = datauser['city'];
      _h['pwd'] = datauser['pwd'];

      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<String> updateUserInfo(
      String id,
      String name,
      String sfz,
      String birthday,
      String sex,
      String phone,
      String bloodtype,
      String city,
      String pwd,
      )
  async {
    var data;
    try{
      final response = await http.post("http://$urlL/blood/edit_donorInfo.php",
          //  headers: {'Content-Type',' application/json'},
          //  encoding: Encoding.getByName("utf-8"),
          body: {
            "id": id,
            "name": name,
            "sfz": sfz,
            "birthday": birthday,
            "sex": sex,
            "phone":phone,
            "bloodtype":bloodtype,
            "city": city,
            "pwd": pwd,
          });
      //print(response.body); json.decode(utf8.decode(response.bodyBytes));
      data = json.decode(response.body) as Map<String, dynamic>;

      _d['dName'] = name;
      _d['sfz'] = sfz;
      _d['birthday'] = birthday;
      _d['sex'] = sex;
      _d['bloodtype'] = bloodtype;
      _d['phone'] = phone;
      _d['city'] = city;
      _d['pwd'] = pwd;
      notifyListeners();
      return(data['code']);
    }catch(error){
      throw error;
    }
  }


  Future<String> updateHospitalInfo(
      String id,
      String name,
      String phone,
      String city,
      String pwd,
      )
  async {
    var data;
    try{
      final response = await http.post("http://$urlL/blood/edit_hospitalInfo.php",
          //  headers: {'Content-Type',' application/json'},
          //  encoding: Encoding.getByName("utf-8"),
          body: {
            "id": id,
            "name": name,
            "phone":phone,
            "city": city,
            "pwd": pwd,
          });
      //print(response.body); json.decode(utf8.decode(response.bodyBytes));
      data = json.decode(response.body) as Map<String, dynamic>;
      _h['hName'] = name;
      _h['phone'] = phone;
      _h['city'] = city;
      _h['pwd'] = pwd;
      notifyListeners();
      return(data['code']);
    }catch(error){
      throw error;
    }
  }

  Future<String> deleteDonorAccount(String sfz) async {
      final response = await http.post(
          "http://$urlL/blood/delete_donorAccount.php",
          body: {
            "sfz": sfz,
          });
      if(response.statusCode==200){
        print("deletion successful");
        notifyListeners();
        return "账号删除成功";
      }else{
        print("deletion failed");
        return "账号删除失败";
      }
  }
  Future<String> deleteHospitalAccount(String license) async {
    final response = await http.post(
        "http://$urlL/blood/delete_hospitalAccount.php",
        body: {
          "license": license,
        });
    if(response.statusCode==200){
      print("deletion successful");
      notifyListeners();
      return "账号删除成功";
    }else{
      print("deletion failed");
      return "账号删除失败";
    }
  }
  /*
  Future<List> login(bool hospital, bool donor, String phone,
      String pwd) async {
    if(hospital) {
      final response = await http.post(
          "http://192.168.1.102:8080/blood/login_hospital.php",
          body: {
            "phone": phone,
            "pwd": pwd,
          });
      print(response.body);
      var datauser = json.decode(response.body);
      print(datauser);
      if (datauser.length == null) {

      }
      else {
        HospitalInfo hospitalInfo = new HospitalInfo(
          id: datauser['id'],
          hName: datauser['name'],
          license: datauser['license'],
          phone: datauser['phone'],
          city: datauser['city'],
          pwd: datauser['pwd'],
        );
        Navigator.pushNamed(ctx, HospitalHomepageScreen.routeName);
      }
      return datauser;
    }

    if (donor) {
      final response = await http.post(
          "http://192.168.1.102:8080/blood/login_donor.php",
          body: {
            "phone": phone,
            "pwd": pwd,
          });
      print(response.body);
      // Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
      // print(map);
      var datauser = json.decode(response.body);
      if (datauser.length == null) {

      }
      else {
        DonorInfo donorInfo = new DonorInfo(
          id: datauser['id'],
          dName: datauser['name'],
          sfz: datauser['license'],
          phone: datauser['phone'],
          city: datauser['city'],
          pwd: datauser['pwd'],
        );
        Navigator.pushNamed(ctx, DonorHomepageScreen.routeName);
      }
      return datauser;
    }
  }*/
}