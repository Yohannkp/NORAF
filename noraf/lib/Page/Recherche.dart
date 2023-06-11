import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noraf/Model/logement.dart';
import 'package:noraf/Repository/PersonneRepository.dart';
import 'package:noraf/Repository/logementRepository.dart';
class Recherche extends StatefulWidget {
  const Recherche({super.key});

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  TextEditingController _textEditingController = TextEditingController();
  PersonneRepository pr= new PersonneRepository();
  logementRepository lr = new logementRepository();
  String searchQuery = '';
  List<logement> people = [];
  List<logement> logementv = [];

  @override
  Widget build(BuildContext context) {



    const duration = Duration(seconds: 3);
    Timer(duration, () {
      List<logement> searchResults = lr.searchPeople(people, searchQuery);
      if (searchResults.isNotEmpty) {

        for (logement log in searchResults) {

          setState(() {

            people = searchResults;
            logementv = searchResults;

          });
        }
      } else {

        setState(() {
          logementv = [];
        });
      }

    });

    return Scaffold(
      appBar: new AppBar(
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(

            labelText: 'Entrez votre texte',

            // Ajoutez ici d'autres propriétés de décoration si nécessaire
          ),
          onChanged: (value) {
            // Vous pouvez effectuer des actions lorsque le texte change

            setState(() {
              searchQuery = value;
            });
          },
        ),
      ),
      body: FutureBuilder(future: pr.readOnlineUser(),
          builder: (context,snapshot){
            return StreamBuilder<List<logement>>(
              stream: lr.readAlllogement(),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  print(snapshot.error);
                  return Center(child: Text("Une erreur s'est produite...",));
                }
                else if(snapshot.hasData){
                  final logements = snapshot.data!;
                  people = logements;
                  return logements.isEmpty ? Center(child: Text("Aucun enregistrement trouvé"),) : searchQuery==""?ListView.builder(
                    itemCount: logements.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Card(
                                elevation: 5,

                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      width: MediaQuery.of(context).size.width*0.9,

                                      child: Column(
                                        children: [
                                          Container(

                                            width: MediaQuery.of(context).size.width,
                                            height : 80,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Nom de la region : ${logements[index].region}"),
                                                Text("Coordonnées : ${logements[index].coordonnees}")
                                              ],
                                            ),
                                          ),




                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){


                              },
                            )
                          ],
                        ),
                      );
                    },

                  ) : ListView.builder(
                    itemCount: logementv.length,
                    itemBuilder: (BuildContext context, int index) {
                      return logementv != []? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Card(
                                elevation: 5,

                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      width: MediaQuery.of(context).size.width*0.9,

                                      child: Column(
                                        children: [
                                          Container(

                                            width: MediaQuery.of(context).size.width,
                                            height : 80,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Nom de la region people: ${logementv[index].region}"),
                                                Text("Coordonnées : ${logementv[index].coordonnees}")
                                              ],
                                            ),
                                          ),




                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){
                                print("Touché container numero : "+index.toString());

                              },
                            )
                          ],
                        ),
                      ): Text("Aucun élément correspondant à la recherche",style: TextStyle(color: Colors.black),);
                    },

                  );
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            );

          })
    );
  }
}
