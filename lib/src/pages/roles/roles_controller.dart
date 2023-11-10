import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:prueba_flutter_1/src/models/Rol.dart';
import 'package:prueba_flutter_1/src/models/user.dart';


class RolesController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});

  void goToPagaRol(Rol rol){
    Get.offNamedUntil(rol.route?? '', (route) => false);
  }


}