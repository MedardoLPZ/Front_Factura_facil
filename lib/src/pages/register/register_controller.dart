import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba_flutter_1/src/models/response_api.dart';
import 'package:prueba_flutter_1/src/models/user.dart';
import 'package:prueba_flutter_1/src/providers/user_providers.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController lastnameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();


  UserProvider userProvider = UserProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;



  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmpassword = confirmpasswordController.text.trim();




    print('Email ${email}' );
    print('password ${password}' );

    if(isValidForm (email,name,lastname,phone, password,confirmpassword)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando Datos...');

      User user = User(email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          password: password,
      );
      
      Stream stream = await userProvider.createWithImage(user, imageFile!);
      stream.listen((res) {

        progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if(responseApi.success == true){
          GetStorage().write('user', responseApi.data);
          goToHomePage();
        }
        else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }

      });

    }

  }
  void goToHomePage(){
    Get.offNamedUntil('/client/products/list', (route) => false);

  }

  bool isValidForm(String email,
      String name,
      String lastname,
      String phone,
      String password,
      String confirmpassword ){

    if (email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }
    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }
    if (name.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el nombre');
      return false;
    }
    if (lastname.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el apeliido');
      return false;
    }
    if (phone.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el telefono');
      return false;
    }

    if (password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }
    if (confirmpassword.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar la confirmacion de la contraseña');
      return false;
    }

    if(password != confirmpassword){
      Get.snackbar('Formulario no valido', 'Las contraseñas no coinciden');
      return false;
    }
    if(imageFile == null){
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imafen de perfil');
      return false;
    }

    return true;

  }
  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){
      imageFile = File(image.path);
      update();
    }

  }



  void shoAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
            'Galeria',
          style: TextStyle(
            color: Colors.black
          ),
        )
    );

      Widget cameraButton = ElevatedButton(
          onPressed: () {
            Get.back();
            selectImage(ImageSource.camera);
          },
          child: Text(
              'Camara',
            style: TextStyle(
                color: Colors.black
              ),
          )
      );
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
    
  }



}