import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uberme/authentication/car_info_screen.dart';
import 'package:uberme/authentication/login_screen.dart';
import 'package:uberme/widgets/progress_dialog.dart';

import '../global/global.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nomTextEditingController =TextEditingController() ;
  TextEditingController emailTextEditingController =TextEditingController() ;
  TextEditingController phoneTextEditingController =TextEditingController() ;
  TextEditingController passwordTextEditingController =TextEditingController() ;


  validateForm() {
    if (nomTextEditingController.text.length < 3){
      Fluttertoast.showToast(msg: "le nom doit contenir au moins 3 caracteres. ");
    }
    else if(emailTextEditingController.text.isEmpty||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailTextEditingController.text))
    {
      Fluttertoast.showToast(msg: "Email non valide ");
    }else if(phoneTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Numero necessaire. ");
    }else if(passwordTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Password doit contenir au moins 6 caracteres. ");
    }else{
     saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Chargement ....",);
        });
    final User? firebaseUser= (
        await fAuth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error:"+msg.toString());
        })
    ).user;
    if(firebaseUser != null){
      Map driverMap =
          {
            "id":firebaseUser.uid,
            "nom":nomTextEditingController.text.trim(),
            "email":emailTextEditingController.text.trim(),
            "phone":phoneTextEditingController.text.trim(),
          };

      DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers");
      driverRef.child(firebaseUser.uid).set(driverMap);
      currentFirebaseUser =firebaseUser;
      Fluttertoast.showToast(msg: "Le compte a ??t?? creer");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Compte non cree");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Image.asset("images/carpool1.png"),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Enregistrer comme Conducteur",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
              ),
              TextField(
                  controller: nomTextEditingController,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Nom",
                    hintText: "Entrer votre nom",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                  )
              ),

              TextField (
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Entrer votre email",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                  )
              ),

              TextField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "Entrer votre numero",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                  )
              ),

              TextField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Entrer votre password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                  )
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: (){
                    validateForm();
                  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent,
                ),
                  child: const Text(
                    "Creer un compte",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
                child:const Text(
                  "Se connecter a son compte",
                  style: TextStyle(
                    color: (Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
