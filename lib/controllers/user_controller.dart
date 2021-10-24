import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:topxadrez/models/user_modal.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class UserController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  List<UserModel> listOfUsers = [];

  UserController() {
    authCheck();
  }

  authCheck() {
    _auth.authStateChanges().listen((User? user) async {
      usuario = (user == null) ? null : user;
      if (usuario != null) {
        await _getCurrentUser(usuario!.uid);
      }
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      } else {
        throw AuthException(
            'Erro desconhecido ao criar conta. Tente novamente');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
      await _getCurrentUser(usuario!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      } else {
        throw AuthException('Erro ao logar... Tente novamente');
      }
    }
  }

  logout() async {
    currentUser = null;
    await _auth.signOut();
    _getUser();
  }

  UserModel? _currentUser;
  UserModel? toEditUser;
  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  UserModel? get currentUser => _currentUser;
  set currentUser(UserModel? value) {
    _currentUser = value;
    notifyListeners();
  }

  set isUpdating(bool value) {
    _isUpdating = value;
    notifyListeners();
  }

  _getCurrentUser(String userID) async {
    var snap =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    currentUser = UserModel.fromMap(snap.data());
    final docAdmin = await FirebaseFirestore.instance
        .collection('admins')
        .doc(usuario!.uid)
        .get();
    if (docAdmin.exists) {
      currentUser!.isAdmin = true;
      currentUser!.isAfiliado = true;
      await _getList();
    }
    notifyListeners();
  }

  _getList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snap =
          await FirebaseFirestore.instance.collection('users').get();

      List<UserModel> _users = [];

      for (var doc in snap.docs) {
        UserModel product = UserModel.fromMap(doc.data());
        _users.add(product);
      }

      // addArtigo(_artigos);
      listOfUsers = _users;
    } catch (e) {
      return [];
    }
  }
}
