import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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
                Future.delayed(Duration(seconds: 3));
                showToast("Produtos recarregados!",
                    backgroundColor: Colors.green[600]);
              });
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: FutureBuilder<List<ModeloItems>>(
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    shadowColor: Colors.blue,
                    elevation: 5,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.5,
                            child: Container(
                              //width: 100,
                              //height: 100,
                              child: Center(
                                child: CircularProfileAvatar(
                                  list[index].imagem,
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  borderWidth: 1,
                                  borderColor: Colors.blue[300],
                                  elevation: 5.0,
                                  //foregroundColor: Colors.blue.withOpacity(0.5),
                                  cacheImage: true,
                                  showInitialTextAbovePicture: true,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(list[index].nome,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                )),
                          ),
                          Center(
                            child: Text(list[index].idade.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProduct(
                                          idED: list[index].id,
                                          imagemED: list[index].imagem,
                                          nomeED: list[index].nome,
                                          idadeED: list[index].idade,
                                        ),
                                      ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
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
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MediaQuery.of(context).size.width >
                        MediaQuery.of(context).size.height)
                    ? 5
                    : 2,
                mainAxisSpacing: 10,
                childAspectRatio: .8,
                //crossAxisSpacing: 5,
              ),
            );
          },
        ),
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
