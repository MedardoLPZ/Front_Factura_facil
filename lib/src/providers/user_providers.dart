import 'dart:io';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_1/main.dart';
import 'package:prueba_flutter_1/src/environment/environment.dart';
import 'package:prueba_flutter_1/src/models/response_api.dart';
import 'package:prueba_flutter_1/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends GetConnect{

  String url = Environment.Api_URl + 'api/users';
  
  User userSsion = User.fromJson(GetStorage().read('user') ?? {});

Future<Response> create(User user) async{
  Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {
        'Content-Type': 'application/json'

  });
  return response;
}

  Future<ResponseApi> update(User user) async{
    Response response = await put(
        '$url/updateWithoutImage',
        json.encode(user.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'authorization': userSession.sessionToken ?? ''

        }
        );

    if(response.body == null){
      Get.snackbar('Error', 'No se pudo actulizar la informacion');
      return ResponseApi();
    }

    if(response.statusCode ==401){
      Get.snackbar('Error', 'No esta autoirzado para realizar esta petecion');

    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;

  }


  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.Api_URl_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.headers['authorization'] = userSession.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.Api_URl_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async{
    Response response = await post(
        "$url/login",
        {
          'email': email,
          'password': password,
        },
        headers: {
      'Content-Type': 'application/json'
    });

    if(response.body == null){
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }



}