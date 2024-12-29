import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'welcome_page.dart';  // تأكد من استيراد صفحة WelcomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',  // تعيين صفحة تسجيل الدخول كصفحة البداية
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/welcome': (context) => WelcomePage(),  // تأكد من أن اسم الصفحة صحيح
      },
    );
  }
}
