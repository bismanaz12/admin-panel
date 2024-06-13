import 'package:adminpanel/productmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 61, 49),
        toolbarHeight: 60,
        title: Center(
            child: Text(
          'Products',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Popp',
              fontSize: 25,
              fontWeight: FontWeight.w600),
        )),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs
                  .map((e) => productmodel.fromMap(e.data()))
                  .toList();
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            child: Image.network(
                              data[index].url,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data[index].title),
                              InkWell(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Products')
                                      .doc(data[index].id)
                                      .delete();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
