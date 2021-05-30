import 'package:flutter/material.dart';
import 'package:hackon/helper/helperFunctions.dart';
import 'package:hackon/services/auth.dart';
import 'package:hackon/views/chatRooms.dart';
import 'package:hackon/widgets/widget.dart';
import 'package:hackon/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();
  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  signMeUp() async{
    if(formKey.currentState.validate()){
      Map <String, String> userInfoMap = {
        "name": userName.text,
        "email": email.text,
      };
      HelperFunctions.saveUserEmailSharedPreference(email.text);
      HelperFunctions.saveUserNameSharedPreference(userName.text);

      setState(() {
        isLoading = true;
      });

      await authMethods.
      signInWithEmailAndPassword(email.text, password.text).then((val) async{
        print('$val');
        dataBaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.blueGrey,
          title: Text("Roving Retirees", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, fontFamily: 'Pacifico', color: Colors.white)),
        ),
        body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator(


          )),
        ):
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/Images/signin.jpeg"), fit: BoxFit.cover),
            ),
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
                        validator: (val){
                          return val.isEmpty? "Please enter a username": null;
                        },
                        controller: userName,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Username"),
                      ),
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                          null : "Enter correct email";
                          },
                        controller: email,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length < 6 ? "Please enter a password of 6+ characters": null;
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
                  onTap: () => signMeUp(),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("SignUp", style: simpleTextStyle(),),
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
                  child: Text("Sign Up with Google", style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17
                  ),),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: simpleTextStyle()),
                    GestureDetector(
                      onTap: () => widget.toggle(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        child: Text("Sign In", style: TextStyle(
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
        ),
    );
  }
}
