import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noraf/Model/Personne.dart';
import 'package:noraf/Page/Acceuil.dart';
import 'package:noraf/Page/Form.dart';
import 'package:noraf/Page/connexion.dart';
import 'package:noraf/Repository/AuthentificationService.dart';
import 'package:noraf/Repository/PersonneRepository.dart';
import 'package:provider/provider.dart';

import '../Model/user.dart';
class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);
    final AuthentificationService _authService = AuthentificationService();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final userconnected = _authService;
    if(_auth.currentUser?.uid == null){
      print("User disconnected");
      return LoginForm();
    }else{
      print("User connected");
      final uid = _auth.currentUser!.uid;
      Personne p = new Personne(role: "role", uid: "$uid", id_user: "id_user", nom: "nom", prenom: "prenom", address: "address", numero_telephone: "numero_telephone", email: "email", motdepass: "motdepass", sexe: "sexe", date_naissance: "date_naissance");

      PersonneRepository pr = new PersonneRepository();
      return FutureBuilder(future: pr.readOnlineUser(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.done){


                if(snapshot.data?.role == "admin"){
                  return Scaffold(
                    appBar: new AppBar(
                      title: Text("Page Admin"),
                      actions: [ElevatedButton(onPressed: (){
                        _auth.signOut();
                      }, child: Text("log out"))],
                    ),
                  );
                }if(snapshot.data?.role == "user"){
                  return Acceuil();
              }

              return Center();
            }
            return Center();
          });
    }
    }
}