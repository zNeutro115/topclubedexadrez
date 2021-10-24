import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';
import 'package:topxadrez/helpers/artigos_types.dart';
import 'package:topxadrez/models/artigo_model.dart';
import 'package:uuid/uuid.dart';

class ArtigoController extends ChangeNotifier {
  ArtigoController() {
    getArtigos();
  }
  getArtigos() async {
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('artigos').get();

    List<Artigo> _artigos = [];
    List<Artigo> _quemSomos = [];
    List<Artigo> _eventos = [];
    List<Artigo> _destaque = [];

    for (var doc in snap.docs) {
      Artigo artigo = Artigo.fromMap(doc.data());
      artigo.conteudo.map((art) {
        art as Map;
        if (art['type'] == 'bold') {
          String texto = art['content'];
          art['content'] = 'isBold $texto';
        }
      });
      if (artigo.isDestaque) {
        _destaque.add(artigo);
      }
      switch (artigo.type) {
        case (ArtigoTypes.artigo):
          artigo.conteudo.sort((a, b) {
            return (a['index'] as int).compareTo(b['index'] as int);
          });
          _artigos.add(artigo);
          break;
        case (ArtigoTypes.eventos):
          artigo.conteudo.sort((a, b) {
            return (a['index'] as int).compareTo(b['index'] as int);
          });
          _eventos.add(artigo);
          break;
        case (ArtigoTypes.quem):
          artigo.conteudo.sort((a, b) {
            return (a['index'] as int).compareTo(b['index'] as int);
          });
          _quemSomos.add(artigo);
          break;
      }
    }

    // addArtigo(_artigos);

    quemSomos = _quemSomos;
    eventos = _eventos;
    artigosXadrex = _artigos;
    artigos = _artigos;
    isDestaque = _destaque;
    filteredArtigos = _artigos;

    notifyListeners();
  }

  ScreenshotController screenshotController = ScreenshotController();
  String newTitle = '';
  switchPlace(bool isUp, dynamic text, int index) {
    if (isUp) {
      _newArtigo.insert((index - 1), text);
      _newArtigo.removeAt((index + 1));
    } else {
      _newArtigo.insert((index + 2), text);
      // _newArtigo[(index + 1)] = text;
      _newArtigo.removeAt(index);
    }
    notifyListeners();
  }

  // Artigo? _artigoEnded;
  List<Artigo> _artigos = [];
  List<Artigo> _quemSomos = [];
  List<Artigo> _eventos = [];
  List<Artigo> _artigosXadrex = [];
  List<Artigo> _isDestaque = [];
  List<Artigo> _filteredArtigos = [];

  List<dynamic> _newArtigo = [
    // 'https://www.youtube.com/watch?v=KgUsJ5RhgQM',
    // "first element",
    // "second element",
    // "third element",
    // "fifth element",
    // "example 6",
    // "example 7",
    // "example 8",
  ];
  Artigo? _toUpdateArt;
  Artigo? get toUpdateArt => _toUpdateArt;
  zerarUpdateArt() {
    _toUpdateArt = null;
    _newArtigo = [];
    _toUpload = [];
  }

  int _currentArtigo = 0;
  String artType = 'artigo';
  List<Artigo> get artigos => _artigos;
  List<Artigo> get quemSomos => _quemSomos;
  List<Artigo> get artigosXadrex => _artigosXadrex;
  List<Artigo> get eventos => _eventos;
  List<Artigo> get isDestaque => _isDestaque;
  List<Artigo> get filteredArtigos => _filteredArtigos;
  List<dynamic> get newArtigo => _newArtigo;
  int get currentArtigo => _currentArtigo;
  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  transformToEditArtigo(Artigo art) {
    _toUpdateArt = art;
    List convertido = art.conteudo.map((e) {
      return e['content'];
    }).toList();
    _newArtigo = convertido;
    notifyListeners();
  }

  set isUpdating(bool value) {
    _isUpdating = value;
    notifyListeners();
  }

  void addTexto(dynamic text, {bool remove = false}) {
    if (remove) {
      _newArtigo.remove(text);
    } else {
      _newArtigo.add(text);
    }
    notifyListeners();
  }

  void setList({required int oldI, required int newI}) {
    final dynamic artItem = newArtigo.removeAt(oldI);
    newArtigo.insert(newI, artItem);
    notifyListeners();
  }

  deleteArtigo() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('imagens/artigos/${_artigos[currentArtigo].id}');
    for (var art in _artigos[currentArtigo].conteudo) {
      art as Map;
      if (art['type'] == 'image') {
        imagesToBeDeleted.add(art['content']);
      }
    }
    debugPrint(storageReference.fullPath);
    // await storageReference.delete();

    await FirebaseFirestore.instance
        .collection('artigos')
        .doc(_artigos[currentArtigo].id)
        .delete();
  }

  List<String> imagesToBeDeleted = [];

  Future<void> deleteImage() async {
    for (var element in imagesToBeDeleted) {
      Reference storageReference = FirebaseStorage.instance.refFromURL(element);
      debugPrint(storageReference.fullPath);
      await storageReference.delete();
    }
    imagesToBeDeleted = [];
  }

  List<Map<String, dynamic>> _toUpload = [];

  // List<String> get productImages => _productImages;
  Future<void> _uploadImage(String id) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    for (var _content in _newArtigo) {
      int index = _newArtigo.indexOf(_content);
      if (_content is Uint8List) {
        Reference imageRef =
            _storage.ref("imagens/artigos/$id/${const Uuid().v1()}.jpg");
        debugPrint('mano, sequer ta aqu11111111i?');
        UploadTask uploadTask = imageRef.putData(_content);
        TaskSnapshot snap = await uploadTask;
        String link = await snap.ref.getDownloadURL();
        debugPrint(link);
        _toUpload.add({
          'content': link,
          'index': index,
          'type': 'image',
        });
      } else {
        _toUpload.add({
          'content': _content.contains('bold')
              ? _content.replaceAll('isBOLD', '').trim()
              : _content,
          'index': index,
          'type': _content.startsWith('https://chessboardimage.com/')
              ? 'diagram'
              : _content.startsWith('https://www.youtube.com/')
                  ? 'video'
                  : (_content as String).contains('firebase')
                      ? 'image'
                      : _content.contains('bold')
                          ? 'bold'
                          : 'text',
        });
      }
    }
  }

  Future<void> uploadArtigos(
      {required String title, required bool isDes}) async {
    CollectionReference artigoRef =
        FirebaseFirestore.instance.collection('artigos');
    Artigo _finalArtigo = Artigo(
        titulo: title,
        createdAt: Timestamp.now(),
        type: artType,
        isDestaque: isDes);

    if (isUpdating && _toUpdateArt != null) {
      Artigo _updatingArt = _toUpdateArt!;
      _updatingArt.isDestaque = isDes;
      await _uploadImage(_updatingArt.id!);
      _updatingArt.conteudo = _toUpload;
      if (title != '' && title.isNotEmpty) {
        _updatingArt.titulo = title;
      }
      await artigoRef.doc(_updatingArt.id).set(_updatingArt.toMap());
      await deleteImage();
      debugPrint('hora de atualizar essa bustanga 222');
      getArtigos();
      _toUpload = [];
    } else {
      DocumentReference documentRef = await artigoRef.add(_finalArtigo.toMap());
      _finalArtigo.id = documentRef.id;

      await _uploadImage(documentRef.id);
      _finalArtigo.conteudo = _toUpload;
      await documentRef.update(_finalArtigo.toMap());
      getArtigos();
      _toUpload = [];
    }
  }

  set artigos(List<Artigo> _artigos) {
    this._artigos = _artigos;
    notifyListeners();
  }

  set isDestaque(List<Artigo> _artigos) {
    _isDestaque = _artigos;
    notifyListeners();
  }

  set artigosXadrex(List<Artigo> _artigos) {
    _artigosXadrex = _artigos;
    notifyListeners();
  }

  set quemSomos(List<Artigo> _artigos) {
    _quemSomos = _artigos;
    notifyListeners();
  }

  set eventos(List<Artigo> _artigos) {
    _eventos = _artigos;
    notifyListeners();
  }

  set filteredArtigos(List<Artigo> _artigos) {
    _filteredArtigos = _artigos;
    notifyListeners();
  }

  set newArtigo(List<dynamic> _artigos) {
    _newArtigo = _artigos;
    notifyListeners();
  }

  set currentArtigo(int _artigo) {
    _currentArtigo = _artigo;
    notifyListeners();
  }
}
