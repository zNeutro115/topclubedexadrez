import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  bool isAdmin = false;
  late String id;
  late String nome;
  late String email;
  late bool isAfiliado;
  late String cpf;
  late String rg;
  late String endereco;
  late String estadoCivil;
  late String dataNasc;
  late String sexo;
  late String escolaridade;
  late String responsaveis;
  late String cep;
  DateTime? payday;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.isAfiliado,
    required this.cpf,
    required this.rg,
    required this.endereco,
    required this.estadoCivil,
    required this.dataNasc,
    required this.sexo,
    required this.escolaridade,
    required this.responsaveis,
    required this.cep,
    this.payday,
  });

  UserModel.fromMap(dynamic data) {
    id = data['id'];
    nome = data['nome'];
    email = data['email'];
    isAfiliado = data['isAfiliado'];
    cpf = data['cpf'];
    rg = data['rg'];
    endereco = data['endereco'];
    estadoCivil = data['estadoCivil'];
    dataNasc = data['dataNasc'];
    sexo = data['sexo'];
    escolaridade = data['escolaridade'];
    responsaveis = data['responsaveis'];
    cep = data['cep'];
    payday = (data['payday']! as Timestamp).toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'isAfiliado': isAfiliado,
      'cpf': cpf,
      'rg': rg,
      'endereco': endereco,
      'estadoCivil': estadoCivil,
      'dataNasc': dataNasc,
      'sexo': sexo,
      'escolaridade': escolaridade,
      'responsaveis': responsaveis,
      'cep': cep,
      'payday': payday,
    };
  }
}
