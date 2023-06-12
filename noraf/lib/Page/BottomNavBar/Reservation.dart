import 'package:flutter/cupertino.dart';
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
                            elevation: 3,

                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(

                                    children: [
                                      Icon(Icons.image,size: 150,)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${logements[index].titre}"),
                                      Text("${logements[index].region}"),
                                      Text("${logements[index].address}"),
                                      SizedBox(height: 30,),
                                      Text("${logements[index].prix} FCFA")
                                    ],
                                  ),
                                  Column(

                                    children: [
                                      Icon(CupertinoIcons.suit_heart_fill,color: Colors.red,),
                                      SizedBox(
                                        height: 55,
                                      ),

                                      Icon(Icons.star,size: 15,color: CupertinoColors.activeOrange,),
                                      SizedBox(
                                        width: 80,
                                      )
                                    ],
                                  )
                                ],
                              ),
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

