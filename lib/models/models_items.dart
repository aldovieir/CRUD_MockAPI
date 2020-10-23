class ModeloItems {
  ModeloItems({
    this.nome,
    this.preco,
    this.image,
  });

  String nome;
  double preco;
  String image;

  ModeloItems copyWith({
    String nome,
    double preco,
    String image,
  }) =>
      ModeloItems(
        nome: nome ?? this.nome,
        preco: preco ?? this.preco,
        image: image ?? this.image,
      );
}
