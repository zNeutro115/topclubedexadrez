class Product {
  String? id;
  String title = 'nenhum título selecionado.';
  String price = '3.14';
  String descripion = 'sem descrição.';
  String frete = '20.00';
  // late double peso;
  // late double altura;
  // late double largura;
  // late double comprimento;

  List<dynamic>? images = [];

  Product.fromMap(dynamic data) {
    title = data['title']! as String;
    price = data['price']! as String;
    descripion = data['description']! as String;
    frete = data['frete']! as String;
    // peso = data['peso']! as double;
    // altura = data['altura']! as double;
    // largura = data['largura']! as double;
    // comprimento = data['comprimento']! as double;
    images = data['images']! as List<dynamic>;
    id = data['id']!;
  }

  Product(
    this.title,
    this.price,
    this.frete,
    this.descripion,
    // this.peso,
    // this.altura,
    // this.largura,
    // this.comprimento,
    {
    this.id,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'description': descripion,
      'images': images,
      'frete': frete,
      'id': id,

      // 'peso': peso,
      // 'altura': altura,
      // 'largura': largura,
      // 'comprimento': comprimento,
    };
  }
}
