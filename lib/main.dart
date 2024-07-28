// import 'package:chapa_flutter/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';

void main(List<String> args) {
  Chapa.configure(privateKey: "CHASECK_TEST-pxglKFxPWvXXWXGDF5isQMt4v4lhPOsK");
  runApp(
    MaterialApp(
      home: PaymentPage(),
    ),
  );
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  // define func verify
  Future<void> verify() async {
    try {
      Map<String, dynamic> verificationResult =
          await Chapa.getInstance.verifyPayment(
        txRef: TxRefRandomGenerator.gettxRef,
      );
      print(verificationResult);
    } catch (e) {
      print(e.toString());
    }
  }
// define func pay 
  Future<void> pay() async {
    try {
      String txRef = TxRefRandomGenerator.generate(prefix: 'test');

      await Chapa.getInstance.startPayment(
        context: context,
        onInAppPaymentSuccess: (successMsg) {},
        onInAppPaymentError: (errorMsg) {
          print(errorMsg);
        },
        amount: '250',
        currency: 'ETB',
        txRef: txRef,
        firstName: "testFirstName",
        lastName: "testLastName",
        phoneNumber: "0900123456",
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chapa demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Payment"),
            FilledButton(
              onPressed: () async {
                await pay();
              },
              child: Text("Pay".toUpperCase()),
            ),
            SizedBox(height: 12),
            Text("Verification"),
            FilledButton(
              onPressed: () async {
                await verify();
              },
              child: Text("Verify".toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
