import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
//  List productsList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("products");
  Future<void> addProduct(data) async {
    collectionRef.add(data).catchError((e) {});
  }

  /*    getData() async {
    try {
   
   await collectionRef.get().then((value) {
     for (var result in value.docs) {
          productsList.add(result.data());
        }
        return productsList; 
      });
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
}*/
}
