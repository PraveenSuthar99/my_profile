
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/data_store/user_data_manager.dart';
import 'package:my_profile/screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Auth extends GetxController{


  RxString imagepath = ''.obs;
  final ImagePicker imgpicker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  RxBool rememberMe = false.obs;
  RxString email="".obs;
  RxString skills="".obs;
  RxString work="".obs;
  RxString img="".obs;
  RxString userEmail="".obs;
  RxString userPass="".obs;
  void submit(String email, String password) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }else{
      handleSignInEmail(email,password);
    }
    formKey.currentState!.save();

  }

  Future<void> handleSignInEmail(String email, String password) async {
    String userId = email;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString("id")==userId){
      print("this is my yes");
      getUserInfo();
      Get.to(HomePage());
      update();


    }else{
      prefs.setString("id",email);
      UserDataManager userDataManager = UserDataManager(prefs);
      Map<String, dynamic> userData = {
        'email': email,
        'pass': password,
        'skills': 'Flutter, Dart, UI/UX Design',
        'work': 'Mobile App Developer (2 years)',
        'img': '',
        // Add more user data fields as needed
      };

      await userDataManager.saveUserData(userId, userData);
      Get.to(HomePage());
    }

  }


  Future<void> getUserInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDataManager userDataManager = UserDataManager(prefs);
    Map<String, dynamic>? retrievedUserData = userDataManager.getUserData("${prefs.getString("id")}");


    if (retrievedUserData != null) {
      // Use the retrieved user data

      img.value=retrievedUserData['img'];
      email.value=retrievedUserData['email'];
      skills.value=retrievedUserData['skills'];
      work.value=retrievedUserData['work'];



      print('User Name: ${retrievedUserData['img']}');
      print('User Email: ${retrievedUserData['pass']}');

    } else {
      // Handle the case where user data is not available
      print('User Data not found.');
    }

    update();

  }




  Future getImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {

          imagepath.value = pickedFile.path;
          updateImage();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking image.");
    }
  }


  Future<void> updateImage() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDataManager userDataManager = UserDataManager(prefs);
    String userId = "${prefs.getString("id")}";
    Map<String, dynamic>? currentUserData = userDataManager.getUserData("${prefs.getString("id")}");

    if (currentUserData != null) {
      // Update the user data
      currentUserData['img'] = imagepath.value; // Update the desired field
      await userDataManager.saveUserData(userId, currentUserData);
      update();


    } else {
      // Handle the case where user data is not available

    }

  }

  Future<void> isRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isRemember",rememberMe.value,);
    var isData = prefs.getBool("isRemember");

    print("is data ------------------>${isData}");

  }

  Future<void> logout() async {

  }

  @override
  void onInit() {

    super.onInit();
    getUserInfo();
    update();

    print('"fsdaasa===========${img}');
  }




}