
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prueba_flutter_1/src/models/user.dart';

class ClientProfileInforController extends GetxController{

var user = User.fromJson(GetStorage().read('user') ?? {}).obs;

// User user = User.fromJson(GetStorage().read('user') ?? {}).obs;

void   signOut(){
  GetStorage().remove('user');
  Get.offNamedUntil('./', (route) => false);
}
void goToProfileUpdate(){
  Get.toNamed('/client/profile/update');
}

}