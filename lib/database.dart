import 'package:expenses/postOferta.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postOferta.dart';


final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference saveOferta(PostOferta post) {
  var id = databaseReference.child('ofertas/').push();
  id.set(post.toJson());
  return id;
}

void updatePost(PostOferta oferta, DatabaseReference id){
   id.update(oferta.toJson());
}

Future<List<PostOferta>> getAllOfertas() async {
  
  DataSnapshot dataSnapshot = await databaseReference.child('ofertas/').once();
  List<PostOferta> ofertas = [];
  if(dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      PostOferta oferta = createOferta(value);
      oferta.setId(databaseReference.child('ofertas/' + key));
      ofertas.add(oferta);
    });
  }
  return ofertas;
}
