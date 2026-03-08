import 'package:ecommerce_app/Authentication/login.dart';
import 'package:ecommerce_app/cart/cart_provider.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/order/order_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

String secret =
    "sk_test_51T74aV1DN66cpNke2TU1khGwpoNSOlXGFBRv1unvgzyEDeTWZ3SEFNCMO4CX0Me4qf596JMgMdKgCFe9jcCLu00R00Y36dXkZx";

String publishableKey =
    "pk_test_51T74aV1DN66cpNke2jwe9mKR8VmSALXgOTfQ912HJytqgyMszm5xOpzrKeLu2UhX8NSoOfoVT6aCUMjmYPcN8G2k00mYzWlLHj";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Stripe.publishableKey = publishableKey;
  Stripe.instance.applySettings();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final auth = FirebaseAuth.instance;
  late final user = auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderHistoryProvider()),
      ],
      child: MaterialApp(
        title: "Shopping App",
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
        home: user != null ? MyHomePage() : Login(),
      ),
    );
  }
}
