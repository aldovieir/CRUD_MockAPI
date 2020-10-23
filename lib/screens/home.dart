import 'package:estudo_loja/mock/gridItems.dart';
import 'package:estudo_loja/models/models_items.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ModeloItems> list = List<ModeloItems>();

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getList() {
    list = GridItems().getList();
  }

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: GridView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return AspectRatio(
              aspectRatio: 2.5,
              child: Container(
                height: 100,
                width: 50,
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.network(list[index].image),
                      ),
                      Expanded(child: Text(list[index].nome)),
                      Expanded(
                        child: Text(list[index].preco.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
