import 'package:flutter/material.dart';

// <-- Her importu alias'la
import 'pages/login_page.dart' as lp;
import 'pages/signup_page.dart' as su;
import 'pages/home_page.dart' as hp;
import 'pages/instructors_page.dart' as inst;
import 'pages/infrastructure_page.dart' as infra;
import 'pages/image_viewer_page.dart' as viewer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HW1App());
}

class HW1App extends StatelessWidget {
  HW1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIM493 HW1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),

      // İlk test: login'i doğrudan aç
      home: lp.LoginPage(),

      routes: {
        '/login': (ctx) => lp.LoginPage(),
        '/signup': (ctx) => su.SignUpPage(),
        '/home': (ctx) => hp.HomePage(),
        '/instructors': (ctx) => const inst.InstructorsPage(),
        '/infrastructure': (ctx) => const infra.InfrastructurePage(),
        // Image viewer
        viewer.ImageViewerPage.routeName: (ctx) => const viewer.ImageViewerPage(),
      },
    );
  }
}
