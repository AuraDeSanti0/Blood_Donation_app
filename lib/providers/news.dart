import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/db_url.dart';
import 'package:async/async.dart';
import '../models/db_url.dart';
class NewsItem{
//  final String id;
  final String n_id;
  final String hName;
  final String license;
  final String date;
  final String msg;
   String imageUrl;
  // var imageUrl;

  NewsItem({
 //   @required this.id,
    @required this.n_id,
    @required this.hName,
    @required this.license,
    @required this.date,
    @required this.msg,
    this.imageUrl,
  });
}

class AllNewsItem{
//  final String id;
  final String n_id;
  final String hName;
  final String date;
  final String msg;
  String imageUrl;
  // var imageUrl;

  AllNewsItem({
    //@required this.id,
    @required this.n_id,
    @required this.hName,
    @required this.date,
    @required this.msg,
    this.imageUrl,
  });
}

class News with ChangeNotifier {
  String urlL = url;

  List<NewsItem> _news = [
    /*
    NewsItem(
      n_id: 'n1',
      hName: 'Hospital1',
      license: 'h1h1',
      date: DateTime.now(),
      msg: 'Thanks for your blood donationalkdsfjalksdjf;lakjfds;lkafjs;lkjf;alksdjf;lkasdjf;lkajds;fkj',
      imageUrl: 'https://www.yogajournal.com/.image/t_share/MTUxMDUxNDQ2NDQyMjcyNzA5/fearless.jpg',
    ),
    NewsItem(
      n_id: 'n2',
      hName: 'Hospital2',
      license: 'h2h2',
      date: DateTime.now(),
      msg: 'Thanks for your blood donation,'
          'Thanks for your blood donation,'
          'Thanks for your blood donation',
      imageUrl: 'https://c.pxhere.com/images/a8/34/933349fd4cd86c5b4b1982ffc6d0-1443763.jpg!d',
    ),
    NewsItem(
      n_id: 'n3',
      hName: 'Hospital1',
      license: 'h1h1',
      date: DateTime.now().toIso8601String(),
      msg: 'Thanks for your blood donationalkdsfjalksdjf;lakjfds;lkafjs;lkjf;alksdjf;lkasdjf;lkajds;fkj',
      imageUrl: 'https://images.unsplash.com/photo-1531843024904-83fb5d1c9b52?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9',
    ),

     */
  ];
  List<AllNewsItem> _allNews = [];

  Map<String, String> _hospitalInfo;
//  News(this._hospitalInfo, this._news);

  List <NewsItem> get news {
  //print(_news);//makes a copy of list in order not to alter _users directly
    return [..._news]; //with that we can call notifyListeners()
  }
  List<AllNewsItem> get allNews{
     return[..._allNews];
  }

  NewsItem findById(String n_id){
    NewsItem n = _news.firstWhere((don)=>don.n_id == n_id);
    //String imUrl = n.imageUrl;
   // if(imUrl != null){
    //  n.imageUrl = "http://$urlL/blood/uploads/$imUrl";
   // }
    return n;
  }

  Future<void>fetchNewsHospital(String license) async {
    final url = 'http://$urlL/blood/fetch_news.php';
    final response = await http.post(
        url,
        body: {
          'license': license,
        }
      );
    //print(response.body);
      final extractedData = json.decode(response.body) ;
      final List<NewsItem> loadedNews = [];

      extractedData.forEach((donData) {

       // var blob = donData['image'];
        //Uint8List image = base64.decode(blob);
        String p = donData['image'];
       // print(donData['image']);
        loadedNews.add(NewsItem(
            //id: donData['id'],
            n_id: donData['n_id'],
            hName: donData['name'],
            license: donData['license'],
            date: donData['date'],
            msg: donData['msg'],
            imageUrl: p.isEmpty ? null : "http://$urlL/blood/uploads/$p",// image //donData['image'],
        ));
      });
      _news = loadedNews;
      notifyListeners();
  }

  Future<void>fetchAllNews(String city) async {

    final url = 'http://$urlL/blood/fetch_all_news.php';
    final response = await http.post(
        url,
        body: {
          'city': city,
        }
    );

    final extractedData = json.decode(response.body) ;
    final List<AllNewsItem> loadedNews = [];

    extractedData.forEach((donData) {
      String p = donData['image'];
      loadedNews.add(AllNewsItem(
        //id: donData['id'],
        n_id: donData['n_id'],
        hName: donData['name'],
        date: donData['date'],
        msg: donData['msg'],
        imageUrl: p.isEmpty ? null : "http://$urlL/blood/uploads/$p",// image //donData['image'],
      ));
    });
    _allNews = loadedNews;
    notifyListeners();
  }


  Future <String> addNews(File imageFile, String hName, String license, String msg) async{
    String n_id = DateTime.now().toIso8601String();
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if(imageFile!= null) {
      var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length= await imageFile.length();
      var uri = Uri.parse("http://$urlL/blood/add_news.php");

      var request = new http.MultipartRequest("POST", uri);

      var  bname = Bname(imageFile);
      var multipartFile = new http.MultipartFile("image", stream, length, filename: bname);
      request.fields['n_id'] = n_id;
    //  request.fields['hName'] = hName;
      request.fields['license'] = license;
      request.fields['date'] = date;
      request.fields['msg'] = msg;
      request.files.add(multipartFile);

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      final newNewsItem = NewsItem(
        n_id: n_id,
        hName: hName,
        license: license,
        date: date,
        msg: msg,
        imageUrl: imageFile.path,
      );
      if(response.statusCode==200){
        _news.add(newNewsItem);
        notifyListeners();
        print("Image Uploaded");
        return "消息提交成功";

      }
      else{
        print("Upload Failed");//献血圈测试1： 你好！
        return "消息提交失败";

      }
    }
    else{
      final url = 'http://$urlL/blood/add_news_no_img.php';

      final response = await http.post(//patch method merges new data with the existing data in the db
          url,
          body: {
            'n_id': n_id,
            'license' : license,
            'date': date,
            'msg': msg,
          }
      );
      final newNewsItem = NewsItem(
        n_id: n_id,
        hName: hName,
        license: license,
        date: date,
        msg: msg,
      );
      notifyListeners();
      if(response.statusCode==200){
        print("Image Uploaded2");
        _news.add(newNewsItem);
        notifyListeners();
        return "消息提交成功";
      }else{
        print("Upload Failed2");//献血圈测试1： 你好！
        return "消息提交失败";
      }
    }
  }

  Future <String> updateNewsItem(String n_id, String msg, File imageFile) async{
    if(imageFile!= null){
      print(imageFile.path);
      var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length= await imageFile.length();
      var uri = Uri.parse("http://$urlL/blood/update_news_new_photo.php");

      var request = new http.MultipartRequest("POST", uri);

      var  bname = Bname(imageFile);
      var multipartFile = new http.MultipartFile("image", stream, length, filename: bname);
      request.fields['n_id'] = n_id;
      request.fields['msg'] = msg;
      request.files.add(multipartFile);

      var response = await request.send();
      notifyListeners();
      response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      });
      if(response.statusCode==200){
        print("Image Uploaded1");
        return "消息提交成功";
      }else{
        print("Upload Failed1");//献血圈测试1： 你好！
        return "消息提交失败";
           }
    }
    else{
          final url = 'http://$urlL/blood/update_news.php';
          final response = await http.post(//patch method merges new data with the existing data in the db
              url,
              body: {
                'n_id': n_id,
                'msg': msg,
              }
          );
          notifyListeners();
          if(response.statusCode==200){
            print("Image Uploaded2");
            return "消息提交成功";
          }else{
            print("Upload Failed2");//献血圈测试1： 你好！
            return "消息提交失败";
          }
        }
  }

  Future<String> deleteNewsItem(String n_id)async {
    final url = 'http://$urlL/blood/delete_news.php';
    final existingNewsIndex = _news.indexWhere((don)=>don.n_id == n_id); //gives the index of product we want to remove
    var existingNewsItem = _news[existingNewsIndex];

    final response = await http.post(
        url,
        body: {
          'n_id': n_id,
        }
    );
    notifyListeners();
    if(response.statusCode==200){
      _news.removeAt(existingNewsIndex);
      notifyListeners();
      print("Item deleted");
      return "删除成功";
    }else{
      print("deletion Failed2");
      return "删除失败";
    }

  }
}