import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../screens/HAccountInfoScreen.dart';

class HospitalDrawer extends StatelessWidget {
  String name, license;
  HospitalDrawer(this.name, this.license);
  Widget buildListTile(String title, IconData icon, Function tapHandler){
    return ListTile(
      leading: Icon(icon, size: 26,),
      title: Text(title, style: TextStyle(
        fontWeight: FontWeight.bold,
      ),),
      onTap: tapHandler,
    );
  }
  @override
  Widget build(BuildContext context) {
    Future<void> dialogText(String msg) async{
      return showDialog<void>(
          context: context,
          barrierDismissible: false, //user must tap the btn
          builder: (ctx) => AlertDialog(
            title: Text('信息'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              )
            ],
          )
      );
    }


    Future<void> _submitData() async {
     final response =  await Provider.of<Auth>(context,listen: false).deleteHospitalAccount(license);
      dialogText(response);
      Navigator.of(context).pop();
      Navigator.pushNamedAndRemoveUntil(context, Navigator.defaultRouteName, (_) => false);
      //print(msg);
    }

    void _deleteDialog(){
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('信息'),
            content: Text('您确定想删除吗？'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消',style: TextStyle(color: Colors.black)),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text('确定',style: TextStyle(color: Colors.black)),
                onPressed: (){
                  _submitData();
                },
              )
            ],
          )
      );
    }
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.bottomLeft,
            color: Color.fromRGBO(254, 152, 35, 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/loyalty.png')),
                ),
                SizedBox(height: 30,),
                Text(name, style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.black87,
                ),),
              ],
            ),
          ),
          SizedBox(height: 30,),
          buildListTile(
              '修改账号信息',
              Icons.person_pin,
                  (){
                Navigator.of(context).pushNamed(HAccountnfoScreen.routeName);
              }
          ),
          Divider(),
          buildListTile(
              '删除账号',
              Icons.delete_forever,
                  (){
                _deleteDialog();
              }),
          Divider(),
          buildListTile(
              '退出',
              Icons.exit_to_app,
                  (){
                //Navigator.of(context).pushReplacementNamed(Navigator.defaultRouteName);
                Navigator.pushNamedAndRemoveUntil(context, Navigator.defaultRouteName, (_) => false);
              }),
        ],
      ),
    );
  }
}
