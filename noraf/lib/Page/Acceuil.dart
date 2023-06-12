import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:noraf/Model/Personne.dart';
import 'package:noraf/Page/BottomNavBar/Acceuil.dart';

import 'package:noraf/Page/BottomNavBar/Reservation.dart';
import 'package:noraf/Page/BottomNavBar/Settings.dart';
import 'package:noraf/Page/Recherche.dart';
import 'package:noraf/Page/connexion.dart';
import 'package:noraf/Page/no_connexion.dart';
import 'package:noraf/Repository/AuthentificationService.dart';
import 'package:noraf/Repository/PersonneRepository.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../Model/user.dart';
import 'Form.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  AuthentificationService _authentificationService = new AuthentificationService();
  PersonneRepository personneRepository = new PersonneRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool connected = false;
  String nom = "";
  int page = 0;
  TextEditingController _textEditingController = TextEditingController();


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    onlineuser();
    if(_auth.currentUser?.uid != null){
      setState(() {
        connected = true;
      });
    }else{
      setState(() {
        connected = false;
      });
    }
  }
  Future<Personne?> onlineuser() async{
    Personne? onlineuser= await personneRepository.readOnlineUser();
    if(onlineuser?.uid != null)
      {
        return onlineuser;
      }
    else{
      return null;
    }
  }





  bool internet = true;

  void ConnexionChecker() async{
    bool result = await InternetConnectionCheckerPlus().hasConnection;
    if(result == true) {
      setState(() {
        //internet = true;
      });
    } else {
      setState(() {
        //internet = false;
      });
    }
  }




  @override
  Widget build(BuildContext context){
    ConnexionChecker();
    return internet == true?Scaffold(

      appBar: AppBar(
        title: page==0?Text("Home"):page==5?Text("Recherche"):page==1?Text("Reservation"):page==2?Text("Setting"):Text(""),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Recherche()));

          }, child: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder(future: onlineuser(),
          builder: (context,snapshot){

              if(page == 0){
                return Acceuil_nav_bar();
              }else if(page == 1){
                return Reservation();
              }else if(page == 2){
                return Settings(connected,context);
              }
              return Center(child: Text("User off-line"),);
            }

          ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,

        color: Colors.blue,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index){
            print(index);
            setState(() {
              page = index;
            });
        },
        items: [
        Icon(Icons.home,color: Colors.white,),
        Icon(Icons.bed,color: Colors.white,),
          Icon(Icons.settings,color: Colors.white,)
      ],),
    ) : Scaffold(
      body: no_connexion(),
    );
  }
}


