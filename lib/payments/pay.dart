import 'dart:convert';

import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Pay {
  Map<String, dynamic>? payintentdata;

  Future<void> makepayment(int amount, String currency) async {
    try {
      payintentdata = await createpayintent(amount, currency);
      if (payintentdata == null) {
        //print("Payment Intent creation failed");
        return;
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: payintentdata!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "Huraira",
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e.toString());
    }
  }

  createpayintent(int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": amount.toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer $dumydata",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

 
}
