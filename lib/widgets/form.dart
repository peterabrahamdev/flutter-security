import 'package:flutter/material.dart';
import 'package:flutter_security/utils/user_secure_storage.dart';
import 'package:gap/gap.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _enteredUsername = '';
  var _enteredPassword = '';

  void _submit() async {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    await UserSecureStorage.setUsername(_enteredUsername);
    await UserSecureStorage.setPassword(_enteredPassword);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
            onSaved: (value) {
              _enteredUsername = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            onSaved: (value) {
              _enteredPassword = value!;
            },
          ),
          const Gap(30),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Save data'),
          ),
          const Gap(30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: UserSecureStorage.getUsername(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('Username: ${snapshot.data}');
                    }
                    return const CircularProgressIndicator();
                  }),
              FutureBuilder(
                  future: UserSecureStorage.getPassword(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('Password: ${snapshot.data}');
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ]),
      ),
    );
  }
}
