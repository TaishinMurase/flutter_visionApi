import 'dart:io';

import 'apiVision.dart';

import 'package:meta/meta.dart'; 
import 'package:flutter/material.dart'; 
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    @required this.title
    });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File imageFile;
  String imageResult;

  // Get an image from your folder or camera .
  void _getAndSaveImageFromDevice(ImageSource source) async {
    // Get imageFile path
    var imageFile = await ImagePicker.pickImage(source: source);
    // if you don't select any images.
    if (imageFile == null) {
      return;
    }

    setState(() {
      this.imageResult = null;
      this.imageFile = imageFile; 
    });
  }

  Future<void> visionAPI() async {
    print('click vision api');
    Api api = Api(inputImage: imageFile);
    final apiResult = await api.postVision();
    setState(() {
      this.imageResult = apiResult; 
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build widget');
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(image, height: 100,width: 100),
              (imageFile == null)
                  ? Icon(Icons.no_sim)
                  : Center(
                      child: Align( 
                        child: Image.memory(
                          imageFile.readAsBytesSync(),
                          height: 300.0,
                          width: 300.0,
                        ),
                        alignment: Alignment(0, 1.0),
                      )
                    ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    child: Text('Select from folder'),
                    onPressed: () {
                      _getAndSaveImageFromDevice(ImageSource.gallery);
                    },
                  )),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    child: Text('Request Vison API'),
                    onPressed: () {
                      visionAPI();
                    },
                  )),
              buildText()
            ],
          ),
        )
      );
  }
  Widget buildText(){
    if(imageFile == null){
      return Text("Select Image!");
    }else if(imageResult == null){
      return Text("click Request Vision API");
    }else{
      return Text('This is ['+imageResult + '].');
    }
  }
}