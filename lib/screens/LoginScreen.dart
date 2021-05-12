import 'package:bloc_tuts/providers/AccountProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (consumerContext, accountProvider, consumerWidget) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            height: 550,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _loginKey,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://pngimg.com/uploads/netflix/netflix_PNG11.png',
                    imageBuilder: (imageContext, imageProvider) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (stringToValidate) {
                        if (stringToValidate == "kingchaithu14@gmail.com") {
                          return null;
                        }
                        return "Enter the correct email address";
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        counterStyle: TextStyle(color: Colors.white),
                        enabledBorder: new UnderlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: new UnderlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (stringToValidate) {
                        if (stringToValidate == "chaithU123") {
                          return null;
                        }
                        return "Enter the correct password";
                      },
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: new UnderlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: new UnderlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      if (_loginKey.currentState.validate()) {
                        print("Success");
                        accountProvider.login();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
