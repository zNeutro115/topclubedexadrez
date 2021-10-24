import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EndingPageTab extends StatelessWidget {
  const EndingPageTab({Key? key}) : super(key: key);

  Widget buildMediaButton(String image, String text, {String link = ''}) {
    double num = 25;
    return TextButton.icon(
      icon: SizedBox(
        height: num,
        width: num,
        child: Image.asset(image),
      ),
      label: Text(
        text,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      onPressed: () async {
        if (await canLaunch(link)) launch(link);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: Colors.grey[400],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'TOP CLUBE DE XADREZ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 125, 141),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Nosso clube foi criado para ser um espaço onde os '
            'frequentadores do shopping possam conhecer, aprender e multiplicar a '
            'pratica do jogo de xadrez e também para os aficcionados poderem se '
            'reunir e praticar com seus amigos.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Local: (TOP SHOPPING - Terceiro Andar) Av. Gov. Roberto Silveira, 540 - Centro, Nova Iguaçu - RJ, 26285-060',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Contato:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              buildMediaButton(
                'assets/instagram.png',
                'Instagram',
                link: 'https://www.instagram.com/topclubxadrez/?hl=pt-br',
              ),
              buildMediaButton(
                'assets/facebook.png',
                'Facebook',
                link: 'https://www.facebook.com/TopClubdexadrez',
              ),
              buildMediaButton(
                'assets/youtube.png',
                'Youtube',
                link:
                    'https://www.youtube.com/channel/UCV4nU-0-DkqkDwmanIGfecg',
              ),
              buildMediaButton('assets/whatsapp.png', 'WhatsApp',
                  link:
                      'https://api.whatsapp.com/send?phone=5521973630631&text='
                      'Ol%C3%A1%2C%20gostaria%20de%20saber%20mais%20sobre%20o%20clube'
                      '%20de%20xadrez.'),
            ],
          ),
        ],
      ),
    );
  }
}
