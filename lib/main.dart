import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prueba_flutter_1/src/models/user.dart';
import 'package:prueba_flutter_1/src/pages/client/products/list/client_products_list_page.dart';
import 'package:prueba_flutter_1/src/pages/client/products/profile/info/client_profile_info_controller.dart';
import 'package:prueba_flutter_1/src/pages/client/products/profile/info/client_profile_info_page.dart';
import 'package:prueba_flutter_1/src/pages/client/products/profile/update/client_profile_update_page.dart';
import 'package:prueba_flutter_1/src/pages/employee/car/product/employee_car_product_page.dart';
import 'package:prueba_flutter_1/src/pages/home/home_page.dart';
import 'package:prueba_flutter_1/src/pages/login/login_page.dart';
import 'package:prueba_flutter_1/src/pages/register/register_page.dart';
import 'package:prueba_flutter_1/src/pages/roles/roles_page.dart';

User userSession = User.fromJson(GetStorage().read('user')?? {});


void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color rgbColor= Color.fromRGBO(66, 134, 160, 1.0);
    Color rgbColor2= Color.fromRGBO(91, 116, 143, 1.0);
    return GetMaterialApp(
      title: 'Delevery udemy',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id !=null ? userSession.roles!.length > 1 ? 'roles' :'/client/products/list' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/employee/car/product', page: () => EmployeeCarProductPage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListpage()),
        GetPage(name: '/client/profile/info', page: () => ClientProfileInforPaga()),
        GetPage(name: '/client/profile/update', page: () => ClientProfileUpdatePage()),

      ],
      theme: ThemeData(
        primaryColor: rgbColor,
        colorScheme: ColorScheme(
          primary: rgbColor,
          secondary: rgbColor,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          onSecondary: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          background: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
