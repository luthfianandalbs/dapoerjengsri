import 'package:dapoerjengsri/admin/add_food.dart';
import 'package:dapoerjengsri/admin/adminHome.dart';
import 'package:dapoerjengsri/admin/adminLogin.dart';
import 'package:dapoerjengsri/pages/bottomnav.dart';
import 'package:dapoerjengsri/pages/details.dart';
import 'package:dapoerjengsri/pages/forgotPass.dart';
import 'package:dapoerjengsri/pages/home.dart';
import 'package:dapoerjengsri/pages/login.dart';
import 'package:dapoerjengsri/pages/onboard.dart';
import 'package:dapoerjengsri/pages/profile.dart';
import 'package:dapoerjengsri/pages/signup.dart';
import 'package:dapoerjengsri/pages/wallet.dart';
import 'package:dapoerjengsri/pages/which.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [observer],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoard(),
    );
  }
}
