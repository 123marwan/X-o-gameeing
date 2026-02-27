import 'package:flutter/material.dart';
import 'package:xo_games/xogame/xogames.dart';

import '../playermodel.dart';


class Login extends StatefulWidget {
  static const String routename = 'Login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController playerOne = TextEditingController();
  final TextEditingController playerTwo = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    playerOne.dispose();
    playerTwo.dispose();
    super.dispose();
  }

  void startGame() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(
        context,
        Xogame.routename,
        arguments: Playermodel(
          playerOne.text.trim(),
          playerTwo.text.trim(),
        ),
      );
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Player One
              TextFormField(
                controller: playerOne,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: inputDecoration('Player one'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter player one name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              /// Player Two
              TextFormField(
                controller: playerTwo,
                textInputAction: TextInputAction.done,
                decoration: inputDecoration('Player two'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter player two name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  if (value.trim() == playerOne.text.trim()) {
                    return 'Players names must be different';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => startGame(),
              ),
              const SizedBox(height: 30),

              /// Start Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: startGame,
                child: const Text(
                  'Let’s go',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}