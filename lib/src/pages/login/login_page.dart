import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_1/src/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {

  LoginController con = Get.put(LoginController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack(// posicionar elementos uno encima del otro
        children: [
          _backgroundcover(context),
          _boxForm(context),
          Column(//Posicionar elementos unos debajao del otro debajo del otro
            children: [
              _imageCover(),
            ],
          )
        ],
      ),
    );
  }

  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
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
            _textFieldEmail(),
            _textFielpassword(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo electronico',
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }
  Widget _textFielpassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }
  Widget _buttonLogin(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.login(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 45),
      child: Text(
        'INGRESA ESTA INFORMACION',
            style: TextStyle(
          color: Colors.black,
      ),
      ),
    );
  }


  Widget _backgroundcover(BuildContext context){
    Color rgbColor= Color.fromRGBO(84, 140, 167, 1.0);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: rgbColor,
      alignment: Alignment.topCenter,
    );
  }

  Widget _textAppName(){
    return Text(
      '',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _textDontHaveAccount(){
    Color rgbColor= Color.fromRGBO(84, 140, 167, 1.0);
    return Row( //ubicar elementos uno al lado del otro (de manera horizontal
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'No tienes cuenta?',
          style: TextStyle(
            color: Colors.black
          ),
         ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: () => con.goToRegisterPage() ,
          child: Text(
              'Registrate Aqui',
            style: TextStyle(
              color: rgbColor,
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
          ),
        ),
      ],
    );
  }


  //privado
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 35, bottom: 15),
        alignment: Alignment.center,
        child: Image.asset(
            'assets/img/LogoF.png',
          width: 170,
          height: 170,
        ),
      ),
    );

  }

}
