import 'package:flutter/material.dart';

class AddNewsScard extends StatefulWidget {
  static const routeName = '/add_news';
  @override
  _AddNewsScardState createState() => _AddNewsScardState();
}

class _AddNewsScardState extends State<AddNewsScard> {
  TextEditingController msg = TextEditingController();

  bool pressed = false;
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    if(pressed){
      this._overlayEntry = this.createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
    } else {
      this._overlayEntry.remove();
    }
  }
  OverlayEntry createOverlayEntry() {
    final LayerLink _layerLink = LayerLink();
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, //MediaQuery.of(context).size.height /2.0,
        right: 30.0,
        child: CompositedTransformFollower(
          link: this._layerLink,
          child:Container(
            height: 400,
            width: 300,
            child: Card(
              child: Column(children: <Widget>[
                Form(
                  child: TextFormField(
                    // controller: msg,
                    decoration: InputDecoration(
                      // labelStyle: TextStyle(color: Colors.red),
                        labelText: 'your message'),
                  ),
                ),
                Container(
                  height: 120,
                  width: 200,
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('choose image'),
                      onPressed: (){},
                    ),
                    RaisedButton(
                      child: Text('take a photo'),
                      onPressed: (){},
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('tijiao'),
                  onPressed: (){},
                )
              ],),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: IconButton(
        icon: Icon(Icons.add),
        onPressed: (){
          //  pressed =true;
        },
      ),
    );
  }
}