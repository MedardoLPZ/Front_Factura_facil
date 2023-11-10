import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prueba_flutter_1/src/models/user.dart';

class HomeController extends GetxController{
  
  User user = User.fromJson(GetStorage().read('user') ?? {});
  
  HomeController(){
    print('Usuario de sision: ${user.toJson()}');
  }

  void   signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('./', (route) => false);
  }


}