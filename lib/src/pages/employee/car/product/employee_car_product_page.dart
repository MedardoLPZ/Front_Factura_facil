import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_1/src/pages/employee/car/product/employee_car_product_controller.dart';

class  EmployeeCarProductPage extends StatelessWidget {

  EmployeeCarProductController con = Get.put(EmployeeCarProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Empleado Page Principal'),
      ),
    );
  }
}
