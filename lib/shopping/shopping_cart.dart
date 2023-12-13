import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/shopping_model.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShoppingCartState();
  }
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<ShoppingProvider>(builder: (_, data, __) {
        var columns = [
          const DataColumn(label: Text("id")),
          const DataColumn(label: Text("name")),
          const DataColumn(label: Text("price")),
          const DataColumn(label: Text("handle")),
        ];
        var rows = data.goods
            .asMap()
            .map((key, value) => MapEntry(
                key,
                DataRow(cells: [
                  DataCell(Text(value.id)),
                  DataCell(Text(value.name)),
                  DataCell(Text("${value.price}")),
                  DataCell(IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      data.remove(value.id);
                    },
                    color: Colors.red,
                  )),
                ])))
            .values
            .toList();

        return Column(
          children: [
            SingleChildScrollView(
              child: DataTable(columns: columns, rows: rows),
              scrollDirection: Axis.horizontal,
            ),
            Text(
              "总计：${data.totalPrice}",
              style: const TextStyle(fontSize: 20, color: Colors.red),
            )
          ],
        );
      }),
    );
  }
}
