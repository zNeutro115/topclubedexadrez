import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/helpers/validators.dart';
import 'package:topxadrez/screen/register_screen/register_screen.dart';

class RedefinirSenhaScreen extends StatelessWidget {
  final TextEditingController _controllerEmail =
      TextEditingController(text: 'admin@teste.com');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RedefinirSenhaScreen({Key? key}) : super(key: key);
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
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const Text(
                        'Digite o email que você esqueceu a senha'
                        ' que enviaremos um email de redefinição para ele.',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 125, 141),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        key: _formKey,
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
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      VisibilityWidget(
                        text: 'Redefinir Senha',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = _controllerEmail.text.toString();
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email);
                              Utils.buildErrorMensage(context,
                                  text:
                                      'PEDIDO ENVIADO COM SUCESSO!\nVERIFIQUE SEU EMAIL.\nEnviado para: ${_controllerEmail.text}');
                            } catch (e) {
                              Utils.buildErrorMensage(context, error: e);
                            }
                          } else {
                            Utils.buildErrorMensage(context,
                                text: 'DIGITE UM EMAIL VÁLIDO!');
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      VisibilityWidget(
                        text: 'Voltar para tela de login',
                        onPressed: () async {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const RegisterScreen(),
                            ),
                          );
                        },
                      ),
                      const Text(
                          'Qualquer dúvida é só mandar mensagem para o Whatsapp 21 9 7363-0631.')
                    ],
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
