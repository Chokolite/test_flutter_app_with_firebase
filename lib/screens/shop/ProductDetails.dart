import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/model/Item.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';

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
          title: Text(
            "${widget.item.name}",
            style: textColor,
          ),
        ),
        body: Container(
          color: bodyBackgroundColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network("${widget.item.imageLink}"),
                Text(
                  "model: ${widget.item.model}",
                  style: textColor.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 50),
                ),
                Text(
                  "color: ${widget.item.color}",
                  style: textColor.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 50),
                ),
              ]),
        ));
  }
}
