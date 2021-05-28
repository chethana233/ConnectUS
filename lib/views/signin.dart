import 'package:flutter/material.dart';
import 'package:hackon/widgets/widget.dart';
import 'package:hackon/services/auth.dart';
import 'package:hackon/services/database.dart';
import 'package:hackon/helper/helperFunctions.dart';
import 'package:hackon/views/chatrooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  signIn() async {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(email.text);


      await authMethods
          .signInWithEmailAndPassword(
          email.text, password.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfo =
          await dataBaseMethods.getUsersByEmail(email.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfo.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfo.documents[0].data["userEmail"]);
          setState(() {
            isLoading = true;
          });

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>
              ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height - 100,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: email,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Email"),
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.length > 6
                            ? null
                            : "Enter Password 6+ characters";
                      },
                      controller: password,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Password"
                      ),
                    ),
                  ],
                   
                ),
              ),
              

              SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Forgot Password", style: simpleTextStyle()),
                ),
              ),

              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () => signIn(),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("SignIn", style: simpleTextStyle(),),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Sign In with Google", style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17
                ),),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: simpleTextStyle()),
                  GestureDetector(
                    onTap: () => widget.toggle(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      child: Text("Register now", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline
                      ),),
                    ),
                  )

                ],
              ),
              SizedBox(height: 40,),


            ],
          ),
        ),
      )
    );
  }
}

