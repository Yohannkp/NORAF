import 'package:flutter/material.dart';
import 'package:noraf/Model/Personne.dart';
import 'package:noraf/Model/logement.dart';
import 'package:noraf/Page/connexion.dart';
import 'package:noraf/Repository/AuthentificationService.dart';
import 'package:noraf/Repository/PersonneRepository.dart';
import 'package:noraf/Repository/logementRepository.dart';

import '../Acceuil.dart';
Widget Settings(bool connected,context) {
  PersonneRepository pr  = new PersonneRepository();
  List<Personne> people = [
    Personne(role: "role", uid: "uid", id_user: "id_user", nom: "hedranawoe", prenom: "prenom", address: "address", numero_telephone: "numero_telephone", email: "email", motdepass: "motdepass", sexe: "sexe", date_naissance: "date_naissance"),
    Personne(role: "role", uid: "uid", id_user: "id_user", nom: "logoppe", prenom: "prenom", address: "address", numero_telephone: "numero_telephone", email: "email", motdepass: "motdepass", sexe: "sexe", date_naissance: "date_naissance"),
    Personne(role: "role", uid: "uid", id_user: "id_user", nom: "agoe", prenom: "prenom", address: "address", numero_telephone: "numero_telephone", email: "email", motdepass: "motdepass", sexe: "sexe", date_naissance: "date_naissance"),
    Personne(role: "role", uid: "uid", id_user: "id_user", nom: "zanguera", prenom: "prenom", address: "address", numero_telephone: "numero_telephone", email: "email", motdepass: "motdepass", sexe: "sexe", date_naissance: "date_naissance"),
    Personne(role: "role", uid: "uid", id_user: "id_user", nom: "lomingan", prenom: "prenom", address: "address", numero_telephone: "numero_telephone", email: "email", motdepass: "motdepass", sexe: "sexe", date_naissance: "date_naissance")


  ];

  String searchQuery = 'logope';


  return FutureBuilder(future: pr.readOnlineUser(),
      builder: (context,snapshot){
        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                connected== false?
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),onPressed: (){
                  connected = false;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginForm()));
                }, child: Text("Se Connecter",style: TextStyle(color: Colors.white),))

                    :


                Container(
                  child: Column(
                    children: [
                      Text(snapshot.data?.nom == null ?"Chargement...":"Nom : ${snapshot.data!.nom}"),
                      Text(snapshot.data?.prenom == null ?"Chargement...":"Prenom : ${snapshot.data!.prenom}"),
                      Text(snapshot.data?.address == null ?"Chargement...":"address : ${snapshot.data!.address}"),
                      Text(snapshot.data?.email == null ?"Chargement...":"email : ${snapshot.data!.email}"),
                      Text(snapshot.data?.numero_telephone == null ?"Chargement...":"Telephone : ${snapshot.data!.numero_telephone}"),
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){
                        AuthentificationService _auth = new AuthentificationService();
                        _auth.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Acceuil()));
                      }, child: Text("Se déconnecter",style: TextStyle(color: Colors.white),)),
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      });
}
