import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/auth/auth_service.dart';
import 'package:my_profile/screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_store/user_data_manager.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Auth _auth = Get.put(Auth());
  var emaiId;
  var password;
  @override
  void initState() {
    super.initState();
    getData();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginPage(email: emaiId,pass: password,)
            )
        )
    );
  }

  Future<void> getData() async {

    print("fdsaads");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDataManager userDataManager = UserDataManager(prefs);
    Map<String, dynamic>? retrievedUserData = userDataManager.getUserData("${prefs.getString("id")}");
    var isData = prefs.getBool("isRemember");
    _auth.rememberMe.value = isData!;




    if(isData==true){

      if(retrievedUserData != null){
        emaiId = retrievedUserData['email'];
        password = retrievedUserData['pass'];
        print("000000000${retrievedUserData['email']}");
        print("000000000${retrievedUserData['pass']}");
      }else{

      }

    }





    // if(isData){
    //
    //   emaiId = retrievedUserData!['email'];
    //   password = retrievedUserData!['pass'];
    //
    //   print("000000000${retrievedUserData!['email']}");
    //   print("000000000${retrievedUserData!['pass']}");
    //
    //
    // }else{
    //
    // }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Splash Screen Example")),
      body: Center(
          child:Text("Welcome to Home Page",
              style: TextStyle( color: Colors.black, fontSize: 30)
          )
      ),
    );
  }
}
