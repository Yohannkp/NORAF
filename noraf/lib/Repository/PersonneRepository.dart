import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import '../Model/Personne.dart';
class PersonneRepository{

 final FirebaseAuth _auth = FirebaseAuth.instance;

readPersonne(Personne personne) async
{final docPersonne = FirebaseFirestore.instance.collection('Personne').doc(personne?.uid);
final snapshot = await docPersonne.get();if(snapshot.exists){
return Personne.fromJson(snapshot.data()!);
}}

Stream<List<Personne>> readAllPersonne()=>FirebaseFirestore.instance.collection('Personne').snapshots().map((snapshot) => snapshot.docs.map((doc) =>Personne.fromJson(doc.data())).toList());


Future UpdatePersonne(Personne Personne) async{


final docPersonne = FirebaseFirestore.instance.collection('Personne').doc(Personne.uid);


 docPersonne.update({'id_user' : Personne.id_user,'nom' : Personne.nom,'prenom' : Personne.prenom,'address' : Personne.address,'numero_telephone' : Personne.numero_telephone,'email' : Personne.email,'motdepass' : Personne.motdepass,'sexe' : Personne.sexe,'date_naissance' : Personne.date_naissance,'role' : Personne.role});

}


deletePersonne(Personne Personne) async {
final docPersonne = FirebaseFirestore.instance.collection('Personne').doc(Personne.uid);
 docPersonne.delete();
}


Future<String?> AjoutPersonne(Personne Personne) async{
final docPersonne = FirebaseFirestore.instance.collection('Personne').doc(Personne.uid);
String path = docPersonne.path.split('/')[1];
Personne.uid = path;
Personne.id_user = Personne.uid;
final data = Personne.toJson();
docPersonne.set(data);
print("Ajout effectué");
return path;
}

Future<Personne?> readOnlineUser() async {

 //print("Nous recherchon l'utilisarteur : "+_auth.currentUser!.uid);

 final docUser = FirebaseFirestore.instance.collection("Personne").doc(_auth.currentUser!.uid);
 final snapshot = await docUser.get();

 if(snapshot.exists)
 {
  final nomnre = Personne.fromJson(snapshot.data()!);

  return Personne.fromJson(snapshot.data()!);
 }

 return null;


}



}