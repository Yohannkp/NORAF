import 'package:flutter/material.dart';
import 'package:noraf/Repository/PersonneRepository.dart';
import 'package:noraf/Repository/logementRepository.dart';

import '../../Model/logement.dart';
Widget Reservation() {
  PersonneRepository pr= new PersonneRepository();
  logementRepository lr = new logementRepository();
  return FutureBuilder(future: pr.readOnlineUser(),
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
              return logements.isEmpty ? Center(child: Text("Aucun enregistrement trouvé"),) : ListView.builder(
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
                            print("Touché container numero : "+index.toString());

                          },
                        )
                      ],
                    ),
                  );
                },

              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        );

      });
}

