import 'package:flutter/material.dart';
import 'package:flutter_demo/animations_page.dart';
import 'package:flutter_demo/shopping/shopping_model.dart'
    show GoodsModel, ShoppingProvider;
import 'package:provider/provider.dart';

List<GoodsModel> genGoodsList() {
  return List.generate(20, (index) {
    return GoodsModel(
        id: "$index",
        name: "Goods-$index",
        price: getRandomSize(),
        color: getRandomColor());
  });
}

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShoppingState();
  }
}

class _ShoppingState extends State<Shopping> {
  final List<GoodsModel> _goodsList = genGoodsList();

  List<Widget> _buildGoods(ShoppingProvider shoppingProvider) {
    return _goodsList
        .asMap()
        .map((key, value) {
          var hasSelected = shoppingProvider.goods.where(
            (element) => element.id == "$key",
          );

          return MapEntry(
              key,
              ListTile(
                title: Text(value.name),
                leading: CircleAvatar(
                  backgroundColor: value.color,
                ),
                subtitle: Text("${value.price}"),
                trailing: TextButton(
                    onPressed: () {
                      if (hasSelected.isEmpty) {
                        shoppingProvider.add(value);
                      }
                    },
                    child: hasSelected.isEmpty
                        ? const Text("Add")
                        : const Icon(Icons.check)),
              ));
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var shoppingProvider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed("/shopping-cart");
          }, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: ListView(
        children: [
          ..._buildGoods(shoppingProvider),
        ],
      ),
    );
  }
}
