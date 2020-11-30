
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'postOferta.dart';
import 'textInputWidget.dart';


class Profile extends StatefulWidget {
  final FirebaseUser user;
  final Function(PostOferta) callback;
  
  Profile(this.user, this.callback);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  

   void newOferta(String nombre, String descripcion, String codigo){
    var post = new PostOferta(nombre, widget.user.displayName, descripcion, codigo);
    
    post.setId(saveOferta(post));
    widget.callback(post); 
    
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.yellowAccent], 
              ),
            ),
            child: Container(
              width: double.infinity,
              height: 250.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.photoUrl),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.user.displayName,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      widget.user.email,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                    
                  ],
                )
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Registra tu oferta',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextInputWidget(this.newOferta)
        ],
      ),
      ),
    );
  }
}