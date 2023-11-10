
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'client_profile_info_controller.dart';

class ClientProfileInforPaga extends StatelessWidget{

  ClientProfileInforController con = Get.put(ClientProfileInforController());



  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      body:  Stack(// posicionar elementos uno encima del otro
        children: [
          _backgroundcover(context),
          _boxForm(context),
          _imgUser(context),
          _buttonsignOut(),

        ],
      )),
    );
  }
  Widget _backgroundcover(BuildContext context){
    Color rgbColor= Color.fromRGBO(84, 140, 167, 1.0);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: rgbColor,
      alignment: Alignment.topCenter,
    );
  }
  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textname(),
            _textemail(),
            _textPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }



  Widget _textname(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''}'),
        subtitle: Text('name and lastname') ,
      ),
    );

  }


  Widget _textemail(){
    return ListTile(
        leading: Icon(Icons.email),
        title: Text(con.user.value.email ?? ''),
        subtitle: Text('email') ,
      );

  }

  Widget _textPhone(){
    return ListTile(
        leading: Icon(Icons.phone),
        title: Text(con.user.value.phone ?? ''),
        subtitle: Text('phone') ,
      );

  }

  Widget _textid(){
    return ListTile(
      leading: Icon(Icons.access_alarm),
      title: Text(con.user.value.id ?? ''),
      subtitle: Text('phone') ,
    );

  }

  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: ()=> con.goToProfileUpdate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR LOS DATOS',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }


  Widget _buttonsignOut(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () => con.signOut(),
          icon: Icon(Icons.power_settings_new,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }



  Widget _imgUser(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: con.user.value.image != null
              ? NetworkImage(con.user.value.image!)
              : AssetImage('assets/img/user_profile.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),
    );


  }



}