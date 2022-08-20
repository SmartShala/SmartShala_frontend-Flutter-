import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadApi {
  Future<void> uploadImage(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access');
    var dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    String fileName = file.path.split('/').last;
    log("api");
    log(fileName);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
      "id": 1,
    });
    try {
      var response = await dio.post(
          "http://parikshana.smartshala.live/api/grader/17/",
          data: formData);
      log(response.toString());
    } on DioError catch (e) {
      if (e.response != null) {
        log(e.response.toString());
        //  log(e.response.headers);
        //  log(e.response.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        log(e.requestOptions.toString());
        log(e.message);
      }
    }
  }
}
