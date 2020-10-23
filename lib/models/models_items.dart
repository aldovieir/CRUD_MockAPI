// To parse this JSON data, do
//
//     final eventoModelTest = eventoModelTestFromJson(jsonString);

import 'dart:convert';

class EventoModelTest {
  EventoModelTest({
    this.id,
    this.nome,
    this.preco,
    this.imagem,
  });

  final String id;
  final String nome;
  final String preco;
  final String imagem;

  factory EventoModelTest.fromRawJson(String str) =>
      EventoModelTest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventoModelTest.fromJson(Map<String, dynamic> json) =>
      EventoModelTest(
        id: json["id"] == null ? null : json["id"],
        nome: json["nome"] == null ? null : json["nome"],
        preco: json["preco"] == null ? null : json["preco"],
        imagem: json["imagem"] == null ? null : json["imagem"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nome": nome == null ? null : nome,
        "preco": preco == null ? null : preco,
        "imagem": imagem == null ? null : imagem,
      };

  static List<EventoModelTest> fromJsonList(List list) {
    if (list == null) return null;
    return list
        .map<EventoModelTest>((item) => EventoModelTest.fromJson(item))
        .toList();
  }
}
