import 'package:dio/dio.dart';
import 'package:estudo_loja/models/models_items.dart';
import 'package:estudo_loja/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  EditProduct(
      {this.idED,
      @required this.nomeED,
      @required this.idadeED,
      @required this.imagemED});

  final String idED;
  final String nomeED;
  final String imagemED;
  final String idadeED;

  TextEditingController _nameController = TextEditingController();

  TextEditingController _idadeController = TextEditingController();

  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var url = "https://5f933a5f8742070016da67ea.mockapi.io/products";
    _nameController.text = nomeED ?? "";
    _idadeController.text = idadeED ?? "";
    _linkController.text = imagemED ?? "";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
          },
        ),
        title: Text('Novo produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              ModeloItems modelItems = ModeloItems(
                  imagem: _linkController.text,
                  nome: _nameController.text,
                  idade: int.tryParse(_idadeController.text));

              try {
                Dio().put('$url/$idED', data: modelItems).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()));
                  showToast("Produto atualizado com sucesso!",
                      backgroundColor: Colors.green[600]);
                });
              } catch (e) {
                showToast("Erro: ${e.toString()}",
                    backgroundColor: Colors.red[600]);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Form(
          child: AspectRatio(
            aspectRatio: 1,
            child: ListView(
              children: [
                TextFormField(
                  //initialValue: _nameController.text,
                  decoration: InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  /*  onChanged: (newValue) => nomeS = newValue, */
                ),
                TextFormField(
                  //initialValue: _idadeController.text,
                  decoration: InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.numberWithOptions(),
                  textInputAction: TextInputAction.next,
                  controller: _idadeController,
                  /*   onChanged: (newValue) => idadeS = newValue, */
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                        //initialValue: _linkController.text,
                        decoration:
                            InputDecoration(labelText: 'Link da imagem'),
                        keyboardType: TextInputType.url,
                        controller: _linkController,
                        textInputAction: TextInputAction.done,
                        /*  onChanged: (newValue) => imagemS = newValue, */
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: imagemED.isEmpty
                          ? Text('Informe a URL')
                          : Center(
                              child: FittedBox(
                                child: Image.network(
                                  imagemED,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
