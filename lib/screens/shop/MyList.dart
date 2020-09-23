import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/model/Item.dart';
import 'package:my_flutter_app_with_firebase/screens/shop/ProductDetails.dart';
import 'package:my_flutter_app_with_firebase/shared/Loading.dart';
import 'package:provider/provider.dart';

class MyList extends StatefulWidget {
  final bool isGridMode;

  MyList({this.isGridMode});

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Consumer <List <Item>>(
        builder: (context, List<Item> _items, _) {
          if (widget.isGridMode) {
            return _items == null ? Loading() : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(
                                        item: _items[index]
                                    )));
                      },
                      leading: Image.network(_items[index].imageLink),
                      title: Text(_items[index].name),
                      subtitle: Text(_items[index].model),
                    ),
                  ),
                );
              },
            );
          } else {
            return _items == null ? Loading() : GridView.count(
              crossAxisCount: 2,
              children: List.generate(_items.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            ProductDetails(item: _items[index],)));
                  },
                  child: Container(
                    child: Card(
                      child: Image.network(_items[index].imageLink),
                    ),
                  ),
                );
              }),
            );
          }
        }
    );
  }
}
