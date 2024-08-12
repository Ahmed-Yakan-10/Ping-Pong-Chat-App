import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pingpong/constants.dart';
import 'package:pingpong/helper/show_snack_bar.dart';
import 'package:pingpong/views/chat_view.dart';
import 'package:pingpong/views/register_view.dart';
import 'package:pingpong/widgets/custom_button.dart';
import 'package:pingpong/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final IconData eIcon = Icons.email_outlined;
  final IconData pIcon = Icons.password;

  String? email;

  String? password;

  GlobalKey<FormState> formKey= GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 50,),
                  SizedBox(
                    //color: Colors.white,
                    width: 300,height: 175,
                    child: Image.asset('assets/chat.png'),
                  ),
                  const SizedBox(height: 16,),
                  const Center(
                    child: Text(
                      'Ping-Pong',
                      style: TextStyle(
                        fontFamily: kFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: kFont,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  CustomFormTextField(
                    onChanged: (data){
                      email = data;
                    },
                      labelText: 'Email',
                      icon: eIcon,
                    ),
                  const SizedBox(height: 16,),
                  CustomFormTextField(
                    onChanged: (data){
                      password = data;
                    },
                      labelText: 'Password',
                      icon: pIcon,
                    obscureText: true,
                    ),
                  const SizedBox(height: 16,),
                  CustomButton(
                    onTap: ()async{
                      var auth = FirebaseAuth.instance;
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser(auth);
                          Navigator.pushNamed(context, ChatView.id, arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context,'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,'Wrong password provided for that user.');
                          }
                        } catch(e){
                          print(e);
                          showSnackBar(context, 'Something went wrong');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                      else{}
                    },
                    buttonName: 'LOGIN',
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          fontFamily: kFont,fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RegisterView.id);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: kFont,fontSize: 20,
                            color: Colors.blueAccent.shade100,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blueAccent.shade100,
                            decorationThickness: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(FirebaseAuth auth) async {
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
