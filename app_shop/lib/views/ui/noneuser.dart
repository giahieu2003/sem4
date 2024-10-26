import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/shared/reuseable_text.dart';
import 'package:app_shop/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Noneuser extends StatelessWidget {
  const Noneuser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        elevation: 0,
        leading: const Icon(MaterialCommunityIcons.qrcode,
        size: 18,
        color: Colors.black,),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(padding: const EdgeInsets.only(right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/usa.svg',
                width: 15.w,
                height: 25,
                ),
                
                SizedBox(
                  width: 5.w,
                ),
                
                Container(
                  height: 15.h,
                  width: 1.w,
                  color: Colors.grey,
                ),

                SizedBox(
                  width: 5.w,
                ),

                ReusableText(text: "USA", style: appstyle(14, Colors.black, FontWeight.normal)),

                SizedBox(
                  width: 10.w,
                ),

                const Padding(padding: EdgeInsets.only(bottom: 0),
                  child: Icon(
                    SimpleLineIcons.settings,
                    color: Colors.black,
                    size: 18,
                  ),
                )
              ],
            ),),
          )
        ],
      ),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 750.h,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E2E2)
              ),
              child: Column(
                
                children: [
                  Padding(padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 35.h,
                            width: 35.w,
                            child: const CircleAvatar(
                              backgroundImage: AssetImage('assets/images/user.jpeg'),
                            ),
                          ),

                          const SizedBox(
                            width: 5,
                          ),

                          ReusableText(text: "Hello, please login into your account", 
                          style: appstyle(10, Colors.grey.shade600, FontWeight.normal)),

                          ],
                      ),
                      GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 2),
                              width: 50.w,
                              height: 30.h,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Center(
                                child: ReusableText(text: "Login", 
                                style: appstyle(12, Colors.white, FontWeight.normal)),
                              ),
                            ),
                          )
                        
                    ],
                  ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}