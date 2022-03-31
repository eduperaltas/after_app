// @dart=2.9
import 'package:after_app/Users/UI/Screens/user_services.dart';
import 'package:after_app/Users/UI/Widgets/image_card_reserva.dart';
import 'package:after_app/Users/UI/Widgets/maps/search/maps1.dart';
import 'package:after_app/Users/model/barbers.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:after_app/Users/UI/Screens/detail_list_of_barber.dart';

import 'FirstView_User.dart';
import 'SeleccionReserva.dart';
class Services extends StatelessWidget {
  // This widget is the root of your application.
  String filtroInicial;
  Services(this.filtroInicial);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(filtroInicial),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String filtroInicial;
  MyHomePage(this.filtroInicial);
  @override
  _MyHomePageState createState() => _MyHomePageState();
  final star_full = Container(
      margin: EdgeInsets.only(
          top:  320.0,
          right : 3.0
      ),
      child: Icon(
        Icons.star,
        color: Color(0xffAD8B19),
        size: 50,
      )
  );
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}


class DropdownScreen extends StatefulWidget {
  String filtro;
  DropdownScreen(this.filtro);
  State createState() =>  DropdownScreenState(filtro);
}

class DropdownScreenState extends State<DropdownScreen> {
  MyPreferences _myPreferences = MyPreferences();
  Item selectedUser;
  String filtro;
  DropdownScreenState(this.filtro);
  List<Item> users = <Item>[
    const Item('Todos',Icon(Icons.person,color:  const Color(0xffAD8B19),)),
    const Item('Activos',Icon(Icons.notifications_active,color:  const Color(0xffAD8B19),)),
    const Item('Mas cercano',Icon(Icons.gps_fixed,color:  const Color(0xffAD8B19),)),
    const Item('Mejor calificacion',Icon(Icons.star,color:  const Color(0xffAD8B19),)),
  ];
  List<BarbersProfile> profiles = [];



  Widget SuperHeroCell(BuildContext ctx, int index, String filtro) {
    print('tamaño de lista en : SuperHeroCell'+profiles.length.toString());
    print('estado de barbero: '+profiles[index].active.toString());
    print('nombre de barbero: '+profiles[index].nameofbarber);

    final ThemeData _theme = Theme.of(context);

    if(filtro=='Todos'){
      return GestureDetector(
        onTap: () {
          final snackBar = SnackBar(content: Text("Tap"));
          Navigator.push(context, PageTransition(child: MyDetailPage1 (profiles[index]), type: PageTransitionType.rightToLeft));

        },
        child:Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    child: Hero(
                        tag: profiles[index],
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.all(8.0,),
                                height: 50.0,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(profiles[index].img,
                                        )
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color(0xffAD8B19),
                                          blurRadius: 15.0,
                                          offset: Offset(0.0, 0.7))]
                                )
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0,),
                              child: Text(
                                profiles[index].title, style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  starfull,
                                  starfull,
                                  starfull,
                                  starfull,
                                  starfull
                                ],
                              ),
                            ),

                            Container(
                              child: Icon(
                                Icons.adjust,

                                // color: Colors.green,
                                color: profiles[index].active ? Colors.green: Colors.red,
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            )
        )

      );
    }
    if(filtro=='Activos'){
    if(profiles[index].active){
      _myPreferences.contador++;
      return GestureDetector(
        onTap: () {
          Navigator.push(context, PageTransition(child: MyDetailPage1 (profiles[index]), type: PageTransitionType.rightToLeft));
        },
        child:Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Card(
                    child: Hero(
                        tag: profiles[index],
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.all(8.0,),
                                height: 50.0,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(profiles[index].img,
                                        )
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color(0xffAD8B19),
                                          blurRadius: 15.0,
                                          offset: Offset(0.0, 0.7))]
                                )
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0,),
                              child: Text(
                                profiles[index].title, style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  starfull,
                                  starfull,
                                  starfull,
                                  starfull,
                                  starfull
                                ],
                              ),
                            ),

                            Container(
                              child: Icon(
                                Icons.adjust,

                                // color: Colors.green,
                                color: profiles[index].active ? Colors.green: Colors.red,
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ],
          ),
        )

      );
    }
    if(!profiles[index].active){
      return SizedBox(
        height: 10,
      );
    }


    }



  }



  @override
  Widget build(BuildContext context) {
  int cont=0;
   if(filtro=='Todos'){
     return Stack(children: [
       StreamBuilder(
           stream: FirebaseFirestore.instance.collection('barbers').doc('profile')
               .collection('profile').snapshots(),
           builder: (context, snapshot) {
             if(!snapshot.hasData){
               return Center(
                   child:Container(child: CircularProgressIndicator()));
             }else{
               return ListView.builder(
                 shrinkWrap: true,
                 padding: EdgeInsets.only(top:50.0),
                 itemCount: snapshot.data.documents.length,
                 itemBuilder: (context, index) {
                   DocumentSnapshot profile = snapshot.data.documents[index];
                   BarbersProfile bp =BarbersProfile(img: profile['photo profile'],
                       title: profile['name'],body: profile['description'],Stars: 5,
                       nameofbarber: profile['name'],estudiosbarber: profile['study'],trabajobarber: profile['work'],
                       direccionbarber: profile['direction'],image1: profile['photo1'],image2: profile['photo2'],
                       image3:profile['photo3'],active:profile['active'],barberuid: profile['uid']);
                   profiles.add(bp);
                   return SuperHeroCell(context, index,filtro);
                 },
               );

             }
           }
       ),

       Container(
         color: Colors.white,
         width: MediaQuery.of(context).size.width,
         child: Padding(
           padding: const EdgeInsets.only(left:25,top:8.0),
           child: DropdownButton<Item>(
             hint: Row(
                children: <Widget>[
                  Icon(Icons.person,color:  const Color(0xffAD8B19)),
                   SizedBox(width: 10,),
                   Text(
                     'Todos',
                   style:  TextStyle(color: Colors.black),
                ),
                ],
                ),
             value: selectedUser,
             onChanged: (Item Value) {
               setState(() {
                 selectedUser = Value;
                 filtro=selectedUser.name;
               });

             },
             items: users.map((Item user) {
               return  DropdownMenuItem<Item>(
                 value: user,
                 child: Row(
                   children: <Widget>[
                     user.icon,
                     SizedBox(width: 10,),
                     Text(
                       user.name,
                       style:  TextStyle(color: Colors.black),
                     ),
                   ],
                 ),
               );
             }).toList(),
           ),
         ),
       ),


     ],
     );
   }

   if(filtro=='Activos'){
     return Stack(children: [
       StreamBuilder(
           stream: FirebaseFirestore.instance.collection('barbers').doc('profile')
               .collection('profile').snapshots(),
           builder: (context, snapshot) {
             if(!snapshot.hasData){
               return Center(
                   child:Container(child: CircularProgressIndicator()));
             }else{
               return ListView.builder(
                 padding: EdgeInsets.only(top:50.0),
                 itemCount: snapshot.data.documents.length,
                 itemBuilder: (context, index) {
                   DocumentSnapshot profile = snapshot.data.documents[index];
                   BarbersProfile bp =BarbersProfile(img: profile['photo profile'],
                       title: profile['name'],body: profile['description'],Stars: 5,
                       nameofbarber: profile['name'],estudiosbarber: profile['study'],trabajobarber: profile['work'],
                       direccionbarber: profile['direction'],image1: profile['photo1'],image2: profile['photo2'],
                       image3:profile['photo3'],active:profile['active'],barberuid: profile['uid']);
                   profiles.add(bp);
                   return SuperHeroCell(context, index,filtro);
                 },
               );

             }
           }
       ),
        _myPreferences.contador==0?Center():Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Center(
              child:Column(
                children: <Widget> [
                  Image.asset("assets/images/fotostrabajos.png"),
                  Text("Nuestros barberos descansan"),
                  Text("Reserva tu servicio aqui"),
                     SizedBox(
                    height: 40,
                    ),
                  FloatingActionButton.extended(
                    onPressed: () {
                         Navigator.push(context, PageTransition(child: FullPageClock(), type: PageTransitionType.rightToLeft));},
                    label: Text('Reserva tu servicio'),
                    icon: Icon(Icons.calendar_today),
                    backgroundColor: Color(0xffAD8B19),
                  ),
                ],
              )
          ),
        ),


       Container(
         color: Colors.white,
         width: MediaQuery.of(context).size.width,
         child: Padding(
             padding: const EdgeInsets.only(left:25,top:8.0),
             child: DropdownButton<Item>(
               hint:  Row(
                 children: <Widget>[
                   Icon(Icons.notifications_active,color:  const Color(0xffAD8B19)),
                   SizedBox(width: 10,),
                   Text(
                     'Activos',
                     style:  TextStyle(color: Colors.black),
                   ),
                 ],
               ),
               value: selectedUser,
               onChanged: (Item Value) {
                 setState(() {
                   selectedUser = Value;
                   filtro=selectedUser.name;
                 });

               },
               items: users.map((Item user) {
                 return  DropdownMenuItem<Item>(
                   value: user,
                   child: Row(
                     children: <Widget>[
                       user.icon,
                       SizedBox(width: 10,),
                       Text(
                         user.name,
                         style:  TextStyle(color: Colors.black),
                       ),
                     ],
                   ),
                 );
               }).toList(),
             ),
           ),
       ),




     ],
     );
   }

  }
}


class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'Barberos';

  _MyHomePageState() {
  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, PageTransition(child: FirstView(), type: PageTransitionType.rightToLeft));
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:Image.asset(
                'assets/images/Barba.png',
                height: MediaQuery.of(context).size.height*0.09,
              ),),
            Container(
              child: Text('BARBERS  HOME', style:
              TextStyle(
                color: Color(0xff222B45),
                fontWeight: FontWeight.w900,
                fontFamily: "The Foregen Rough One",
                fontSize: MediaQuery.of(context).size.height*0.05,
              ),
              ),
            ),
          ],
        ),),
      body: Container(
        child:  DropdownScreen(widget.filtroInicial),
      ),
    );


  }
}



final starfull = Container(
    margin: EdgeInsets.only(
        left : 3.0
    ),
    child: Icon(
      Icons.star,
      color: Color(0xFFf2C611),
      size: 10,
    )
);
