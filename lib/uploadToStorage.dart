import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart';


class UploadToStorage{
  final File inputImage;

  UploadToStorage({
    @required this.inputImage
  }) : assert(inputImage != null);

  Future<String> uploadImage() async {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  String subDirectoryName = 'images';
  final StorageReference ref = FirebaseStorage()
      .ref()
      .child(subDirectoryName)
      .child('${timestamp}');
  final StorageUploadTask uploadTask = ref.putFile(
      inputImage,
      StorageMetadata(
        contentType: "image/jpeg",
      ));
  StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  if (snapshot.error == null) {
    return await snapshot.ref.getDownloadURL();
  }
  switch (snapshot.error) {
    case StorageError.unknown:
      // something
    case StorageError.objectNotFound:
      // something
    case StorageError.bucketNotFound:
      // something
    case StorageError.projectNotFound:
      // something
    case StorageError.quotaExceeded:
      // something
    case StorageError.notAuthenticated:
      // something
    case StorageError.notAuthorized:
      // something
    case StorageError.retryLimitExceeded:
      // something
    case StorageError.invalidChecksum:
      // something
    case StorageError.canceled:
      // something
  }
  return 'Uploading End!';
  }

}

