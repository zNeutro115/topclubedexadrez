import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/helpers/validators.dart';
import 'package:topxadrez/models/user_modal.dart';
import 'package:topxadrez/screen/layout_screen.dart';
import 'package:topxadrez/screen/register_screen/custom_textfield.dart';
import 'package:provider/provider.dart';

import 'esqueci_senha.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNome =
      TextEditingController(text: 'Igor Miranda Souza');
  final TextEditingController _controllerEmail =
      TextEditingController(text: 'admin@teste.com');
  final TextEditingController _controllerSenha =
      TextEditingController(text: '1234567');

  final TextEditingController _controllerCPF =
      TextEditingController(text: '123456789-00');

  final TextEditingController _controllerRG =
      TextEditingController(text: 'MG-a3Isa998');

  final TextEditingController _controllerEndereco =
      TextEditingController(text: 'Grã Duquesa - Rua França, 395');

  final TextEditingController _controllerEstadoCivil =
      TextEditingController(text: 'Solteiro');

  final TextEditingController _controllerNasc =
      TextEditingController(text: '12/01/2021');

  final TextEditingController _controllerSexo =
      TextEditingController(text: 'Masculino');

  final TextEditingController _controllerEscolaridade =
      TextEditingController(text: 'Maria Aparecida');

  final TextEditingController _controllerResponsaveis =
      TextEditingController(text: 'admin@teste.com');

  final TextEditingController _controllerCEP =
      TextEditingController(text: '26030-245');
  bool _cadastroUsuario = false;
  bool _isAdult = true;

  _validarCampos(BuildContext context) async {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    FirebaseFirestore _db = FirebaseFirestore.instance;
    if (_cadastroUsuario) {
      try {
        await context.read<UserController>().registrar(email, senha);
        String? idUsuario = context.read<UserController>().usuario!.uid;
        UserModel user = UserModel(
          id: idUsuario,
          email: email,
          isAfiliado: false,
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
        );
        final usuariosRef = _db.collection('users');
        usuariosRef.doc(idUsuario).set(user.toMap()).then((value) {
          context.read<UserController>().currentUser = user;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const LayoutScreen()),
          );
        });
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } else {
      try {
        await context.read<UserController>().login(email, senha);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const LayoutScreen()),
        );
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff005560),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fundo.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  width: 500,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Visibility(
                          visible: _cadastroUsuario,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _controllerNome,
                            validator: (name) {
                              if (name!.isEmpty || name.length < 4) {
                                return 'Nome muito curto';
                              }
                              if (!name.contains(' ')) {
                                return 'Nome completo!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Nome Completo',
                                labelText: 'Nome Completo',
                                suffixIcon: Icon(
                                  Icons.person_outline,
                                )),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _controllerEmail,
                          validator: (email) {
                            if (!emailValid(email!)) return 'E-mail inválido';
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              suffixIcon: Icon(
                                Icons.mail_outline,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _controllerSenha,
                          obscureText: true,
                          validator: (pass) {
                            if (pass!.isEmpty || pass.length < 6) {
                              return 'Senha Curta';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Senha',
                              labelText: 'Senha',
                              suffixIcon: Icon(
                                Icons.lock_outline,
                              )),
                        ),
                        Visibility(
                            visible: _cadastroUsuario,
                            child: CustomTextField(
                                controller: _controllerCPF, hint: 'CPF')),
                        Visibility(
                            visible: _cadastroUsuario,
                            child: CustomTextField(
                                controller: _controllerCEP, hint: 'CEP')),
                        Visibility(
                          visible: _cadastroUsuario,
                          child: CustomTextField(
                              controller: _controllerEndereco,
                              hint: 'Endereço'),
                        ),
                        Visibility(
                          visible: _cadastroUsuario,
                          child: CustomTextField(
                              controller: _controllerEscolaridade,
                              hint: 'Escolaridade'),
                        ),
                        Visibility(
                          visible: _cadastroUsuario,
                          child: CustomTextField(
                              controller: _controllerEstadoCivil,
                              hint: 'Estado Civil'),
                        ),
                        Visibility(
                          visible: _cadastroUsuario,
                          child: CustomTextField(
                              controller: _controllerNasc,
                              hint: 'Data de Nasc.'),
                        ),
                        Visibility(
                            visible: _cadastroUsuario,
                            child: CustomTextField(
                                controller: _controllerRG, hint: 'RG')),
                        Visibility(
                            visible: _cadastroUsuario,
                            child: CustomTextField(
                                controller: _controllerSexo, hint: 'Sexo')),
                        Visibility(
                          visible: _cadastroUsuario,
                          child: Row(
                            children: [
                              const Text('É maior de idade?'),
                              const Spacer(),
                              const Text('NÃO '),
                              Switch(
                                activeColor: const Color(0xff2074ac),
                                value: _isAdult,
                                onChanged: (bool valor) {
                                  setState(() {
                                    _isAdult = valor;
                                  });
                                },
                              ),
                              const Text('SIM'),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _cadastroUsuario && !_isAdult,
                          child: CustomTextField(
                              controller: _controllerResponsaveis,
                              hint: 'Responsável'),
                        ),
                        const SizedBox(height: 20),
                        VisibilityWidget(
                          text: _cadastroUsuario
                              ? 'Criar Conta'
                              : 'Logar em Conta',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _validarCampos(context);
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                context.read<ScreenController>().isLoading
                                    ? null
                                    : () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const LayoutScreen()),
                                        );
                                      },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff2074ac),
                            ),
                            child: const Text('Entrar sem conta'),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Login'),
                            Switch(
                              activeColor: const Color(0xff2074ac),
                              value: _cadastroUsuario,
                              onChanged: (bool valor) {
                                setState(() {
                                  _cadastroUsuario = valor;
                                });
                              },
                            ),
                            const Text('Cadastro'),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => RedefinirSenhaScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Esqueci a senha',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 4, 125, 141),
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
            ),
          ),
        ),
      ),
    );
  }
}
