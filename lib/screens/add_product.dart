import 'package:dio/dio.dart';
import 'package:estudo_loja/models/models_items.dart';
import 'package:estudo_loja/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AddProduct extends StatelessWidget {
  final _nameController = TextEditingController();
  final _idadeController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var url = "https://5f933a5f8742070016da67ea.mockapi.io/products";
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
                Dio().post(url, data: modelItems).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()));
                  showToast("Produto adicionado com sucesso!",
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
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                controller: _nameController,
//onChanged: (newValue) => modelItems.nome = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.numberWithOptions(),
                textInputAction: TextInputAction.next,
                controller: _idadeController,
//onChanged: (newValue) => modelItems.preco = newValue,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Link da imagem'),
                      keyboardType: TextInputType.url,
                      controller: _linkController,
                      textInputAction: TextInputAction.done,
                      //  onChanged: (newValue) => modelItems.imagem = newValue,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _linkController.text.isEmpty
                        ? Text('Informe a URL')
                        : FittedBox(
                            child: Image.network(
                              _linkController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
