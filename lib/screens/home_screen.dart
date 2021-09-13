import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitrin_app/screens/add_screen.dart';
import 'package:vitrin_app/widgets/ProductTile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vitrin",
          style: TextStyle(color: Colors.amber, fontSize: 26),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("Üzgünüz Yanlışlık Oldu"));
          }

          return ListView(
            children: snapshot.data!.docs.map((e) {
              return ProductTile(
                imageUrl: e["imgUrl"],
                title: e["title"],
                desc: e["desc"],
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(),
              ));
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
