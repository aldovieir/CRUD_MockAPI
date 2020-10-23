import 'package:estudo_loja/models/models_items.dart';

class GridItems {
  List<ModeloItems> getList() {
    ModeloItems a = ModeloItems(
      nome: 'Casaco',
      image:
          'https://media.istockphoto.com/photos/womens-wool-coat-gray-color-picture-id1050261338',
      preco: 200.0,
    );
    ModeloItems b = ModeloItems(
      nome: 'Tenis',
      image:
          'https://cdn.pixabay.com/photo/2013/07/12/18/20/chucks-153310_960_720.png',
      preco: 180.0,
    );
    ModeloItems c = ModeloItems(
      nome: 'Casaco',
      image:
          'https://media.istockphoto.com/photos/blue-coat-isolated-picture-id629516832',
      preco: 201.0,
    );
    ModeloItems d = ModeloItems(
      nome: 'Calça',
      image:
          'https://cdn.pixabay.com/photo/2014/05/21/14/54/feet-349687__340.jpg',
      preco: 220.0,
    );
    ModeloItems f = ModeloItems(
      nome: 'Calça',
      image:
          'https://cdn.pixabay.com/photo/2014/05/21/14/54/feet-349687__340.jpg',
      preco: 500.0,
    );
    return [a, b, c, d, f];
  }
}
