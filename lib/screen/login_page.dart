import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_store/user_data_manager.dart';


class LoginPage extends StatefulWidget {
  var email;


  var pass;

  LoginPage({
    required this.email,
    required this.pass,

  });


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final Auth _auth = Get.put(Auth());

  var email;
  var pass;


    late TextEditingController _emailController;
    late TextEditingController _passwordController;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email=widget.email;
    pass=widget.pass;


  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    _emailController = TextEditingController(text: email);
    _passwordController = TextEditingController(text: pass);


    double size = 18.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          
        ),

        body: SingleChildScrollView(

          child: Form(
            key: _auth.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [



                  Align(alignment: Alignment.center,
                      child: Text('Login',style: TextStyle(fontSize: 30),)),
                  SizedBox(height: 100,),

                  Text(
                    "Email",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _emailController,
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
                      hintText: "Email address",
                      hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return "Enter a valid email!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
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
                      hintText: "Enter your password",
                      hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                    ),
                    validator: (String? value) {



                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be atlas 6 characters long";
                      }
                      if (value.length > 20) {
                        return "Password must be less than 20 characters";
                      }
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return "Password must contain a number";
                      }
                      return null;
                    },
                  ),

                  Row(
                    children: <Widget>[
                      Obx(() => Checkbox(
                        value: _auth.rememberMe.value,
                        onChanged: (value) {
                          print("---${value}");
                          _auth.rememberMe.value = value!;
                          _auth.isRemember();
                        },
                      ),),
                      Text('Remember Me'),
                    ],
                  ),
                  SizedBox(height: 10,),
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

                      _auth.submit(_emailController.text,_passwordController.text);

                    },
                    child: Text('Login',style: TextStyle(fontSize: 20),),
                  ),
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
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      UserDataManager userDataManager = UserDataManager(prefs);

                      Map<String, dynamic>? retrievedUserData = userDataManager.getUserData("user123");

                      if (retrievedUserData != null) {
                        // Use the retrieved user data
                        print('User Name: ${retrievedUserData['name']}');
                        print('User Email: ${retrievedUserData['email']}');
                      } else {
                        // Handle the case where user data is not available
                        print('User Data not found.');
                      }
                      // Implement Google login logic here using Firebase Authentication
                    },
                    child: Text('Login with Google',style: TextStyle(fontSize: 20),),
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
