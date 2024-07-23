import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pingpong/constants.dart';
import 'package:pingpong/helper/show_snack_bar.dart';
import 'package:pingpong/views/chat_view.dart';
import 'package:pingpong/widgets/custom_button.dart';
import 'package:pingpong/widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      color: Colors.white,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 50,),
                  SizedBox(
                    //color: Colors.white,
                    width: 350,height: 200,
                    child: Image.asset('assets/chat.png'),
                  ),
                  const SizedBox(height: 16,),
                  const Center(
                    child: Text(
                      'Ping-Pong',
                      style: TextStyle(
                        fontFamily: kFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: 64,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: kFont,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,fontSize: 32,
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
                          await registerUser(auth);
                          Navigator.pushNamed(context, ChatView.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context,'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,'The account already exists for that email.');
                          }
                        } catch(e){
                          showSnackBar(context, 'Something went wrong');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                      else{

                      }
                    },
                    buttonName: 'REGISTER',
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Text(
                        'already have an account! ',
                        style: TextStyle(
                          fontFamily: kFont,fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
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

  Future<void> registerUser(FirebaseAuth auth) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
