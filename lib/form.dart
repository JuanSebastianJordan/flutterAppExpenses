import 'package:flutter/material.dart';


class FormOferta extends StatefulWidget {
  @override
  _FormOfertaState createState() => _FormOfertaState();
}

class _FormOfertaState extends State<FormOferta> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder(),
            labelText: 'Nombre'
            ),
          validator: (value) {
            if(value.isEmpty){
              return 'Escriba su nombre';
            }
            return null;
          } 
          ),
          TextFormField(
            
            decoration: InputDecoration(border: OutlineInputBorder(),
            labelText: 'Descripcion'
            ),
          validator: (value) {
            if(value.isEmpty){
              return 'Escriba su descripcion';
            }
            return null;
          } 
          ),
          TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder(),
            labelText: 'Codigo'
            ),
          validator: (value) {
            if(value.isEmpty){
              return 'Escriba su codigo';
            }
            return null;
          } 
          ),
          FlatButton(
            color: Colors.blue,
            onPressed:(){
              if(_formKey.currentState.validate()){
                //llamar funcion
                Scaffold.of(context)
                .showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Oferta agregada')));
              } else {
                Scaffold.of(context)
                .showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('Hubo un problema')));
              }
              }, 
            child: Text('Submit', 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold)
            )
          )
        ],
      )
      
    );
  }
}