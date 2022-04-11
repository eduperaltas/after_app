// @dart=2.9
import 'dart:io';

import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCardEdit extends StatefulWidget {
  String photo;
  String Actualphoto;
  String uid="";
  bool value;
  ImageCardEdit({this.photo,this.uid,this.value,this.Actualphoto});

  @override
  _ImageCardEditState createState() => _ImageCardEditState();
}

class _ImageCardEditState extends State<ImageCardEdit> {
  final ImagePicker _picker = ImagePicker();  
  File sampleImage;
  String url;
  Future getImage() async {

    // var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    var tempImage = await _picker.pickImage(source: ImageSource.gallery)as File;
    setState(() {
      sampleImage = tempImage;
    });


  }

  void uploadPost() async {

    //Subir imagen a firebase storage
    final  firebase_storage.Reference postImageRef =
    firebase_storage.FirebaseStorage.instance.ref().child("Post photos");
    var timekey = DateTime.now();
    final firebase_storage.UploadTask uploadTask =
    postImageRef.child(timekey.toString() + ".jpg").putFile(sampleImage);

    if(await uploadTask.snapshotEvents.isBroadcast){
      Center(
          child:CircularProgressIndicator());
    }
    var imageUrl = await(await uploadTask.whenComplete(() => true)).ref.getDownloadURL();
    url = imageUrl.toString();
    print("Image url: " +url);
    CloudFirestoreAPI().updateBarberphoto(widget.photo,url);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var card;
    if(widget.Actualphoto == null){
      widget.Actualphoto = "https://i.pinimg.com/236x/83/5b/aa/835baafbbae55355e3f5f5848d27d543.jpg";
    };
    if(widget.value){
      print("subiendo foto");
      uploadPost();
      card= Container(
        margin: EdgeInsets.only(right: 10.0),
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          image: sampleImage == null ?DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://i.pinimg.com/236x/83/5b/aa/835baafbbae55355e3f5f5848d27d543.jpg")
          ): DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(sampleImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular((30.0))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                height: 30,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xffAD8B19).withOpacity(0.75),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),),
                ),
                child: Center(
                    child:Text('editar',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight:  FontWeight.bold,
                        fontSize: 18.0,
                      ) ,)
                ),
              ),
            )

          ],
        ),
      );
    } else{

      card= Container(
        margin: EdgeInsets.only(right: 10.0),
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          image: sampleImage == null ?DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.Actualphoto)
          ): DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(sampleImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular((30.0))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                height: 30,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xffAD8B19).withOpacity(0.75),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),),
                ),
                child: Center(
                    child:Text('Editar',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight:  FontWeight.bold,
                        fontSize: 18.0,
                      ) ,)
                ),
              ),
            )

          ],
        ),
      );
    }


    return card;
  }


}