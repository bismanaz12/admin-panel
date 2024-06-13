import 'dart:developer';
import 'dart:io';


import 'package:adminpanel/categorycontainer.dart';
import 'package:adminpanel/categoryprovider.dart';
import 'package:adminpanel/imageprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart' as per;

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
   Uint8List? webImage;
   File? _file;
 
    uploadImage() async {
    // var permissionStatus = per.re

    // MOBILE
    if (!kIsWeb ) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _file = selected;
        });
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
        setState(() {
          _file = File("a");
          webImage = f;
        });
      } else {
        log("No file selected");
      }
    } else {
      log("Permission not granted");
      }
    }


  
      Future<String>downloadurl(Uint8List file)async{
String id = Uuid().v4();
String  url='';
FirebaseStorage firestor = FirebaseStorage.instance;
await firestor.ref().child('category').child('${id}.png').putData(file).then((p0)async{
  url = await  p0.ref.getDownloadURL();
});
return url;
}
    
  @override
  Widget build(BuildContext context) {

    
    var pro = Provider.of<CategoryProvider>(context,listen: false).getallcategory();
    TextEditingController categorycontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 225, 61, 49),toolbarHeight:60,
      title: Center(child: Text('Categories',style: TextStyle(color: Colors.white,fontFamily: 'Popp',fontSize: 25,fontWeight: FontWeight.w600),))
      ),
      body: Column(
        children: [
        SingleChildScrollView(
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0,),
              child: Card(
                elevation: 30,
                child: Container(
               height:    MediaQuery.of(context).size.height*0.7,
               width: MediaQuery.of(context).size.width*0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                
                  child: Column(
                    children: [
                      Container(
                        child: Center(child: Text('Category',style: TextStyle(color: Colors.white,fontFamily: 'MeFont',fontSize: 25,fontWeight: FontWeight.bold))),
                        decoration: BoxDecoration(
                           color: Color.fromARGB(255, 225, 61, 49),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20))
                        ),
                       height: MediaQuery.of(context).size.height*0.1,
                       width:   MediaQuery.of(context).size.width*0.3,
                       
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('CategoryName',style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'MeFont',fontWeight: FontWeight.w500))),
                      ),
                        Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: categorycontroller,
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              maxHeight: 45
                            ),
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black,width: 0.2,)
                            ),
                            
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black,width: 0.2,)
                            )
                          ),
                                  
                                  
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left:130.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Image of Product',style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'MeFont',fontWeight: FontWeight.w500),)),
                      )
                    ,
                    SizedBox(height: 10,),
                      Stack(
              
                        children:[ InkWell(
                          onTap: (){
                           Provider.of<imgProvider>(context,listen: false).pickimage();
                          },
                          child: Provider.of<imgProvider>(context).webimage!= null?CircleAvatar(
                            radius:70,
                            backgroundImage:MemoryImage( Provider.of<imgProvider>(context).webimage!),):CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 225, 61, 49),
                            radius: 70,
                          
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 70,
                          child: Icon(Icons.camera_alt_outlined,color: Colors.black,size: 25,))
                        ]
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(onPressed: ()async{
                        
                      if(categorycontroller.text.isNotEmpty){
                          String id = Uuid().v4();
                          String url = await downloadurl(Provider.of<imgProvider>(context,listen: false).webimage!);
                          
                         await FirebaseFirestore.instance.collection('categories').doc(id).set(
                        {
                          'CategoryId':id,
                          'CategoryName':categorycontroller.text,
                          'CategoryImage':url,
                        },
                       
                      );
                    
                      categorycontroller.clear();
                Provider.of<imgProvider>(context,listen: false).setimagenull(null);
               
              
                      }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(255, 225, 61, 49) ,
                        fixedSize: Size(400, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                        
                        ),
                         child:Row(
                           children: [
                            SizedBox(width: 90,),
                            Icon(Icons.add,color: Colors.white,size: 25,),
                             Text('Add Category',style: TextStyle(color: Colors.white,fontFamily: 'Popp',fontSize: 15,fontWeight: FontWeight.w400 ,)),
                           ],
                         )),
                      )
              
                    ],
                  ),
                
                ),
              ),
            ),
               SizedBox(width: 90,),  
                  
            Padding(
              padding: const EdgeInsets.only(
              top: 10.0),
              child: Card(
                elevation: 30,
                child: Container(
                  

                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width*0.5,
               decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(15))),
                // child:Consumer<CategoryProvider>(
                //   builder: (context,pro,_){
                //   return  ListView.builder(
                //     itemCount:pro.getcategories.length,
                //     itemBuilder: (context,index){
                //       return 
                //     CategoryContainer(txt: pro.getcategories[index],id: pro.Id[index],);
                      
                  
                //   });
                //   }
                // )
                 
                  child:StreamBuilder(stream: FirebaseFirestore.instance.collection('categories').snapshots(), builder: (context,snapshot){
                   if(snapshot.hasData){
                     return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      
                  


                      itemBuilder: (context,index){
                       var data= snapshot.data!.docs[index].data();
                        return CategoryContainer(txt: data['CategoryName'], id:data['CategoryId'], );

                    });
                  
                   }
                   return Center(child: CircularProgressIndicator());
                  }),
              
                ),
              
              ),
            )
                  
          ],),
        )
        ]
      ),

    );
  }
}