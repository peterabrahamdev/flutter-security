import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> authenticate() async {
    LocalAuthentication auth = LocalAuthentication();
    try {
      await auth.authenticate(
        localizedReason: 'Authenticate yourself to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      logger.e('Error during authentication: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Security')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Press to authenticate'),
          onPressed: () => authenticate(),
        ),
      ),
    );
  }
}
