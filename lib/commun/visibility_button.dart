import 'package:flutter/material.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/user_modal.dart';
import 'package:provider/provider.dart';

class VisibilityWidget extends StatelessWidget {
  final String text;
  final double? width;
  final String nivel;
  final Widget? widget;
  final int? page;
  final bool showSnack;
  final bool? willApear;
  final Future<void> Function()? onPressed;

  static const String admin = 'admin';
  static const String apenasAfiliado = 'apenasAfiliado';
  static const String semConta = 'semConta';
  static const String all = 'all';
  static const String logadoApenas = 'logadoApenas';
  const VisibilityWidget({
    this.onPressed,
    this.width,
    this.text = 'NÃO PASSADO',
    this.page,
    this.showSnack = false,
    this.nivel = 'all',
    this.widget,
    this.willApear,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenController config = context.watch<ScreenController>();
    UserModel? user = context.watch<UserController>().currentUser;
    String usuarioSituacao = user == null
        ? semConta
        : user.isAfiliado && !(user.isAdmin)
            ? apenasAfiliado
            : user.isAdmin
                ? admin
                : logadoApenas;
    return Visibility(
      visible: willApear ?? nivel == all ? true : nivel == usuarioSituacao,
      child: widget ??
          SizedBox(
            width: width ?? double.maxFinite,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2074ac),
              ),
              child: config.isLoading ? Utils.progress() : Text(text),
              onPressed: config.isLoading
                  ? null
                  : () async {
                      config.isLoading = true;
                      try {
                        if (onPressed != null) {
                          await onPressed!();
                        }
                        if (showSnack) {
                          Utils.buildErrorMensage(context,
                              text: 'SUCESSO!', color: Colors.green);
                        }
                        if (page != null) {
                          context.read<ScreenController>().currentPage = page!;
                        }
                      } catch (e) {
                        Utils.buildErrorMensage(context, error: e);
                        config.isLoading = false;
                      }
                      config.isLoading = false;
                    },
            ),
          ),
    );
  }
}
