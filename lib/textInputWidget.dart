import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function(String, String, String) callback;

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState(); 
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
  } 

  void click(){
    widget.callback(controller.text, controller2.text, controller3.text);
    FocusScope.of(context).unfocus();
    controller.clear();
    controller2.clear();
    controller3.clear();
    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: this.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre'),
            validator: (value) {
            if(value.isEmpty){
              return 'Escriba su nombre';
            }
            return null;
            } 
          ),
          TextFormField(
            controller: this.controller2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descripcion'),
            validator: (value) {
            if(value.isEmpty){
              return 'Escriba su descripcion';
            }
            return null;
            } 
          ),
          TextFormField(
            controller: this.controller3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Codigo'),
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
                this.click();
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
        ]
      )
      
    );
  }

  //@override
  //Widget build(BuildContext context) {
    //return TextField(
      //controller: this.controller,
      //decoration: InputDecoration(
        //prefixIcon: Icon(Icons.message), 
        //labelText: "Ingrese su oferta",
         //suffixIcon: IconButton(
           //icon: Icon(Icons.send),
           //splashColor: Colors.blue,
           //tooltip: "Enviar mensaje",
            //onPressed: this.click,
         //)));
  //}
}