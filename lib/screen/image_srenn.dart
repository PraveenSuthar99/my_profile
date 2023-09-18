import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/auth/auth_service.dart';


class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  var _auth = Get.put(Auth());

  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async {
        // Implement logic to show a confirmation dialog if the user tries to leave without saving
        bool leaveWithoutSaving = await _showLeaveConfirmationDialog(context);
        if (leaveWithoutSaving) {
          Navigator.of(context).pop(); // Close the edit page
        }
        return !leaveWithoutSaving;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Image"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [


              SizedBox
                (
                width: 200,
                child: Column(
                  children: [

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF8454fe),
                          onPrimary: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minimumSize: Size(double.infinity, 50), //////// HERE
                        ),
                        onPressed: () {
                          _auth.getUserInfo();


                        }, child: Text("Save")),

                    SizedBox(height: 20,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF8454fe),
                          onPrimary: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minimumSize: Size(double.infinity, 50), //////// HERE
                        ),
                        onPressed: () {

                          _auth.getImage();
                          _auth.getUserInfo();
                        }, child: Text("Camera")),
                  ],
                ),
              )



            ],
          ),
        ),
      ),
    );

  }
}

Future<bool> _showLeaveConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Leave without saving?'),
        content: Text('Changes will be lost if you leave without saving.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true); // Leave without saving
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Stay on the page
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}