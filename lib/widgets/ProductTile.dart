import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  String? imageUrl, title, desc;
  ProductTile({this.imageUrl, this.title, this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14, right: 10, left: 10),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imageUrl ??
                  "https://firebasestorage.googleapis.com/v0/b/vitrin-30da2.appspot.com/o/productImage%2FOvbJiQKne?alt=media&token=0569bc30-29c8-41e3-9643-123534463a83",
              placeholder: (context, url) => CircularProgressIndicator(),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              right: 30,
              left: 50,
              top: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "a",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.amber[700]),
                  ),
                  Text(
                    desc!.length < 16 ? desc! : ("${desc!.substring(0, 15)}.."),
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
