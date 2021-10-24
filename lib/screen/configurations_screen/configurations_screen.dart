import 'package:flutter/material.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/screen/register_screen/register_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  TextSpan buildNormalText(String text) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 4, 125, 141),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (context.watch<UserController>().currentUser != null)
                VisibilityWidget(
                  willApear: context.read<UserController>().currentUser != null,
                  widget: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        buildNormalText('Nome: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.nome}\n',
                        ),
                        buildNormalText('Status de Associado:  '),
                        TextSpan(
                          text: context
                                  .watch<UserController>()
                                  .currentUser!
                                  .isAfiliado
                              ? 'ATIVO\n'
                              : 'DESATIVADO\n',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: context
                                    .watch<UserController>()
                                    .currentUser!
                                    .isAfiliado
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        buildNormalText('CEP: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.cep}\n',
                        ),
                        buildNormalText('CPF: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.cpf}\n',
                        ),
                        buildNormalText('Data de Nasc.: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.dataNasc}\n',
                        ),
                        buildNormalText('Endereço: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.endereco}\n',
                        ),
                        buildNormalText('Escolaridade: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.escolaridade}\n',
                        ),
                        buildNormalText('Estado Civíl: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.estadoCivil}\n',
                        ),
                        buildNormalText('Sexo: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.sexo}\n',
                        ),
                        buildNormalText('RG: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.rg}\n',
                        ),
                        buildNormalText('Responsáveis: '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().currentUser!.responsaveis}\n',
                        ),
                        buildNormalText('N° de Identificação:  '),
                        TextSpan(
                          text:
                              '${context.watch<UserController>().usuario!.uid}\n',
                        ),
                        if (context
                            .watch<UserController>()
                            .currentUser!
                            .isAfiliado)
                          buildNormalText('Dia de pagamento: '),
                        if (context
                            .watch<UserController>()
                            .currentUser!
                            .isAfiliado)
                          TextSpan(
                              text:
                                  '${context.watch<UserController>().currentUser!.payday!.day}/${context.watch<UserController>().currentUser!.payday!.month}/2021'),
                      ],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              VisibilityWidget(
                willApear: context.read<UserController>().currentUser != null,
                widget: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      await context.read<UserController>().logout();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Sair',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 125, 141),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              VisibilityWidget(
                nivel: VisibilityWidget.semConta,
                text: 'Entrar na Conta (ou criar conta)',
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const RegisterScreen(),
                    ),
                  );
                },
              ),
              VisibilityWidget(
                nivel: VisibilityWidget.logadoApenas,
                text: 'Pedir Afiliação',
                onPressed: () async {
                  if (await canLaunch(
                      'https://api.whatsapp.com/send?phone=5521973630631&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20como%20funcionar%20o%20processo%20para%20me%20tornar%20afiliado%20ao%20TOP%20CLUBE%20DE%20XADREZ.')) {
                    launch(
                        'https://api.whatsapp.com/send?phone=5521973630631&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20como%20funcionar%20o%20processo%20para%20me%20tornar%20afiliado%20ao%20TOP%20CLUBE%20DE%20XADREZ.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
