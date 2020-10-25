import 'dart:convert';

class ModeloItems {
  ModeloItems({
    this.id,
    this.nome,
    this.idade,
    this.imagem,
  });

  final String id;
  final String nome;
  final int idade;
  final String imagem;

  factory ModeloItems.fromRawJson(String str) =>
      ModeloItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModeloItems.fromJson(Map<String, dynamic> json) => ModeloItems(
        id: json["id"] == null ? null : json["id"],
        nome: json["nome"] == null ? null : json["nome"],
        idade: json["idade"] == null ? null : json["idade"],
        imagem: json["imagem"] == null ? null : json["imagem"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nome": nome == null ? null : nome,
        "idade": idade == null ? null : idade,
        "imagem": imagem == null ? null : imagem,
      };

  static List<ModeloItems> fromJsonList(List list) {
    if (list == null) return null;
    return list.map<ModeloItems>((item) => ModeloItems.fromJson(item)).toList();
  }
}
