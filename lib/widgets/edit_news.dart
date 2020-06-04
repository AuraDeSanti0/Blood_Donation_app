import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import '../providers/auth.dart';
import '../providers/news.dart';
import 'package:provider/provider.dart';
import '../models/db_url.dart';
class EditNews extends StatefulWidget {

  String n_id;
  EditNews(this.n_id);
  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  bool oldImageIsNull = false;
  bool newImageChosen = false;
  File file;
  String urlL = url;
  String hName, license;
  File _image;
  String uploadStatus;
  final _editForm = GlobalKey<FormState>();

 static  var _editedNewsItem = NewsItem(
    n_id:null,
    hName:'',
    license: '',
    date: '',
    msg: '',
    imageUrl: ''
  );
  var _initValues ={
    'msg': '',
  };

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      _image = file;
      newImageChosen = true;
    });
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());


    Img.Image smallerImg = Img.copyResize(image, width: 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(image,));

    setState((){
      _image = imageFile;
      newImageChosen = true;
    });
  }
  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());

    Img.Image smallerImg = Img.copyResize(image, width: 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState((){
      _image = compressImg;
      newImageChosen = true;
    });
  }
  Future<void> dialogText(String msg) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //user must tap the btn
        builder: (ctx) => AlertDialog(
          title: Text('信息'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('OK', style: TextStyle(color: Colors.black87)),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _saveForm(File im) async {
    String response =" ";
    final isValid = _editForm.currentState.validate(); //to initialize validation
    if(!isValid){
      return ;
    }
    _editForm.currentState.save();

    if(_editedNewsItem.n_id != null){
     response = await Provider.of<News>(context, listen:false)
          .updateNewsItem(_editedNewsItem.n_id, _editedNewsItem.msg, im);

    }else {
      try {
        await Provider.of<News>(context, listen: false)
            .addNews(im, _editedNewsItem.hName, _editedNewsItem.license, _editedNewsItem.msg );
      } catch (error) {
        dialogText(error);
      }
    }
    Navigator.of(context).pop();
    dialogText(response);
  }

  @override
  Widget build(BuildContext context) {
    final newsId = widget.n_id;
    _editedNewsItem = Provider.of<News>(context,listen:false).findById(newsId);
    if(_editedNewsItem.imageUrl != null){
      oldImageIsNull = false;
    }
    else{
      oldImageIsNull = true;
    }

    _initValues = {
      'msg': _editedNewsItem.msg,
    };

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
                    key: _editForm,
                    child:  TextFormField(
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: '消息',
                      ),
                     initialValue: _initValues['msg'],
                      validator: (value){
                        if(value.isEmpty){
                          return '请输入您的消息';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _editedNewsItem = NewsItem( //cause values in Product are immutable i.e. final, have to create new Product each time
                          //and add value inputed to the formField
                          n_id: _editedNewsItem.n_id,
                          hName: _editedNewsItem.hName,
                          license: _editedNewsItem.license,
                          date: _editedNewsItem.date,
                          msg: value,
                          imageUrl:  _editedNewsItem.imageUrl,
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    // alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.5,
                    //  child:FittedBox(
                    child:
                       forIM()
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
                      onPressed: _choose,
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
                      _saveForm(newImageChosen ? _image : null );
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
  Widget forIM(){
    if(oldImageIsNull == true && newImageChosen ==false){
      return Text("还没选择照片");
    }
    if(oldImageIsNull == false && newImageChosen == false){
      return Image.network(_editedNewsItem.imageUrl);
    }
    if(newImageChosen == true){
      return Image.file(_image);
    }
  }
}
