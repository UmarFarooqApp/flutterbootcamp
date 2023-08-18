import 'package:firbasenewproject/Singn_In_Screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Core/databaseServices/firestosreServices.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24.0),

            ),
            myButton(text: "log out",onpress: (){}),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                myButton(text: "Add Data",onpress: (){FirestoreServices.addusersdata();},),
                myButton(text: "get data",onpress: (){FirestoreServices.getData();},),
                myButton(text: "update Data",onpress: (){FirestoreServices.updateUser();},),



              ],

            ),
            myButton(text: "delete data",onpress: (){FirestoreServices.removeData();},),
            myButton(text: "getuserid",onpress: (){FirestoreServices.currentUserId();},),
            SizedBox(height: 50),
            Text('upload image to firebsae storage'),
            SizedBox(height: 20),
            myButton(text: "upload image",onpress: (){FirestoreServices.pickImage();},),
            myButton(text: "getimage",onpress: ()async{imagUrl=await FirestoreServices. getImageURL("");
              setState(() {

              });
              },),
            SizedBox(height: 20,),
            Container(
              height: 250,
              child: Image.network(imagUrl,fit: BoxFit.contain,),
            )


          ],
        ),
      ),
    );
  }
  String imagUrl='';
}

class myButton extends StatelessWidget {
 final  String ?text;
 final onpress;
   myButton({
    this.text
 ,this.onpress
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onpress,
     child: Text(text!));
  }
}

signOut(context)async{
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
}


