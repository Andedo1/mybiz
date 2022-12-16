import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/screens/Home/mainItem.dart';
import 'package:majisoft/helpers/dependencies.dart' as dep;
import 'package:majisoft/screens/item_detail.dart';
import 'package:majisoft/screens/recomended_item_detail.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularItemController>().getPopularItemList();
    return GetMaterialApp(
      title: 'Majisoft App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: const MainItem(),
    );
  }
}