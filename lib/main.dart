import 'package:flutter/material.dart';
import 'package:flutter_emoji/helper/close_keyboard_helper.dart';
import 'package:flutter_emoji/utils/binding_utils.dart';
import 'package:flutter_emoji/utils/routes_utils.dart';
import 'package:flutter_emoji/utils/theme_utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
Future initSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Keyboard().hide();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Emojis',
        theme: lightThemeData(),
        initialRoute: Routes.emojiScreen,
        initialBinding: EmojiBinding(),
        getPages: getPages,
      ),
    );
  }
}
