import 'package:expenses/auth.dart';
import 'package:expenses/database.dart';
import 'package:expenses/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'postOferta.dart';
import 'ofertaList.dart';
import 'profile.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseUser user;

  
  MyHomePage(this.user);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PostOferta> ofertas = [];

  void addOfertas(PostOferta oferta){
    this.ofertas.add(oferta);
  }

  void newOferta(String nombre, String descripcion, String codigo){
    var post = new PostOferta(nombre, widget.user.displayName, descripcion, codigo);
    
    post.setId(saveOferta(post)); 
    this.setState(() {
      ofertas.add(post);

    });
  }

  void updateOfertas() {
    getAllOfertas().then((ofertas) => {
      this.setState(() {
        this.ofertas = ofertas;
      })
    });

  }

  @override
  void initState() {
    updateOfertas();
    super.initState();
  }

  int selected = 0;
  drawerItem(int pos){
    switch(pos){
      case 0: return OfertaList(this.ofertas, widget.user);
                      
      case 1: return Profile(widget.user, this.addOfertas);

      case 2: {signOutGoogle();
                return LoginPage();}
    }
  }

  onSelected(int pos){
    Navigator.of(context).pop();
    setState(() {
      
    selected = pos;
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName) , 
              accountEmail: Text(widget.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.photoUrl),
                backgroundColor: Colors.blue,
              )
              ),
            ListTile(
              title: Text('FEED'),
              leading: Icon(Icons.people_alt),
              selected: (0 == selected),
              onTap: (){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => MyHomePage(widget.user)));
                onSelected(0);
              }
            ),
            ListTile(
              title: Text('PERFIL'),
              leading: Icon(Icons.person),
              selected: (1 == selected),
              onTap:(){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => Profile())); 
                onSelected(1);
              } 
            ),
            ListTile(
              title: Text('LOGOUT'),
              leading: Icon(Icons.logout),
              selected: (2 == selected),
              onTap:(){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => Profile())); 
                onSelected(2);
              } 
            ),
          ]
        ),
      ),
      body: drawerItem(selected));
  }


}