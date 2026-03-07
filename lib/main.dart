import 'package:ecommerce_app/cart/cart_provider.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/home2.dart';
import 'package:ecommerce_app/Authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: "Shopping app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Lato",
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(254, 206, 1, 1),
            primary: const Color.fromRGBO(254, 206, 1, 1),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
