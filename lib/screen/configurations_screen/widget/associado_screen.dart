// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociadoScreen extends StatefulWidget {
  const AssociadoScreen({Key? key}) : super(key: key);

  @override
  State<AssociadoScreen> createState() => _AssociadoScreenState();
}

class _AssociadoScreenState extends State<AssociadoScreen> {
  // ignore: prefer_final_fields
  bool _isChild = true;

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

  //apenas para menor de idade
  final TextEditingController _controllerResponsaveis =
      TextEditingController(text: 'admin@teste.com');

  Widget customTextField(String hint, TextEditingController controller,
      {TextInputType textInputType = TextInputType.emailAddress}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
        ),
      ),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 8),
          // const Text(
          //   'Informações de associado',
          //   style: TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //     color: Color.fromARGB(255, 4, 125, 141),
          //   ),
          // ),
          // Visibility(
          //   visible: _isChild,
          //   child: const Text(
          //     'Lembre-se, todas as informações serão conferidas. Responda corretamente sob risco de suspensão de conta.',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // Row(
          //   children: [
          //     const Text('Você é maior de idade? (mais de 18 anos)'),
          //     const Spacer(),
          //     const Text('NÃO '),
          //     Switch(
          //       activeColor: const Color(0xff2074ac),
          //       value: _isChild,
          //       onChanged: (bool valor) {
          //         setState(() {
          //           _isChild = valor;
          //         });
          //       },
          //     ),
          //     const Text('SIM'),
          //   ],
          // ),
          // customTextField('CPF', _controllerCPF),
          // customTextField('RG', _controllerRG),
          // customTextField('Endereço', _controllerEndereco),
          // customTextField('Estado Cívil', _controllerEstadoCivil),
          // customTextField('Nascimento', _controllerNasc),
          // customTextField('Sexo', _controllerSexo),
          // customTextField('Escolaridade', _controllerEscolaridade),
          // Visibility(
          //   visible: _isChild,
          //   child: customTextField(
          //     'Responsável',
          //     _controllerResponsaveis,
          //   ),
          // ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
            style: ElevatedButton.styleFrom(primary: const Color(0xff2074ac)),
            child: const Text('Associar-se'),
          ),
        ],
      ),
    );
  }
}
