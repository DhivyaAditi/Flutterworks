import 'dart:io';

import 'package:chatapp/widgets/userimage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var islogin = true;
  final _formkey = GlobalKey<FormState>();
  var _enteredemail = '';
  var _enteredpasswrd = '';
  var _enteredname='';
  var isuploading=false;
  File? _selectedImage;
  void _login() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        setState(() {
          isuploading=true;
        });
        if (islogin) {
          //to check wheter mail and password we need email and password
          //final userCredentials =
          await _firebase.signInWithEmailAndPassword(
              email: _enteredemail, password: _enteredpasswrd);
        } else {
          //to create new user with mail and password
          //we need mail and passwrd
          final userCredentials =
          await _firebase.createUserWithEmailAndPassword(
              email: _enteredemail, password: _enteredpasswrd);
        //  final storedimage=  FirebaseStorage.instance.ref().child('user_images').child('${userCredentials.user!.uid}.jpg');
        //    await storedimage.putFile(_selectedImage!);
        //    //stores image in firebase
        //    await storedimage.getDownloadURL();
           await FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid).set({
             'name':_enteredname,
              'emai':_enteredemail
           });
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ));
        setState(() {
          isuploading=false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Authentication',
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 20, right: 20),
                  width: 200,
                  child: Image.asset('assets/images/chat.jpeg')),
              Card(
                shadowColor: Theme.of(context).colorScheme.primary,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (islogin == false)
                          UserImage(
                            onselected: (image) {
                              _selectedImage = image;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Enter the valid email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _enteredemail = value;
                          },
                        ),
                        if(islogin==false)
                        TextFormField(
                          decoration:const InputDecoration( labelText:'Name'),
                          validator: (value){
                            if(value==null||value.trim().isEmpty||value.trim().length<3){
                              return 'Name must be atleast 3 characters long';
                            }
                            return null;
                          },
                          onChanged: (value){
                            _enteredname=value;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'password'),
                          obscureText: true,
                          //the person behind the app don't know what passwrd was entered
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return "Password must be atleast 6 characters long";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _enteredpasswrd = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if(isuploading)
                          const CircularProgressIndicator()
                          else
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          onPressed: _login,
                          child: Text(islogin ? 'login' : 'signup'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if(isuploading)
                        const CircularProgressIndicator()
                        else
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              islogin = !islogin;
                            });
                          },
                          child: Text(islogin
                              ? 'createaccount'
                              : 'Already have an account'),
                        )
                      ],
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
