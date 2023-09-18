import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_store/user_data_manager.dart';

class EditProfilePage extends StatefulWidget {

  final String field;
  final String initialValue;
  final String keyvalue;

  EditProfilePage({
    required this.field,
    required this.initialValue,
    required this.keyvalue,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String updatedValue = '';

  final TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updatedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {

    var _auth = Get.put(Auth());
    _auth.getUserInfo();

    double size = 18.0;
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
          title: Text('Edit ${widget.field}'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(size)),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(size)),
                      borderSide: BorderSide(width: 1, color: Colors.orange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(size)),
                      borderSide: BorderSide(width: 1, color: Colors.green),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(size)),
                        borderSide: BorderSide(
                          width: 1,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(size)),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(size)),
                        borderSide:
                        BorderSide(width: 1, color: Colors.yellowAccent)),
                    hintText: "Please enter...",
                    hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  initialValue: widget.initialValue,
                  onChanged: (value) {
                    updatedValue = value;
                  },

                ),

                SizedBox(height: 20),
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
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    UserDataManager userDataManager = UserDataManager(prefs);
                    String userId = "${prefs.getString("id")}";
                    Map<String, dynamic>? currentUserData = userDataManager.getUserData("${prefs.getString("id")}");

                    if (currentUserData != null) {
                      // Update the user data
                      currentUserData[widget.keyvalue] = updatedValue; // Update the desired field

                      // Save the updated user data back to SharedPreferences
                      await userDataManager.saveUserData(userId, currentUserData);

                      print('User Name updated to: ${currentUserData['name']}');

                      _auth.onInit();

                    } else {
                      // Handle the case where user data is not available
                      print('User Data not found.');
                    }
                    print('Updated ${widget.field}: $updatedValue');
                    Navigator.of(context).pop(); // Close the edit page
                  },
                  child: Text('Save',style: TextStyle(fontSize: 20),),
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
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
}