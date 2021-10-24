import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/user_modal.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/screen/register_screen/register_screen.dart';

class AssociadoEditScreen extends StatefulWidget {
  const AssociadoEditScreen({Key? key}) : super(key: key);

  @override
  State<AssociadoEditScreen> createState() => _AssociadoEditScreenState();
}

class _AssociadoEditScreenState extends State<AssociadoEditScreen> {
  DateTime _dateTime = DateTime.now();

  bool _isAssoc = false;
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerSenha =
      TextEditingController(text: '');

  TextEditingController _controllerCPF = TextEditingController();

  TextEditingController _controllerRG = TextEditingController();

  TextEditingController _controllerEndereco = TextEditingController();

  TextEditingController _controllerEstadoCivil = TextEditingController();

  TextEditingController _controllerNasc = TextEditingController();

  TextEditingController _controllerSexo = TextEditingController();

  TextEditingController _controllerEscolaridade = TextEditingController();
  TextEditingController _controllerCEP = TextEditingController();

  TextEditingController _controllerResponsaveis = TextEditingController();

  @override
  void initState() {
    if (context.read<UserController>().toEditUser != null) {
      _isAssoc = context.read<UserController>().toEditUser!.isAfiliado;
    }

    _controllerNome = TextEditingController(
        text: (context.read<UserController>().toEditUser?.nome) ?? '');

    _controllerEmail = TextEditingController(
        text: (context.read<UserController>().toEditUser?.email) ??
            'igornewspam@outlook.com');

    _controllerCPF = TextEditingController(
        text: (context.read<UserController>().toEditUser?.cpf) ?? '');

    _controllerRG = TextEditingController(
        text: (context.read<UserController>().toEditUser?.rg) ?? '');

    _controllerEndereco = TextEditingController(
        text: (context.read<UserController>().toEditUser?.endereco) ?? '');

    _controllerEstadoCivil = TextEditingController(
        text: (context.read<UserController>().toEditUser?.estadoCivil) ?? '');

    _controllerNasc = TextEditingController(
        text: (context.read<UserController>().toEditUser?.dataNasc) ?? '');

    _controllerEscolaridade = TextEditingController(
        text: (context.read<UserController>().toEditUser?.escolaridade) ?? '');

    _controllerCEP = TextEditingController(
        text: (context.read<UserController>().toEditUser?.cep) ?? '');

    _controllerSexo = TextEditingController(
        text: (context.read<UserController>().toEditUser?.sexo) ?? 'MASCULINO');
    _controllerResponsaveis = TextEditingController(
        text: (context.read<UserController>().toEditUser?.responsaveis) ?? '');

    _controllerResponsaveis = TextEditingController(
        text: (context.read<UserController>().toEditUser?.responsaveis) ?? '');

    // isDestaque = context.read<ArtigoController>().isUpdating
    //     ? context.read<ArtigoController>().toUpdateArt!.isDestaque
    //     : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    _validarCampos(BuildContext context) async {
      String nome = _controllerNome.text;
      String email = _controllerEmail.text;
      String senha = _controllerSenha.text;
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseFirestore _db = FirebaseFirestore.instance;

      if (!context.read<UserController>().isUpdating) {
        try {
          await _auth
              .createUserWithEmailAndPassword(email: email, password: senha)
              .then((auth) {
            String? idUsuario = auth.user?.uid;
            UserModel user = UserModel(
              id: idUsuario!,
              email: email,
              isAfiliado: _isAssoc,
              nome: nome,
              cpf: _controllerCPF.text,
              dataNasc: _controllerNasc.text,
              endereco: _controllerEndereco.text,
              escolaridade: _controllerEscolaridade.text,
              estadoCivil: _controllerEstadoCivil.text,
              responsaveis: _controllerResponsaveis.text,
              rg: _controllerRG.text,
              sexo: _controllerSexo.text,
              cep: _controllerCEP.text,
              payday: _dateTime,
            );
            final usuariosRef = _db.collection('users');
            usuariosRef.doc(idUsuario).set(user.toMap()).then((value) async {
              context.read<UserController>().isUpdating = false;
              await context.read<UserController>().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const RegisterScreen()),
              );
            });
          });
          context.read<UserController>().isUpdating = false;
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      } else {
        try {
          UserModel usuario = context.read<UserController>().toEditUser!;
          usuario.responsaveis = _controllerResponsaveis.text;
          usuario.cep = _controllerCEP.text;
          usuario.cpf = _controllerCPF.text;
          usuario.dataNasc = _controllerNasc.text;
          usuario.endereco = _controllerEndereco.text;
          usuario.escolaridade = _controllerEscolaridade.text;
          usuario.estadoCivil = _controllerEstadoCivil.text;
          usuario.nome = _controllerNome.text;
          usuario.rg = _controllerRG.text;
          usuario.sexo = _controllerSexo.text;
          usuario.payday = _dateTime;
          usuario.isAfiliado = _isAssoc;
          final usuariosRef = _db.collection('users');

          await usuariosRef.doc(usuario.id).update(usuario.toMap());
          debugPrint(usuario.id);
          await context.read<UserController>().logout();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const RegisterScreen()),
          );
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }

    Widget customTextField(String hint, TextEditingController controller,
        {TextInputType textInputType = TextInputType.emailAddress,
        bool isEnabled = true}) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: TextFormField(
          enabled: isEnabled,
          keyboardType: textInputType,
          controller: controller,
          validator: (name) {
            if (name!.isEmpty || name.length < 4) {
              return 'Muito curto';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            labelText: hint,
          ),
        ),
      );
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'Informações de associado',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 125, 141),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('É associado?'),
              const Spacer(),
              const Text('NÃO '),
              Switch(
                activeColor: const Color(0xff2074ac),
                value: _isAssoc,
                onChanged: (bool valor) {
                  setState(() {
                    _isAssoc = valor;
                  });
                },
              ),
              const Text('SIM'),
            ],
          ),
          customTextField('Nome', _controllerNome),
          customTextField('CPF', _controllerCPF),
          customTextField('RG', _controllerRG),
          customTextField('Endereço', _controllerEndereco),
          customTextField('Estado Cívil', _controllerEstadoCivil),
          customTextField('CEP', _controllerCEP),
          customTextField('Nascimento', _controllerNasc),
          customTextField('Sexo', _controllerSexo),
          customTextField('Escolaridade', _controllerEscolaridade),
          customTextField('E-mail', _controllerEmail,
              isEnabled: !context.watch<UserController>().isUpdating),
          if (!context.watch<UserController>().isUpdating)
            customTextField('Senha', _controllerSenha,
                isEnabled: !context.watch<UserController>().isUpdating),
          customTextField('Responsável', _controllerResponsaveis),
          const SizedBox(height: 8),
          Text(
            'Data Escolhida: ${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
            style: const TextStyle(color: Colors.black, fontSize: 32),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2030),
                ).then(
                  (value) {
                    if (value == null) return;
                    setState(
                      () {
                        _dateTime = value;
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2074ac),
              ),
              child: const Text('Escolher Data'),
            ),
          ),
          const SizedBox(height: 8),
          VisibilityWidget(
            text: 'Cadastrar Associado',
            page: 13,
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                debugPrint('nao validado');
                return;
              }
              try {
                if (formKey.currentState!.validate()) {
                  await _validarCampos(context);
                  Utils.zerarTudo(context);
                }
              } catch (e) {
                Utils.buildErrorMensage(context, error: e);
              }
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                context.read<ScreenController>().currentPage = 13;
                context.read<UserController>().isUpdating = false;
                Utils.zerarTudo(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2074ac),
              ),
              child: const Text('Voltar'),
            ),
          ),
        ],
      ),
    );
  }
}
