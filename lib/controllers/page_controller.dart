import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/screen/artigo_screen/artigo_escrito_screen.dart';
import 'package:topxadrez/screen/artigo_screen/artigos_screen.dart';
import 'package:topxadrez/screen/artigo_screen/escrever_artigo_screen.dart';
import 'package:topxadrez/screen/artigo_screen/tabs/diagram_editing_modal.dart';
import 'package:topxadrez/screen/associado_screen/associado_edit_screen.dart';
import 'package:topxadrez/screen/associado_screen/associado_screen.dart';
import 'package:topxadrez/screen/associado_screen/pdf_screen.dart';
import 'package:topxadrez/screen/calendario_screen/calendario_screen.dart';
import 'package:topxadrez/screen/calendario_screen/marcar_aula_screen.dart';
import 'package:topxadrez/screen/configurations_screen/configurations_screen.dart';
import 'package:topxadrez/screen/destaque_screen/create_destaque_ecent.dart';
import 'package:topxadrez/screen/destaque_screen/destaque_screen.dart';
import 'package:topxadrez/screen/loja_screen/adicionar_product.dart';
import 'package:topxadrez/screen/loja_screen/loja_screen.dart';
import 'package:topxadrez/screen/loja_screen/product_screen.dart';

class ScreenController extends ChangeNotifier {
  List<Widget> listView = [
    const DestaqueScreen(), //0
    const ArtigoScreen(), //1
    const CalendarioScreen(), //2
    const LojaScreen(), //3
    ProductScreen(), //4
    const ArtigoEscritoScreen(), //5
    MarcarAulaScreen(), //6
    const EscreverArtigoScreen(), // 7
    const DiagramEditingModal(), //8
    const ArtigoScreen(), //9 // QUEM SOMOS
    const AdicionarProdutosScreen(), // 10
    const ArtigoScreen(), // 11 // EVENTOS
    const ConfigurationScreen(), // 12
    const AssociadoScreen(), // 13
    const AssociadoEditScreen(), // 14
    const CreateEventDestaque(), //15
    const PdfScreen(), //16
  ];

  int _currentPage = 16;

  int get currentPage => _currentPage;

  set currentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
