import 'package:flutter/material.dart';
import 'package:topxadrez/controllers/favorites_controller.dart';
import 'package:topxadrez/screen/register_screen/custom_textfield.dart';
import 'package:provider/provider.dart';

class CreateEventDestaque extends StatefulWidget {
  const CreateEventDestaque({Key? key}) : super(key: key);

  @override
  State<CreateEventDestaque> createState() => _CreateEventDestaqueState();
}

class _CreateEventDestaqueState extends State<CreateEventDestaque> {
  final TextEditingController _controllerTitle =
      TextEditingController(text: '');
  final TextEditingController _controllerSubTitile =
      TextEditingController(text: '');
  DateTime _dateTime = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Complete os campos para adicionar um novo evento em destaque',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 125, 141),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(hint: 'Título', controller: _controllerTitle),
          CustomTextField(hint: 'Subtítulo', controller: _controllerSubTitile),
          Text(
            'Data Escolhida: ${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
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
                ).then((value) {
                  if (value == null) return;
                  setState(() {
                    _dateTime = value;
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2074ac),
              ),
              child: const Text('Escolher Data'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                await context
                    .read<EventDestaqueController>()
                    .uploadDestauqeEvent(EventDestaque(
                        title: _controllerTitle.text,
                        subtitle: _controllerSubTitile.text,
                        date: _dateTime));
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2074ac),
              ),
              child: const Text('Adicionar Evento Destacado'),
            ),
          ),
        ],
      ),
    );
  }
}
