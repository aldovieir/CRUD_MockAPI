import 'package:dio/dio.dart';
import 'package:estudo_loja/models/models_items.dart';
import 'package:estudo_loja/screens/add_product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<EventoModelTest> list = List<EventoModelTest>();
  String token = "https://5f933a5f8742070016da67ea.mockapi.io/products";
  var list;

  Future<List<ModeloItems>> getProducts() async {
    try {
      Response response = await Dio()
          .get("https://5f933a5f8742070016da67ea.mockapi.io/products");
      return ModeloItems.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }*/

  /*getProducts() async {
    try {
      Response response = await Dio().get(token);

      //return response.data;

      setState(() {
        list = response.data;
      });
    } catch (e) {
      print(e);
      //return null;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;

    // if (list == null) {
    // return Card(child: Center(child: CircularProgressIndicator()));
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body:
          /*GridView.builder(
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
                      child: Image.network(list[index]["imagem"]),
                    ),
                    Expanded(child: Text(list[index]["nome"])),
                    Expanded(
                      child: Text(list[index]["preco"]),
                    ),
                    Expanded(
                      child: FlatButton(
                          onPressed: () {
                            //   Dio().delete('$token/${list[index]["id"]}');
                            //  getProducts();
                          },
                          child: Text('Deletar')),
                    ),
                    /*  Expanded(child: Text(list[index].nome)),
                      Expanded(
                        child: Text(list[index].preco.toString()),
                      ), */
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),*/

          FutureBuilder<List<ModeloItems>>(
        future: getProducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          list = snapshot.data;

          if (list.isEmpty) {
            return Center(child: Text("Sem produtos"));
          }

          return GridView.builder(
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
                          child: Image.network(list[index].imagem),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
