import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/db-models/image_upload_model.dart';
import '../utils/constants/urls.dart';

class ImageUploadApi {
  static Future<ImageUploadModel?> uploadImage(String imagePath) async {
    var headers = {'Content-type': 'multipart/form-data'};

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${baseUrl}image/upload'));
      request.files.add(await http.MultipartFile.fromPath('myFile', imagePath));
      request.headers.addAll(headers);
      print('image uploading');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var json = jsonDecode(data);
        ImageUploadModel uploadModel = ImageUploadModel.fromJson(json);

        print('image uploaded: $uploadModel');
        return uploadModel;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (error) {
      print('Error upload image: $error');
      return null;
    }
  }
}
