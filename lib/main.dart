import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_springboot/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final prefs = await SharedPreferences.getInstance();
  final storage = FlutterSecureStorage();
  final isLogin = prefs.getBool('isLogin') ?? false;
  final token = await storage.read(key: 'token');

  runApp(MyApp(isLogin: isLogin && token != null));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: isLogin ? '/home' : '/login',
      getPages: Routes.appPages,
    );
  }
}

  