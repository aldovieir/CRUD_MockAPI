import 'package:dio/dio.dart';
import 'package:estudo_loja/models/models_items.dart';
import 'package:estudo_loja/screens/add_product.dart';
import 'package:estudo_loja/screens/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var futureFunction;

  List<ModeloItems> list = List<ModeloItems>();

  var dio = Dio();

  var token = "https://5f933a5f8742070016da67ea.mockapi.io/products";

  Future<List<ModeloItems>> getProducts() async {
    try {
      Response response = await dio.get(token);
      return ModeloItems.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    futureFunction = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;

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
          ),
          IconButton(
            onPressed: () {
              setState(() {
                futureFunction = getProducts();
                showToast("Produtos recarregados!",
                    backgroundColor: Colors.green[600]);
              });
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder<List<ModeloItems>>(
        future: futureFunction,
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
                        Expanded(
                          child: Text(list[index].nome),
                        ),
                        Expanded(
                          child: Text(list[index].preco.toString()),
                        ),
                        Expanded(
                          child: FlatButton(
                              onPressed: () {
                                try {
                                  dio
                                      .delete("$token/${list[index].id}")
                                      .then((_) {
                                    setState(() {
                                      futureFunction = getProducts();
                                      showToast("Produtos deletado!",
                                          backgroundColor: Colors.green[600]);
                                    });
                                  });
                                } catch (e) {
                                  showToast("Erro: ${e.toString()}",
                                      backgroundColor: Colors.red[600]);
                                }
                              },
                              child: Text('Deletar')),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProduct(
                                    idED: list[index].id,
                                    imagemED: list[index].imagem,
                                    nomeED: list[index].nome,
                                    precoED: list[index].preco,
                                  ),
                                ));
                          },
                          icon: Icon(Icons.edit),
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
