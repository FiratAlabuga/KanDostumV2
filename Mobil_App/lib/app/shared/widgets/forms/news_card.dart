import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HbrKart extends StatefulWidget {
  @override
  _HbrKartState createState() => _HbrKartState();
}

class _HbrKartState extends State<HbrKart> {
  Firestore _firestore;
  @override
  void initState() {
    super.initState();
    _firestore = Firestore.instance;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Web Kan İstekleri'
        ),
        automaticallyImplyLeading: true,
      ),
            body: StreamBuilder(
        stream: _firestore.collection('Web_Users').snapshots(),
        builder: (context, snapshot){

              if (snapshot.hasData){
                var trains = snapshot.data.documents;
                List<Card> allTrains = [];
                for (var doc in trains){
                  final adSoyad = doc.data['adSoyad'];
                  final telefonNu = doc.data['telefonNu'];
                  final kanGrubu = doc.data['kanGrubu'];
                  final email=doc.data['email'];
                  final mesaj=doc.data['varsaMesaj'];
                  //final mesaj="Merhaba Ben $adSoyad, acil $kanGrubu tipi kana ihtiyacımız vardır. Şuan ki konum:$adres , İletişim Kurmak İçin Bana Ulaşın.";

                  final listTile = Card(
                    elevation: 4,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '$adSoyad',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Kullanıcının Mesajı: $mesaj',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 30,
                              child: Text(
                                '$kanGrubu',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.location_on, color: Colors.red,),
                                      SizedBox(width: 5,),
                                      Text(
                                        '$email',
                                        style: TextStyle(
                                          color: Colors.red
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: (){
                                      //_guncelPuan();
                                      launch("tel://$telefonNu");
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.call, color: Colors.red,),
                                        SizedBox(width: 5,),
                                        Text(
                                          'Ara: $telefonNu',
                                          style: TextStyle(
                                            color: Colors.red
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      launch("sms://$telefonNu");
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.message, color: Colors.red,),
                                        SizedBox(width: 5,),
                                        Text(
                                          'SMS: $telefonNu',
                                          style: TextStyle(
                                            color: Colors.red
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  );
                  allTrains.add(listTile);
                }
                return ListView(
                  children: allTrains,
                );
              } else {
                return Center(
                  child: Text(
                    'Kan İsteği Boş!'
                  ),
                );
              }

        },
      )
    );
  }
}