import 'package:cloud_firestore/cloud_firestore.dart';
class Personne {
 String uid;
 String id_user;
 String nom;
 String prenom;
 String address;
 String numero_telephone;
 String email;
 String motdepass;
 String sexe;
 String date_naissance;
 String role;
Personne({required this.role,required this.uid,required this.id_user,required this.nom,required this.prenom,required this.address,required this.numero_telephone,required this.email,required this.motdepass,required this.sexe,required this.date_naissance,});

Map<String, dynamic> toJson(){
return{
'uid' : uid ,
'id_user' : id_user ,
'nom' : nom ,
'prenom' : prenom ,
'address' : address ,
'numero_telephone' : numero_telephone ,
'email' : email ,
'motdepass' : motdepass ,
'sexe' : sexe ,
'date_naissance' : date_naissance ,
 'role' : role
};}
static Personne fromJson(Map<String,dynamic> json) => Personne(uid: json['uid'],id_user: json['id_user'],nom: json['nom'],prenom: json['prenom'],address: json['address'],numero_telephone: json['numero_telephone'],email: json['email'],motdepass: json['motdepass'],sexe: json['sexe'],date_naissance: json['date_naissance'],role: json['role']);

}