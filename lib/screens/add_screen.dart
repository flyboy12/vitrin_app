import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:vitrin_app/services/crud.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? selectedImage;
  bool _isLoading = false;
  String? title, desc;

  Future getImage() async {
    XFile? image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadProduct() async {
    setState(() {
      _isLoading = true;
    });
    if (selectedImage != null && title!.length > 1 && desc!.length > 1) {
      try {
        final ref =
            FirebaseStorage.instance.ref('productImage/${randomAlpha(9)}');
        final UploadTask task = ref.putFile(File(selectedImage!.path));
        final snapshot = await task.whenComplete(() {});
        final dowloandUrl = await snapshot.ref.getDownloadURL();
        print(dowloandUrl);
        Map<String, String> productMap = {
          "imgUrl": dowloandUrl,
          "title": title!,
          "desc": desc!,
        };
        CrudMethods().addProduct(productMap).then(
              (value) => Navigator.pop(context),
            );
      } on FirebaseException catch (e) {
        return null;
      }
    } else {
      return Navigator.pop(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Koleksiyona Ekleme"),
        actions: [
          IconButton(
              onPressed: () {
                uploadProduct();
              },
              icon: Icon(
                Icons.done,
                color: Colors.amber,
              ))
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage == null
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.add_a_photo, color: Colors.amber),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(selectedImage!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: " Ürün Adı"),
                    onChanged: (val) {
                      title = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: " Açıklama"),
                    onChanged: (val) {
                      desc = val;
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
