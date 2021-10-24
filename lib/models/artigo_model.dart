import 'package:cloud_firestore/cloud_firestore.dart';

class Artigo {
  String? id;
  String type = 'artigo';
  Timestamp? createdAt;
  bool isDestaque = false;
  String titulo = 'titulo não escolhido';
  List<dynamic> conteudo = [];

  Artigo.fromMap(dynamic data) {
    titulo = data['titulo'] as String;
    id = data['id'];
    createdAt = data['createdAt'];
    conteudo = data['conteudo'] as List<dynamic>;
    type = data['type'] as String;
    isDestaque = data['isDestaque'] as bool;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'createdAt': createdAt,
      'conteudo': conteudo,
      'type': type,
      'isDestaque': isDestaque,
    };
  }

  Artigo({
    required this.titulo,
    required this.createdAt,
    required this.type,
    required this.isDestaque,
  });
}
