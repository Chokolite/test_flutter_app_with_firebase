import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/model/Item.dart';

class ProductDetails extends StatefulWidget {
  final Item item;
  ProductDetails({this.item});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.item.name}"),
        ),
        body: Column(children: [
          Image.network("${widget.item.imageLink}"),
          Text("model: ${widget.item.model}"),
          Text("color ${widget.item.color}")
        ]));
  }
}
