import 'package:bridgeup/dashboard.dart';
import 'package:bridgeup/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  _RegisterState();

  bool showProgress = false;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  String error ='';
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;


  gotoLoginActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
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
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blueGrey,

        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:   [
            const SizedBox(
              height: 20,
            ),
            const Center(

              child: Text ('CREATE NEW ACCOUNT',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(

                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter Full Name',
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
                    return "Name cannot be empty";
                  }
                  if (!RegExp(
                      "^[a-zA-Z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid name");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: mobile,
                decoration: const InputDecoration(

                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mobile number',
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
                    return "Mobile number  cannot be empty";
                  }
                  if (!RegExp(
                      "^[+0-9]")
                      .hasMatch(value)) {
                    return ("Please enter a valid Surname");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
                keyboardType: TextInputType.number
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter email address',
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
                onChanged: (value) {},
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText: _isObscure,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(_isObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  enabled: true,
                  contentPadding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    return ("please enter valid password with minimum of 6 character");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            obscureText: _isObscure2,
            controller: confirmpassController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(_isObscure2
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure2 = !_isObscure2;
                    });
                  }),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Confirm Password',
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
              if (confirmpassController.text !=
                  passwordController.text) {
                return "Password does not  match";
              } else {
                return null;
              }
            },
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          height: 20,
        ),


            MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(20.0))),
              elevation: 5.0,
              height: 50,
              minWidth: 200,

              onPressed: () {
                setState(() {
                  showProgress = true;
                });
                signUp(
                  emailController.text,
                  passwordController.text,
                );
              },


              color: Colors.blue[500],
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(15),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account ?',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(onPressed: () { gotoLoginActivity(context); },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color(0xfff79c4f),
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
 Future signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).whenComplete(() => gotoHomeActivity);


      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }

      } catch (e) {
        print(e);
      }
    }

    const CircularProgressIndicator();
  }
}
