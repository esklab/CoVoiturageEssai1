import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uberme/global/global.dart';
import 'package:uberme/splash_screen/splash_screen.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController carModelTextEditingController =TextEditingController() ;
  TextEditingController carNumberTextEditingController =TextEditingController() ;
  TextEditingController carColorTextEditingController =TextEditingController() ;
  List<String> carTypesList =["Voiture","Moto","Bus","Autres"];
  String? selectedCarType;

  saveCarInfo(){
    Map driverCarInfoMap =
    {
      "car_color":carColorTextEditingController.text.trim(),
      "car_number":carNumberTextEditingController.text.trim(),
      "car_model":carModelTextEditingController.text.trim(),
      "type":selectedCarType,
    };
    DatabaseReference driverCarInfoRef = FirebaseDatabase.instance.ref().child("drivers");
    driverCarInfoRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
    Fluttertoast.showToast(msg: "Informations du vehicule enregistrer");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Image.asset("images/carpool1.png"),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Vehicule Details",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
              ),

              TextField(
                  controller: carModelTextEditingController,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Vehicule Modele",
                    hintText: "Entrer le modele de la voiture",
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
                  controller: carNumberTextEditingController,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Immatriculation",
                    hintText: "Entrer votre Immatriculation",
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
                  controller: carColorTextEditingController,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Couleur",
                    hintText: "Entrer la couleur de la voiture",
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

              const SizedBox(height: 10,),

              DropdownButton(
                iconSize: 26,
                dropdownColor: Colors.white24,
                hint: const Text(
                  "Choissisez un type de voiture",
                  style: TextStyle(
                    fontSize: 14.0,
                    color:Colors.grey,
                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue){
                  setState(() {
                    selectedCarType =newValue.toString();
                  });
                },
                items: carTypesList.map((car){
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    value: car,
                  );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: (){
                  if(carColorTextEditingController.text.isNotEmpty
                      && carNumberTextEditingController.text.isNotEmpty
                      && carModelTextEditingController.text.isNotEmpty
                      && selectedCarType!=null)
                  {
                    saveCarInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent,

                ),
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
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
