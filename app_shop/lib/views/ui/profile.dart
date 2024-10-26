import 'package:app_shop/controllers/login_provider.dart';
import 'package:app_shop/services/authhelper.dart';
import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/shared/reuseable_text.dart';
import 'package:app_shop/views/shared/tiles_widget.dart';
import 'package:app_shop/views/ui/auth/login.dart';
import 'package:app_shop/views/ui/cartpage.dart';
import 'package:app_shop/views/ui/favorites.dart';
import 'package:app_shop/views/ui/noneuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false ? const Noneuser() : Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        elevation: 0,
        leading: const Icon(
          MaterialCommunityIcons.qrcode,
          size: 18,
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/vietnam.svg',
                    width: 10.w,
                    height: 20,
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
                  ReusableText(
                      text: "VN",
                      style: appstyle(14, Colors.black, FontWeight.normal)),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Icon(
                      SimpleLineIcons.settings,
                      color: Colors.black,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50.h,
              decoration: const BoxDecoration(color: Color(0xFFE2E2E2)),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 45.h,
                                width: 35.w,
                                child: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/user1.png'),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              FutureBuilder(
                                future: Authhelper().getProfile(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: ReusableText(text: "Error get your data", 
                                      style: appstyle(18, Colors.black, FontWeight.w600)),
                                    );
                                  } else {
                                    final userData = snapshot.data;
                                    return SizedBox(
                                      height: 50.h,
                                      child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                            text: userData?.username ?? "",
                                            style: appstyle(
                                                10, Colors.black, FontWeight.normal)),
                                        ReusableText(
                                            text: userData?.email ?? "",
                                            style: appstyle(
                                                10, Colors.black, FontWeight.normal)),
                                      ],
                                      ),
                                    );
                                  }
                                  
                                }
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Feather.edit,
                                  size: 18,
                                )),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 200.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        OnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        title: "My Orders",
                        leading: MaterialCommunityIcons.truck_fast_outline,
                      ),
                      TilesWidget(
                        OnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Favorites()));
                        },
                        title: "My Favorites",
                        leading: MaterialCommunityIcons.heart_outline,
                      ),
                      TilesWidget(
                        OnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        },
                        title: "My Cart",
                        leading: Fontisto.shopping_bag_1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 135.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        OnTap: () {},
                        title: "My Coupon",
                        leading: MaterialCommunityIcons.tag_outline,
                      ),
                      TilesWidget(
                        OnTap: () {},
                        title: "My Store",
                        leading: MaterialCommunityIcons.shopping_outline,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                          OnTap: () {},
                          title: "Shipping address",
                          leading: SimpleLineIcons.location_pin),
                      TilesWidget(
                          OnTap: () {},
                          title: "Settings",
                          leading: AntDesign.setting),
                      TilesWidget(
                          OnTap: () {
                            authNotifier.logout();
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                          title: "Logout",
                          leading: AntDesign.logout),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
