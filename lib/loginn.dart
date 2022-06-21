import 'package:bridgeup/register.dart';
import 'package:bridgeup/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'forgot.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  gotoSecondActivity(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }
  gotoHomeActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(

          title: const Text('Login',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor: Colors.blueGrey
      ),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(child: Image.asset('assets/bridgelogo.jpg')) ,

          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter Email',
              enabled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Email cannot be empty";
              }
              if (!RegExp(
                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please enter a valid email");
              } else {
                return null;
              }
            },
            onSaved: (value) {
              emailController.text = value!;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: _isObscure3,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(_isObscure3
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure3 = !_isObscure3;
                    });
                  }),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter Password',
              enabled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            validator: (value) {
              RegExp regex = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "Password cannot be empty";
              }
              if (!regex.hasMatch(value)) {
                return ("Please enter valid password minimum of 6 character");
              } else {
                return null;
              }
            },
            onSaved: (value) {
              passwordController.text = value!;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          Container(
            //padding: const EdgeInsets.symmetric(vertical: 0.5),
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const Forgotpass()));
            },
                child: const Text('Forgot Password?')),
          ),

          const SizedBox(
            height: 20,
          ),

          MaterialButton(
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(32.0))),
            elevation: 5.0,
            height: 50,
            minWidth: 200,
            onPressed: () {
              setState(() {
                visible = true;
              });
              signIn(
                  emailController.text, passwordController.text);
            },
            color: Colors.blue[500],
            child: const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: visible,
              child: const CircularProgressIndicator(
                color: Colors.white,
              )),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(15),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Don\'t have an account ?',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(onPressed: () { gotoSecondActivity(context); },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Color(0xfff79c4f),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          /*TextButton(onPressed: (){}, child: const Text("Don't have an account?")),
                  SizedBox(
                      height: 50,
                      child: ElevatedButton(onPressed: () {}, child: const Text('REGISTER'))),*/


        ],
      ),

    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        gotoHomeActivity(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}


