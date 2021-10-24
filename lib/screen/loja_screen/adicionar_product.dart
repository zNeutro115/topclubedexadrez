import 'package:flutter/material.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/controllers/loja_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/models/product_model.dart';
import 'package:topxadrez/screen/loja_screen/widgets/product_select.dart';
import 'package:provider/provider.dart';

class AdicionarProdutosScreen extends StatefulWidget {
  const AdicionarProdutosScreen({Key? key}) : super(key: key);

  @override
  State<AdicionarProdutosScreen> createState() =>
      _AdicionarProdutosScreenState();
}

class _AdicionarProdutosScreenState extends State<AdicionarProdutosScreen> {
  TextEditingController _controllerNome = TextEditingController(text: '');

  TextEditingController _controllerDescription =
      TextEditingController(text: '');

  TextEditingController _controllerPrice = TextEditingController(text: '');

  TextEditingController _controllerFrete = TextEditingController(text: '');

  @override
  void initState() {
    Product? product = context.read<LojaController>().currentProduc;
    if (context.read<LojaController>().currentProduc != null) {
      debugPrint('###################################################');
      _controllerFrete = TextEditingController(text: product!.frete);
      _controllerDescription = TextEditingController(text: product.descripion);
      _controllerNome = TextEditingController(text: product.title);
      _controllerPrice = TextEditingController(text: product.price);
    }
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProductSelect(),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _controllerNome,
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
            decoration: const InputDecoration(
              hintText: 'Nome',
              labelText: 'Nome',
              suffixIcon: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _controllerDescription,
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
            decoration: const InputDecoration(
              hintText: 'Descrição',
              labelText: 'Descrição',
              suffixIcon: Icon(
                Icons.description_outlined,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _controllerPrice,
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
            decoration: const InputDecoration(
              hintText: 'Preço',
              labelText: 'Preço',
              suffixIcon: Icon(
                Icons.attach_money,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
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
            controller: _controllerFrete,
            decoration: const InputDecoration(
              hintText: 'Frete',
              labelText: 'Frete',
              suffixIcon: Icon(
                Icons.format_line_spacing,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (context.read<LojaController>().currentProduc == null) {
                if (context.read<LojaController>().images.isEmpty) {
                  Utils.buildErrorMensage(context,
                      text: 'PORFAVOR COLOQUE UMA IMAGEM!');
                  return;
                }
              } else {
                if (context.read<LojaController>().images.isEmpty &&
                    context
                        .read<LojaController>()
                        .currentProduc!
                        .images!
                        .isEmpty) {
                  Utils.buildErrorMensage(context,
                      text: 'PORFAVOR COLOQUE UMA IMAGEM!');
                  return;
                }
              }
              if (!_formKey.currentState!.validate()) {
                return;
              }

              await context.read<LojaController>().uploadProduct(
                    title: _controllerNome.text,
                    price: _controllerPrice.text,
                    description: _controllerDescription.text,
                    frete: _controllerFrete.text,
                    isUpdating:
                        context.read<LojaController>().currentProduc != null,
                  );
              context.read<LojaController>().currentProduc = null;
              _controllerNome.text = '';
              _controllerDescription.text = '';
              _controllerPrice.text = '';
              context.read<ScreenController>().currentPage = 3;
            },
            style: ElevatedButton.styleFrom(primary: const Color(0xff2074ac)),
            child: const Text('Salvar Produto'),
          ),
        ],
      ),
    );
  }
}
