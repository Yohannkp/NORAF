import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:noraf/Model/logement.dart';
import 'package:path/path.dart' as Path;
class logementRepository{

readlogement(logement Logement) async
{final doclogement = FirebaseFirestore.instance.collection('logement').doc(Logement?.uid);
final snapshot = await doclogement.get();if(snapshot.exists){
return logement.fromJson(snapshot.data()!);
}}

Stream<List<logement>> readAlllogement()=>FirebaseFirestore.instance.collection('logement').snapshots().map((snapshot) => snapshot.docs.map((doc) =>logement.fromJson(doc.data())).toList());


Future Updatelogement(logement logement) async{


final doclogement = FirebaseFirestore.instance.collection('logement').doc(logement.uid);


 doclogement.update({'id_logement' : logement.id_logement,'image' : logement.image,'description' : logement.description,'titre' : logement.titre,'address' : logement.address,'prix' : logement.prix,'region' : logement.region,'options' : logement.options,'coordonnees' : logement.coordonnees,'statut' : logement.statut,});

}


deletelogement(logement logement) async {
final doclogement = FirebaseFirestore.instance.collection('logement').doc(logement.uid);
 doclogement.delete();
}


Future<String?> Ajoutlogement(logement logement) async{
final doclogement = FirebaseFirestore.instance.collection('logement').doc();
String path = doclogement.path.split('/')[1];
logement.uid = path;
logement.id_logement = logement.uid;
final data = logement.toJson();
doclogement.set(data);
return path;
}

int calculateLevenshteinDistance(String a, String b) {
 if (a.isEmpty) return b.length;
 if (b.isEmpty) return a.length;

 List<List<int>> matrix = List<List<int>>.generate(
  a.length + 1,
      (_) => List<int>.filled(b.length + 1, 0),
 );

 for (int i = 0; i <= a.length; i++) {
  matrix[i][0] = i;
 }

 for (int j = 0; j <= b.length; j++) {
  matrix[0][j] = j;
 }

 for (int i = 1; i <= a.length; i++) {
  for (int j = 1; j <= b.length; j++) {
   int substitutionCost = (a[i - 1] != b[j - 1]) ? 1 : 0;
   matrix[i][j] = <int>[matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1] + substitutionCost]
       .reduce((int min, int val) => val < min ? val : min);
  }
 }

 return matrix[a.length][b.length];
}


List<logement> searchPeople(List<logement> list, String searchQuery) {
 List<logement> results = [];

 for (logement log in list) {
  int distance = calculateLevenshteinDistance(log.region.toLowerCase(), searchQuery.toLowerCase());

  // Vous pouvez ajuster cette valeur pour déterminer la tolérance de correspondance
  // Plus la valeur est basse, plus la correspondance doit être proche
  int threshold = 5;

  if (distance <= threshold) {
   results.add(log);
  }
 }

 return results;
}

}