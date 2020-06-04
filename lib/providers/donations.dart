import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/db_url.dart';
class Donation{
  final String d_id;
  final String hName;
  final String license;
  final String dName;
   String sfz;
  final String bloodtype;
   String date;

  Donation({
    @required this.d_id,
    @required this.hName,
    @required this.license,
    @required this.sfz,
    @required this.dName,
    @required this.bloodtype,
    @required this.date,
  });
}

class Donations with ChangeNotifier{
  String urlL = url;
  List<Donation> _items = [
   /* Donation(
      d_id: 'w1',
      license: 'h1h1',
      hName: 'Hospital1',
      sfz: 'd1d1',
      dName: 'Donor1',
      bloodtype: 'A+',
      date: DateTime.now().toIso8601String(),
    ),
    Donation(
      d_id: 'w2',
      license: 'h2h2',
      hName: 'Hospital2',
      sfz: 'd1d1',
      dName: 'Donor1',
      bloodtype: 'A+',
      date: DateTime.now().toIso8601String(),
    ),*/
  ];

  Map<String, String> _hospitalInfo;
  Map<String, String> _donorInfo;
  Donations(this._hospitalInfo, this._donorInfo, this._items);

  Map<String, String> get hospitalInfo{
    return _hospitalInfo;
  }

  Map<String, String> get donorInfo{
    return _donorInfo;
  }

  Map<String, String> getHInfo(){
    return hospitalInfo;
  }

  Map<String, String> getDInfo(){
    return donorInfo;
  }

  List <Donation> get items {
   //makes a copy of list in order not to alter _users directly
    return [..._items]; //with that we can call notifyListeners()
  }

  Donation findById(String id){
    return _items.firstWhere((don)=>don.d_id == id);
  }

  Future<void> fetchAndSetDonations() async {
    //print(_items[0].date);
    print(donorInfo);
    //print(hospitalInfo['license']);
    final url = 'http://$urlL/blood/donations.php';
    try {
      final response = await http.post(
          url,
          body: {
            "sfz": donorInfo['sfz'],
          });
      final extractedData = json.decode(response.body) ;
      //print(extractedData);
      final List<Donation> loadedDonations = [];
      extractedData.forEach((donData) {
        loadedDonations.add(Donation(
            d_id: donData['d_id'],
            hName: donData['hName'],
            license: donData['license'],
            dName: donData['dName'],
            sfz: donData['sfz'],
            bloodtype: donData['bloodtype'],
            date: donData['date']
        ));
      });
    //  print(loadedDonations);
      _items = loadedDonations;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }


   lastDate(){
    if(_items.length ==0 ){
     // print('no don history');
      return DateTime.utc(1900,01,01);
    }
    else{
      var d = _items[0].date;
      //print(d);
      return DateTime.parse(d);
    }
  }


  Future<void> hospitalFetchAndSetDonations() async {
    //print(_items2);
    //print(donorInfo['sfz']);
    //print(hospitalInfo['hName']);
    final url = 'http://$urlL/blood/hospital_donations.php';
    try {
      final response = await http.post(
          url,
          body: {
            "license": hospitalInfo['license'],
          });
      final extractedData = json.decode(response.body) ;
     // print(extractedData);
      final List<Donation> loadedDonations = [];
      extractedData.forEach((donData) {
        loadedDonations.add(Donation(
            d_id: donData['d_id'],
            hName: donData['hName'],
            license: donData['license'],
            dName: donData['dName'],
            sfz: donData['sfz'],
            bloodtype: donData['bloodtype'],
            date: donData['date']
        ));
      });
      //print(loadedDonations);
      _items = loadedDonations;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  Future<String> addDonation(String sfz, String date) async{
    var data;
    String d_id = DateTime.now().toIso8601String();
    print(d_id + date + sfz);
    final url = 'http://$urlL/blood/add_donation.php';
    try{
      final response = await http.post(
        url,
        body: {
        'd_id': d_id,
        'license': hospitalInfo['license'],
        'sfz': sfz,
        'date': date,
      }
      );
      data = json.decode(response.body) as Map<String, dynamic>;
      /*
      final newDonation = Donation(
        d_id: d_id,
        hName: hospitalInfo['hName'],
        license: hospitalInfo['license'],
        date: date,
        sfz: sfz,
      );
      _items.add(newDonation);
       */
      notifyListeners();
      return(data['code']);
    }
    catch(error){
      print(error);
      throw error;
    }
  }

  Future<String> updateDonation(String d_id, String sfz, String date)async{
    var data;
    final donIndex = _items.indexWhere((don)=> don.d_id == d_id);
   // print(donIndex);
    if(donIndex != null){
      final url = 'http://$urlL/blood/edit_donation.php';
      final response = await http.post(//patch method merges new data with the existing data in the db
          url,
          body: {
            'd_id': d_id,
            'sfz': sfz,
            'date': date,
          }
      );
      data = json.decode(response.body) as Map<String, dynamic>;
      _items[donIndex].sfz = sfz;
      _items[donIndex].date = date ;
      notifyListeners();
      return(data['code']);
    }else{
      print('....');
    }
  }

  Future<String> deleteDonation(String d_id)async {
    var data;
    final url = 'http://$urlL/blood/delete_donation.php';
    final existingDonationIndex = _items.indexWhere((don)=>don.d_id == d_id);
    print(existingDonationIndex); //gives the index of product we want to remove
    var existingDonation = _items[existingDonationIndex];

    final response = await http.post(//patch method merges new data with the existing data in the db
        url,
        body: {
          'd_id': d_id,
        }
    );
    data = json.decode(response.body) as Map<String, dynamic>;
    _items.removeAt(existingDonationIndex);
    notifyListeners();
    return(data['code']);

  }

}