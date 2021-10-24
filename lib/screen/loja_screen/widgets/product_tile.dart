import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/loja_controller.dart';

import 'package:topxadrez/controllers/page_controller.dart';

class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LojaController>(
      builder: (context, productManager, __) {
        return InkWell(
          onTap: () {
            productManager.currentProduc = productManager.products[index];
            context.read<ScreenController>().currentPage = 4;
          },
          child: Container(
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
            // height: 150,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                productManager.products[index].images!.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 110,
                        width: 150,
                        child: Image(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            productManager.products[index].images![0],
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 100,
                        height: 110,
                        child: Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        productManager.products[index].price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 125, 141),
                        ),
                      ),
                      Text(
                        productManager.products[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
