


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../student.dart';

class FirestoreServices{


 static currentUserId(){
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      print('Current User ID: $userId');
      savecurrentidTosharepref(userId);
    }
  }



  static addUser(String email,age,username) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user



    users.add({"userName":username,'email':email,'age':20});
  }
  static addusersdata()async{
    final pref = await SharedPreferences.getInstance();
    String? value=pref.getString("current");
    final data = FirebaseFirestore.instance.collection('users').doc(value);

    // Call the user's CollectionReference to add a new user
    DataModel model =DataModel("umar",123,202.0,"board bazzar ");
    final data1 =model.toMap();

    data.set(data1);
  }
  static getData(){
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    user.get().then((value){

      value.docs.forEach((element) {
        element.data();

        DataModel model=DataModel(element['name'], element['id'], element['score'], element['address']);
        final data= DataModel.fromJson(model.toMap());

        print('the value of users are : ${element.data()}'+" ${model.id}");
      });


    });

  }
  static removeData()async{

    String? value=await getcurrentId();
    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return users
        .doc(value).delete()
    //.update({'id': FieldValue.delete()})
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }


  static Future<void> updateUser() async{

    String? value=await getcurrentId();

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(value)
        .update({'name': 'Stokes and Sons'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
static savecurrentidTosharepref(value)async{
final pref = await SharedPreferences.getInstance();
pref.setString("current", value);
print('data stored in sharepref $value');
getcurrentId();
  }
 static getcurrentId()async{
   final pref = await SharedPreferences.getInstance();
   String? value=pref.getString("current");
   print('got data from share pref is  $value');
   return value;
 }
 static final ImagePicker _imagePicker = ImagePicker();
static FirebaseStorage _storage = FirebaseStorage.instance;
static XFile? _pickedImage;

static Future<void> pickImage() async {
   XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);


     _pickedImage = pickedImage;
   _uploadImage(_pickedImage);

 }

 static Future<void> _uploadImage(XFile? pickedImage) async {
   if (pickedImage == null) {
     return;
   }

   File imageFile = File(pickedImage.path);
   String imageName = DateTime.now().toString(); // You can choose a better naming strategy
  Reference reference = _storage.ref().child('images/$imageName.jpg');

   UploadTask uploadTask = reference.putFile(imageFile);
   await uploadTask.whenComplete(()async {
     String imageurl=await getImageURL("");


     print('Image uploaded to Firebase Storage.');

   });
 }
 //
// downloade the image
//

 static String _imageURL = '';

 static Future<String> getImageURL(String imagePath) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      Reference reference = _storage.ref().child("images/2023-08-18 12:36:23.888991.jpg");
      String downloadURL = await reference.getDownloadURL();


        _imageURL = downloadURL;


      print('Image URL: $_imageURL');
    } catch (e) {
      print('Error getting image URL: $e');
    }
    return _imageURL;
  }


}

