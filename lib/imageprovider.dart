import 'dart:developer';
import 'dart:io';



import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class imgProvider with ChangeNotifier{


  Uint8List? webimage ;
  File? _file;
  pickimage()async{
    
    // var permissionStatus = per.re

    // MOBILE
    if (!kIsWeb ) {
      final ImagePicker _picker = ImagePicker();
      XFile? image =  await  _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var selected = File(image.path);

  _file = selected;

      
      } else {
        log("No file selected");
      }
    }
        // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
       
        webimage = f;
       
      } else {
        log("No file selected");
      }
    } else {
      log("Permission not granted");
      }


       notifyListeners() ;
    }


setimagenull( value){
  webimage = value;
  notifyListeners();

}
 





    
  

  }
