

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier{
  List<String> _categories=[];
  List<String> Id = [];
  


  List<String> get getcategories => _categories;

  getallcategory()async{
    _categories.clear();
    FirebaseFirestore.instance.collection('categories').get().then((value) => {
      for(int i = 0;i<value.docs.length;i++){
        _categories.add(value.docs[i].data()['CategoryName']),
        Id.add(value.docs[i].data()['CategoryId']),


        

      },
      notifyListeners(),
    });

  }
}