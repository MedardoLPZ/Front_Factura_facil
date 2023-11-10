import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_1/src/pages/client/products/profile/update/client_profile_update_controller.dart';

import '../../../../../providers/user_providers.dart';

class ClientProfileUpdatePage extends StatelessWidget {

  ClientProfileUpdateController con = Get.put(ClientProfileUpdateController());



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(// posicionar elementos uno encima del otro
        children: [
          _backgroundcover(context),
          _boxForm(context),
          _imgUser(context),
          _buttonBack(),

        ],
      ),
    );
  }
  Widget _buttonBack(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
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
      height: MediaQuery.of(context).size.height * 0.45,
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
            _textYourInfo(),
            _textFielName(),
            _textFielLastName(),
            _textFiePhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'INGRESA ESTA INFORMACION',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textFielName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre',
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }
  Widget _textFielLastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellido',
            prefixIcon: Icon(Icons.person_outline)
        ),
      ),
    );
  }
  Widget _textFiePhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }



  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.updateInfo(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _imgUser(BuildContext context){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () => con.shoAlertDialog(context),
            child: GetBuilder <ClientProfileUpdateController> (
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : con.user.image != null
                  ? NetworkImage(con.user.image!)
                : AssetImage('assets/img/user_profile.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            )
        ),
      ),
    );

  }

}
