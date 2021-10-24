import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';

class TextEditingModal extends StatelessWidget {
  final BuildContext primaryContext;
  final bool isLinkYoutube;
  final String initialText;
  final int? index;
  const TextEditingModal({
    required this.primaryContext,
    this.index,
    this.initialText = '',
    this.isLinkYoutube = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBold = false;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: 750,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLinkYoutube
                    ? 'Coloque o LINK do video do youtube'
                    : 'Digite ou edite esse trecho do artigo:',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 125, 141),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Material(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      initialValue: initialText,
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Digite algo...';
                          }
                          if (value.length < 5) {
                            return 'Precisa ter, ao menos, 5 caracteres...';
                          }
                        }
                        return null;
                      },
                      onSaved: (textBloc) {
                        if (textBloc != null && index == null) {
                          if (!isBold) {
                            primaryContext
                                .read<ArtigoController>()
                                .addTexto(textBloc);
                          } else {
                            primaryContext
                                .read<ArtigoController>()
                                .addTexto('isBOLD $textBloc');
                          }
                        }
                        if (index != null) {
                          List _lista =
                              primaryContext.read<ArtigoController>().newArtigo;
                          _lista[index!] = textBloc;
                          primaryContext.read<ArtigoController>().newArtigo =
                              _lista;
                        }
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 125, 141),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 4, 125, 141),
                              width: 4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 4, 125, 141),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (!isLinkYoutube)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          isBold = false;
                          _formKey.currentState?.save();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2074ac),
                        ),
                        child: const Text('Adicionar Texto'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          isBold = true;
                          _formKey.currentState?.save();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2074ac),
                        ),
                        child: const Text('Adicionar sub-título'),
                      ),
                    ),
                  ],
                ),
              if (isLinkYoutube)
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState?.save();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff2074ac),
                  ),
                  child: const Text('Adicionar Texto'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
