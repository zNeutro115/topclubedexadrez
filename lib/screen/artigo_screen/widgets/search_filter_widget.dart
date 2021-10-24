import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SearchFilter extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);

  SearchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 4, 125, 141), width: 4)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 4, 125, 141))),
          focusColor: Colors.red,
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 4, 125, 141),
          ),
          labelStyle: TextStyle(color: Color.fromARGB(255, 4, 125, 141)),
          hintStyle: TextStyle(color: Color.fromARGB(255, 4, 125, 141)),
          labelText: 'Filtre pelo que você está procurando',
        ),
        onChanged: (string) {
          _debouncer.run(
            () {
              context.read<ArtigoController>().filteredArtigos = context
                  .read<ArtigoController>()
                  .artigos
                  .where((u) =>
                      (u.titulo.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            },
          );
        },
      ),
    );
  }
}
