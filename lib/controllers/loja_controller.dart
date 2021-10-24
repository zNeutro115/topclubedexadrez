import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:topxadrez/models/product_model.dart';
import 'package:uuid/uuid.dart';

class LojaController extends ChangeNotifier {
  LojaController() {
    getProducts();
  }

  getProducts() async {
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('produtos').get();

    List<Product> _downloadedProducts = [];

    for (var doc in snap.docs) {
      Product product = Product.fromMap(doc.data());

      _downloadedProducts.add(product);
    }

    // addArtigo(_artigos);
    _products = _downloadedProducts;
    notifyListeners();
  }

  String? currentCep;
  set setCurrentCep(String cep) {
    currentCep = cep;
    notifyListeners();
  }

  List<Uint8List> _images = [];
  List<Uint8List> get images => _images;
  List<Product> _products = [];
  List<Product> get products => _products;

  removeImage(Uint8List image) {
    if (_images.contains(image)) {
      _images.remove(image);
    }
    notifyListeners();
  }

  removeString(String image) {
    if (currentProduc!.images!.contains(image)) {
      currentProduc!.images!.remove(image);
    }
    notifyListeners();
  }

  setImages(Uint8List image) {
    _images.add(image);
    notifyListeners();
  }

  zerarImages() {
    _images = [];
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

  List<String> _productImages = [];

  Product? currentProduc;

  // List<String> get productImages => _productImages;
  Future<void> _uploadImage(String id) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    if (_images.isNotEmpty) {
      for (Uint8List image in _images) {
        Reference imageRef =
            _storage.ref("imagens/products/$id/${const Uuid().v1()}.jpg");
        // Reference imageRef = _storage.ref().child(const Uuid().v1());
        debugPrint('mano, sequer ta aqu11111111i?');
        UploadTask uploadTask = imageRef.putData(image);
        TaskSnapshot snap = await uploadTask;
        String link = await snap.ref.getDownloadURL();
        _productImages.add(link);
      }
    }
  }

  Future<void> uploadProduct({
    required String title,
    required String price,
    required String description,
    required String frete,
    required bool isUpdating,
  }) async {
    // uploadArtigos(Artigo artigo, {bool isUpdating = false}) async {
    CollectionReference artigoRef =
        FirebaseFirestore.instance.collection('produtos');
    // Artigo artigo = await toArtigo(context, title);
    // print('sera q passou?');
    // List< Map<String, dynamic>>? listhehe = conteudoPronto();
    // if (listhehe == null) {
    //   print('deu ruim, é NULL!');
    // }
    Product _currentProduct = Product(
      title,
      price,
      frete,
      description,
    );

    if (isUpdating) {
      await _uploadImage(currentProduc!.id!);
      currentProduc!.images!.addAll(_productImages);
      await deleteImage();
      await getProducts();
      _images = [];
      _productImages = [];
    } else {
      DocumentReference documentRef =
          await artigoRef.add(_currentProduct.toMap());
      _currentProduct.id = documentRef.id;
      await _uploadImage(documentRef.id);
      _currentProduct.images = _productImages;
      await documentRef.set(_currentProduct.toMap());
      await getProducts();
      _images = [];
      _productImages = [];
    }
  }
}
