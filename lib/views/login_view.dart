import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/loading_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _passWord;

  CloseDialog? _closeDialogHandle;

  @override
  void initState() {
    _email = TextEditingController();
    _passWord = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _passWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthExceptions) {
            await showErrorDialog(
              context,
              'Cannot find a user with the entered credentials',
            );
          } else if (state.exception is WrongPasswordAuthExceptions) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthExceptions) {
            await showErrorDialog(context, 'Authentification error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Please log in to account in order to interact with and create notes !!',
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(hintText: 'Enter your mail here'),
                ),
                TextField(
                  controller: _passWord,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password here',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _passWord.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventLogin(email, password));
                  },
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventForgotPassword());
                  },
                  child: const Text('I forgot my password'),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRegister());
                  },
                  child: const Text('Not register yet? Register here !'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
