import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import '../providers/auth.dart';
import '../providers/news.dart';
import 'package:provider/provider.dart';
import '../models/db_url.dart';

class AddNewsIt extends StatefulWidget {

  @override
  _AddNewsItState createState() => _AddNewsItState();
}

class _AddNewsItState extends State<AddNewsIt> {
  bool imageChosen = false;
  String urlL = url;
  String hName, license;
  File _image;
  String uploadStatus;
  final _addForm = GlobalKey<FormState>();
  final _msgController = TextEditingController();

  Future<void> dialogText(String msg) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //user must tap the btn
        builder: (ctx) => AlertDialog(
          title: Text('信息'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  File file;

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      _image = file;
      imageChosen = true;
    });
  }

  Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,imageQuality: 30);
/*
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);
    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(image));
    //print(path);

    File compressedImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      imageFile.path,
      quality: 10,
    );

    */
  setState((){
      _image = imageFile;
      imageChosen = true;
    });
  }
  compressImageFile(){

  }
  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera,imageQuality: 30);
    /*
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);
    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(im+++++++++++++++++++++++++++++++++++++++age, width: 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(image));
   // print(path);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      croppedFile.path,
      quality: 50,
    );
*/
    setState((){
      _image = imageFile;
      imageChosen = true;
    });
  }

 /*
Future upload(File imageFile) async{
    var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length= await imageFile.length();
    var uri = Uri.parse("http://$urlL/blood/add_news.php");

    var request = new http.MultipartRequest("POST", uri);

    var  bname = Bname(imageFile);
    var multipartFile = new http.MultipartFile("image", stream, length, filename: bname);
    request.fields['n_id'] = DateTime.now().toIso8601String();
    request.fields['hName'] = hName;
    request.fields['license'] = license;
    request.fields['date'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    request.fields['msg'] = _msgController.text;
    request.files.add(multipartFile);

   var response = await request.send();

    if(response.statusCode==200){
      print("Image Uploaded");
      uploadStatus = "消息提交成功";
    }else{
      print("Upload Failed");//献血圈测试1： 你好！
      uploadStatus = "消息提交失败";

    }
   response.stream.transform(utf8.decoder).listen((value) {
    print(value);
   });


    Navigator.of(context).pop();
    dialogText(uploadStatus);
  }

 */
 Future<void> _submitData(File im) async {
    String result;
    final isValid = _addForm.currentState.validate();
    if(!isValid){
      return;
    }
    _addForm.currentState.save();
    String msg = "";
      result =  await Provider.of<News>(context,listen: false).addNews(im, hName, license, _msgController.text);
      setState(() {});
      msg  = result;
      Navigator.of(context).pop();
      dialogText(msg);
      //print(msg);

  }

  @override
  Widget build(BuildContext context) {
    var h = Provider.of<Auth>(context, listen: true).getHInfo();
    hName = h['hName'];
    license = h['license'];
    return  SingleChildScrollView(
      child: Card(
          elevation: 10,
          color: Color.fromRGBO(250,250,240, 1),
          child: Container(
            padding: EdgeInsets.only(
              top: 0,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only( left: 12.0, right: 12),
                  child: Form(
                    key: _addForm,
                    child:  TextFormField(
                      //maxLines: 2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: '消息',
                      ),
                      controller: _msgController,
                      validator: (value){
                        if(value.isEmpty){
                          return '请输入您的消息';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Center(
                  child: Container(
                   // alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.5,
                    //  child:FittedBox(
                        child: _image==null
                            ? new Text("还没上传照片")
                            : new Image.file(_image),

                   // ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 1, //width of the border
                      ),
                      color: Colors.grey, //Theme.of(context).accentColor,
                      child: Text('选择照片'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      onPressed: getImageGallery,
                    ),
                    OutlineButton(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 1, //width of the border
                      ),
                      child: Text('拍个照'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: getImageCamera,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('提交', style: TextStyle(color: Colors.white,),),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: (){
                      _submitData(_image);
                      //up();
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}