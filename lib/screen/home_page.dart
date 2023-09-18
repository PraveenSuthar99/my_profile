import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/auth/auth_service.dart';
import 'package:my_profile/screen/image_srenn.dart';
import 'package:my_profile/screen/login_page.dart';
import 'edit_profile_page.dart';

class HomePage extends StatefulWidget {



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Auth _auth = Get.put(Auth());
  @override
  Widget build(BuildContext context) {
    _auth.getUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.rememberMe.value=false;
              Get.off(() => LoginPage(email: "",pass: "",));

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [




            GetBuilder<Auth>(
              init: Auth(),
              builder: (controller) =>Stack(
              children: [


                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey.shade200,
                  child: controller.imagepath.value.length>0?CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(File(_auth.img.value.toString())),
                  ):CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG_vx3RR-nd8Arl7ocCIfTfXdhaT4Y3fWGCH71cYFb&s'),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                    onTap: () {
                      Get.to(ImageScreen());
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.add_a_photo, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              color: Colors.black.withOpacity(
                                0.3,
                              ),
                              blurRadius: 3,
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ) ,),


            // Obx(() => Stack(
            //   children: [
            //     CircleAvatar(
            //       radius: 70,
            //       backgroundColor: Colors.grey.shade200,
            //       child: _auth.imagepath.value.length>0?CircleAvatar(
            //         radius: 70,
            //         backgroundImage: FileImage(File(_auth.img.value)),
            //       ):CircleAvatar(
            //         radius: 70,
            //         backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG_vx3RR-nd8Arl7ocCIfTfXdhaT4Y3fWGCH71cYFb&s'),
            //       ),
            //     ),
            //     Positioned(
            //       bottom: 1,
            //       right: 1,
            //       child: InkWell(
            //         onTap: () {
            //          _auth.getImage();
            //          _auth.getUserInfo();
            //         },
            //         child: Container(
            //           child: Padding(
            //             padding: const EdgeInsets.all(2.0),
            //             child: Icon(Icons.add_a_photo, color: Colors.black),
            //           ),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                 width: 3,
            //                 color: Colors.white,
            //               ),
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(
            //                   50,
            //                 ),
            //               ),
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                   offset: Offset(2, 4),
            //                   color: Colors.black.withOpacity(
            //                     0.3,
            //                   ),
            //                   blurRadius: 3,
            //                 ),
            //               ]),
            //         ),
            //       ),
            //     ),
            //   ],
            // )),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Obx(() =>  Text(
              _auth.email.value, // Replace with the user's email
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            )),
            SizedBox(height: 20),


            Obx(() => _ProfileInfoField(
              label: 'Skills:',
              value: _auth.skills.value, // Replace with user's name
              onEditPressed: () {
                // Implement navigation to edit page here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      field: 'Skills:',
                      initialValue: _auth.skills.value,
                      keyvalue: "skills",// Pass the current value
                    ),
                  ),
                );
              },
            )),

            SizedBox(height: 20),

            Obx(() =>  _ProfileInfoField(
              label: 'Work Experience:',
              value: _auth.work.value, // Replace with user's name
              onEditPressed: () {

                print("this,,,,,,,,,,");
                // Implement navigation to edit page here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      field: 'Work Experience:',
                      initialValue: _auth.work.value,
                      keyvalue: "work",// Pass the current value
                    ),
                  ),
                );
              },
            ),)




          ],
        ),
      ),
    );
  }
}

class _ProfileInfoField extends StatelessWidget {
  final String label;
  final String value;
  final Function()? onEditPressed;

  _ProfileInfoField({

    required this.label,
    required this.value,
      this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(


      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5,),

            InkWell(
              onTap: onEditPressed,
                child: Icon(Icons.edit,))
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
