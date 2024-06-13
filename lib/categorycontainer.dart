import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class CategoryContainer extends StatefulWidget {
   CategoryContainer({super.key,required this.txt,required this.id,});
String txt;


String id;

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
   

    return Card(
      elevation: 2,
      child: Container(
        color: Colors.white,
         width: MediaQuery.of(context).size.width*0.2,
         height: 45,
        child: Row(
          children: [
           
            SizedBox(width: 15,),
            Expanded(child: Text(widget.txt,style: TextStyle(color: Colors.black,fontFamily: 'Popp',fontSize: 15,fontWeight: FontWeight.w600),)),
          
        
              
                
                  InkWell(
               onTap: (){
                
               setState(() {
                controller.text = widget.txt;
                  
               });
               showDialog(context: context, builder: (context){
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Container(
                    height: 200,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(controller: controller,
                          style: TextStyle(fontFamily: 'MeFont',fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                                 
                                   focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.black,width: 0.2,)
                                  ),
                                  
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.black,width: 0.2,)
                                  )
                                ),),
                                SizedBox(height: 75,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                     backgroundColor:Color.fromARGB(255, 225, 61, 49) ,
                        fixedSize: Size(200, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                                  ),
                                  onPressed: ()async{
                                   await  FirebaseFirestore.instance.collection('categories').doc(widget.id).update({
                                      'CategoryName':controller.text
                                    }
                                      
                                      
                                      
                                    );
                                    Navigator.pop(context);

                                    
                                  }, child: Text('Save',style:TextStyle(color: Colors.white,fontFamily: 'Popp',fontSize: 15,fontWeight: FontWeight.w400  ,)))
                        ],
                      ),
                    ),),
                );
               });
                
               

               },
              child: Icon(Icons.edit_outlined,color:Colors.blue,size: 25, )),
              SizedBox(width: 10,),
            
              InkWell(
                onTap: (){
                  FirebaseFirestore.instance.collection('categories').doc(widget.id).delete();
                 
                  
                },
                child: Icon(Icons.delete_outline,color: const Color.fromARGB(255, 171, 20, 9),size: 25,)),
                  
              ],
            ),
          )
          
      
    
    );
  }
}