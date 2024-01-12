import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String supaUri = 'https://aimzyrefoddrulfwxnck.supabase.co'; //get env key
  String supaAnon = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpbXp5cmVmb2RkcnVsZnd4bmNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQxODg2MzEsImV4cCI6MjAxOTc2NDYzMX0.VnO0mQzdH46byrchvY8jvS-_j_9KBTmEbR-U6X7KF_M';

  Supabase supaProvider = await Supabase.initialize(
    url: supaUri,
    anonKey: supaAnon,
  );

  final authC = Get.put(AuthController(), permanent: true);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: supaProvider.client.auth.currentUser == null
          ? Routes.LOGIN
          : Routes.HOME, //cek login current user
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
