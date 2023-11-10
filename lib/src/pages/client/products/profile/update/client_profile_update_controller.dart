import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba_flutter_1/src/models/response_api.dart';
import 'package:prueba_flutter_1/src/models/user.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../../providers/user_providers.dart';
import '../info/client_profile_info_controller.dart';

class ClientProfileUpdateController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});


  TextEditingController nameController= TextEditingController();
  TextEditingController lastnameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();

  UserProvider userProvider = UserProvider();
  ClientProfileInforController clientProfileInforController= Get.find();

  ImagePicker picker = ImagePicker();
  File? imageFile;


  ClientProfileUpdateController (){
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }


  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }



  bool isValidForm(
      String name,
      String lastname,
      String phone,
      ){




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


    return true;

  }

  void updateInfo(BuildContext context) async {

    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;

    if (isValidForm(name, lastname, phone)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos...');


      //print('user.id: ${user.id}');
      print(GetStorage().read('user'));


      User myUser = User(
          id: user.id,
          name: name,
          lastname: lastname,
          phone: phone,
          sessionToken: user.sessionToken,



      );

      if (imageFile == null) {
        ResponseApi responseApi = await userProvider.update(myUser);
        print('Response Api Update: ${responseApi.data}');
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        progressDialog.close();
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
         // GetStorage().write('user', responseApi.data);
          clientProfileInforController.user.value = User.fromJson(GetStorage().read('user') ?? {});
        }
      }
      else {
        Stream stream = await userProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {
          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          Get.snackbar('Proceso terminado', responseApi.message ?? '');
          print('Response Api Update: ${responseApi.data}');
          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data);
            clientProfileInforController.user.value = User.fromJson(GetStorage().read('user') ?? {});
          }
          else {
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }
        });
      }
    }
  }


      void shoAlertDialog(BuildContext context) {
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
        showDialog(context: context, builder: (BuildContext context) {
          return alertDialog;
        });
      }

}