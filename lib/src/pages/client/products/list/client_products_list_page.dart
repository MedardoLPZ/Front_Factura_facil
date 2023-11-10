import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_1/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:prueba_flutter_1/src/pages/employee/car/product/employee_car_product_page.dart';
import 'package:prueba_flutter_1/src/pages/register/register_page.dart';
import 'package:prueba_flutter_1/src/utils/custom_animated_bottom_bar.dart';

import '../../../home/home_page.dart';
import '../profile/info/client_profile_info_page.dart';



class ClientProductsListpage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonBar(),
      body: Obx (() =>  IndexedStack(
        index: con.indexTab.value,
        children: [
          EmployeeCarProductPage(),
          HomePage(),
          ClientProfileInforPaga(),
        ] ,
      )
      )
    );
  }

  Widget _buttonBar(){
    Color rgbColor= Color.fromRGBO(84, 140, 167, 1.0);
    return  Obx(() =>  CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor: rgbColor,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        selectedIndex: con.indexTab.value,
        onItemSelected: (index) => con.chageTab(index),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
              title: Text('Home'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Mis compras'),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),

        ],
    ));// onItemSelected: onItemSelected);
  }
}
