import 'dart:developer';
import 'dart:typed_data';

import 'package:adminpanel/categoryprovider.dart';
import 'package:adminpanel/imageprovider.dart';
import 'package:adminpanel/productmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProducts extends StatefulWidget {
  AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getallcategory();

    log(myvalue.toString());
    super.initState();
  }

  String? myvalue;

  Future<String> downloadurl(Uint8List file) async {
    String id = Uuid().v4();
    String url = '';
    FirebaseStorage firestor = FirebaseStorage.instance;
    await firestor
        .ref()
        .child('product')
        .child('${id}.png')
        .putData(file)
        .then((p0) async {
      url = await p0.ref.getDownloadURL();
    });
    return url;
  }

  TextEditingController title = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController dis = TextEditingController();

  TextEditingController quantity = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 61, 49),
        toolbarHeight: 60,
        title: Center(
            child: Text(
          'Add Products',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Popp',
              fontSize: 25,
              fontWeight: FontWeight.w600),
        )),
      ),
     
      body: Center(
        child: Card(
          elevation: 30,
          color: Colors.white,
          child: Container(
            color: Colors.white,
            width: 700,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Title',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'MeFont',
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 45),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Discription',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'MeFont',
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: dis,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(40),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'MeFont',
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: price,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 45),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Quantity',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'MeFont',
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: quantity,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 45),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Url',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'MeFont',
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: url,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 45),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Consumer<CategoryProvider>(
                          builder: (context, pro, _) {
                        return DropdownButton(
                            elevation: 30,
                            iconSize: 35,
                            iconEnabledColor: Color.fromARGB(255, 225, 61, 49),
                            hint: Text(
                              'Category',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Popp',
                                  fontSize: 13),
                            ),
                            value: myvalue,
                            items: pro.getcategories
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (mevalue) {
                              myvalue = mevalue.toString();
                              setState(() {});
                            });
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Image of Product',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'MeFont',
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Provider.of<imgProvider>(context, listen: false)
                                  .pickimage();
                            },
                            child: Provider.of<imgProvider>(context).webimage !=
                                    null
                                ? CircleAvatar(
                                    radius: 75,
                                    backgroundImage: MemoryImage(
                                        Provider.of<imgProvider>(context)
                                            .webimage!),
                                  )
                                : CircleAvatar(
                                    radius: 75,
                                    backgroundColor:
                                        Color.fromARGB(255, 225, 61, 49),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 60,
                          left: 75,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 550.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 225, 61, 49),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            fixedSize: Size(120, 35)),
                        onPressed: () async {
                          String proId = Uuid().v4();

                          if (title.text.isNotEmpty &&
                              price.text.isNotEmpty &&
                              dis.text.isNotEmpty &&
                              quantity.text.isNotEmpty) {
                            String url = await downloadurl(
                                Provider.of<imgProvider>(context, listen: false)
                                    .webimage!);
                            productmodel model = productmodel(
                                quantity: double.parse(quantity.text),
                                price: double.parse(price.text),
                                categoryName: myvalue.toString(),
                                id: proId,
                                title: title.text,
                                url: url,
                                description: dis.text);
                            await FirebaseFirestore.instance
                                .collection('Products')
                                .doc(proId)
                                .set(model.toMap());

                            title.clear();

                            Provider.of<imgProvider>(context, listen: false)
                                .setimagenull(null);
                            dis.clear();

                            quantity.clear();
                            price.clear();
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Popp',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
