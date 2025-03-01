import 'package:app_shop/controllers/cart_provider.dart';
import 'package:app_shop/controllers/favorites_provider.dart';
import 'package:app_shop/controllers/login_provider.dart';
import 'package:app_shop/controllers/mainscreen_provider.dart';
import 'package:app_shop/controllers/product_provider.dart';
import 'package:app_shop/views/ui/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  //method that initializes the app and run top level wigets
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // overall theme and app layout
  return ScreenUtilInit(
      designSize: const Size(325, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BTL',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFE2E2E2)
          ),
          home: const MainScreen(),
        );
      }
    );
}
}
