import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/user_modal.dart';

class AssociadoScreen extends StatelessWidget {
  const AssociadoScreen({Key? key}) : super(key: key);

  Widget buildAssociadoTile(
    String name,
    bool isActive,
    BuildContext context,
    UserModel user,
  ) {
    return InkWell(
      onTap: () {
        context.read<UserController>().toEditUser = user;
        context.read<UserController>().isUpdating = true;
        context.read<ScreenController>().currentPage = 14;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 4, 125, 141),
          ),
        ),
        height: 30,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 125, 141),
              ),
            ),
            const Spacer(),
            if (user.isAfiliado)
              Text(
                'Dia de pagamento: ${user.payday!.day}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            const Spacer(),
            const Text(
              'Status: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            isActive
                ? const Text(
                    'Ativo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  )
                : const Text(
                    'Desativado',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.read<UserController>().isUpdating = false;
              context.read<UserController>().toEditUser = null;
              context.read<ScreenController>().currentPage = 14;
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff2074ac),
            ),
            child: const Text('Cadastrar novo associado'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.read<UserController>().isUpdating = false;
              context.read<UserController>().toEditUser = null;
              context.read<ScreenController>().currentPage = 16;
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff2074ac),
            ),
            child: const Text('Gerar Comprovante'),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Painel de Associado',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 4, 125, 141),
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: context.watch<UserController>().listOfUsers.length,
          itemBuilder: (context, index) {
            List<UserModel> users = context.read<UserController>().listOfUsers;
            return buildAssociadoTile(users[index].nome,
                users[index].isAfiliado, context, users[index]);
          },
        ),
      ],
    );
  }
}
