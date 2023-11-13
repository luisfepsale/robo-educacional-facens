// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class BlockEntity extends Equatable {
  final String title;
  final String image;
  final String description;
  final int value;
  final String link;
  final int id;

  const BlockEntity({
    this.title = '',
    this.image = 'assets/base-block.svg',
    this.description = '',
    this.value = 1,
    this.link = '',
    this.id = 0,
  });

  @override
  List<Object?> get props => [id];

  List<String> toCode() {
    return [title.substring(0, 1).toLowerCase(), value.toString()];
  }

  factory BlockEntity.fromMap(Map<String, dynamic> map) {
    return BlockEntity(
      title: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      value: map['value'] as int,
      link: map['link'] as String,
    );
  }

  BlockEntity copyWith({
    String? title,
    String? image,
    String? description,
    int? value,
    String? link,
    int? id,
  }) {
    return BlockEntity(
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      value: value ?? this.value,
      link: link ?? this.link,
      id: id ?? this.id,
    );
  }
}

const Map<String, List<Map<String, dynamic>>> blockLibrary = {
  "movimentos": [
    {
      "title": "Frente",
      "image": "assets/bloco-frente.svg",
      "description": "Este bloco tem a função de andar para frente.",
      "value": 0,
      "link": "#"
    },
    {
      "title": "Atrás",
      "image": "assets/bloco-atras.svg",
      "description": "Este bloco tem a função de andar para trás.",
      "value": 0,
      "link": "#"
    },
    {
      "title": "Girar para Direita",
      "image": "assets/bloco-rotacao-direita.svg",
      "description": "Este bloco tem a função de rotacionar para direita.",
      "value": 0,
      "link": "#"
    },
    {
      "title": "Girar para esquerda",
      "image": "assets/bloco-rotacao.svg",
      "description": "Este bloco tem a função de rotacionar para a esquerda.",
      "value": 0,
      "link": "#"
    }
  ],
  "controladores": [
    {
      "title": "Repetidor",
      "image": "assets/repeater.svg",
      "description":
          "Este bloco tem a função de repetir os blocos que esta dentro dele.",
      "value": 0,
      "link": "#"
    }
  ]
};
