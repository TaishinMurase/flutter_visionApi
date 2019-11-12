import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class Api {
  // path of input image.
  final File inputImage;
  String base64Image;

  Api({
    @required this.inputImage
  }) : assert(inputImage != null);

  Future<String> postVision() async {
    // image to base64
    List imageList = inputImage.readAsBytesSync();
    base64Image = base64Encode(imageList);

    // API url and key
    // Input your Api key
    String url = "https://vision.googleapis.com/v1/images:annotate";
    final key = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
    String url_key = url + '?key=' + key;

    // header
    Map<String, String> headers = {'content-type': 'application/json'};

    // body
    var body = json.encode(
      {
        "requests":[
          {
            "image":{
              "content": base64Image
            },
            "features": [
              {
                "type":"LABEL_DETECTION",
                "maxResults":1
              }
            ]
          }
        ]
    }
  );

    http.Response resp = await http.post(url_key, headers: headers, body: body);
    final result = jsonDecode(resp.body)["responses"][0]["labelAnnotations"][0]["description"];

    return result.toString();
  }

}