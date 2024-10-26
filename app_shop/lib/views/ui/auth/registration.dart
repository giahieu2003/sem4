import 'package:app_shop/controllers/login_provider.dart';
import 'package:app_shop/models/auth/signup_model.dart';
import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/shared/reuseable_text.dart';
import 'package:app_shop/views/ui/auth/login.dart';
import 'package:custom_flutter_textfield/custom_flutter_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty && username.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/images/bg.jpg'))
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(text: "Welcome!", 
            style: appstyle(30, Colors.white, FontWeight.w600)),

            ReusableText(text: "Fill in ur details to sign up", 
            style: appstyle(14, Colors.white, FontWeight.normal)),

            SizedBox(
              height: 50.h,
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: username,
              decoration: const InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(
                  color: Colors.white30,
                )
              ),
              style: const TextStyle(
                color: Colors.white, // Set the color you want for the input text
              ),
              validator: (username) {
                if (username!.isEmpty) {
                  return 'Please provide valid username';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(
              height: 15.h,
            ),


            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Colors.white30,
                )
              ),
              style: const TextStyle(
                color: Colors.white, // Set the color you want for the input text
              ),
              validator: (email) {
                if (email!.isEmpty && email.contains("@")) {
                  return 'Please provide valid email';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(
              height: 15.h,
            ),

            TextFormField(
              obscureText: authNotifier.isObsecure,
              controller: password,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(
                  color: Colors.white30,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    authNotifier.isObsecure = !authNotifier.isObsecure;
                  },
                  child: authNotifier.isObsecure 
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
                ),
              ),
              style: const TextStyle(
                color: Colors.white, // Set the color you want for the input text
              ),
              validator: (password) {
                if (password!.isEmpty && password.length < 7) {
                  return 'Password too weak';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(
              height: 10.h,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: ReusableText(text: "Login", 
                style: appstyle(14, Colors.white, FontWeight.normal)),
              ),
            ),

            SizedBox(
              height: 40.h,
            ),

            GestureDetector(
              onTap: () {
                formValidation();
                if(validation) {
                  SignupModel model = SignupModel(
                    username: username.text, 
                    email: email.text, 
                    password: password.text);
                  authNotifier.registerUser(model).then((response) {
                    if(response == true) {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                    } else {
                      debugPrint('failed sign up');
                    }
                  });
                } else {
                  debugPrint('form not valid');
                }
              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Center(
                  child: ReusableText(text: "S I G N U P", 
                style: appstyle(18, Colors.black, FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}