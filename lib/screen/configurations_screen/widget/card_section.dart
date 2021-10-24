import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:topxadrez/screen/configurations_screen/card_back.dart';
import 'package:topxadrez/screen/configurations_screen/card_front.dart';

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({Key? key}) : super(key: key);

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();

  final FocusNode dateFocus = FocusNode();

  final FocusNode nameFocus = FocusNode();

  final FocusNode cvvFocus = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        actions: [
          KeyboardActionsItem(focusNode: numberFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: dateFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: nameFocus, toolbarButtons: [
            (_) {
              return GestureDetector(
                onTap: () {
                  cardKey.currentState?.toggleCard();
                  cvvFocus.requestFocus();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text('CONTINUAR'),
                ),
              );
            }
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      autoScroll: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(100, 16, 100, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlipCard(
              key: cardKey,
              direction: FlipDirection.HORIZONTAL,
              speed: 700,
              flipOnTouch: false,
              front: CardFront(
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finished: () {
                  cardKey.currentState!.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(
                cvvFocus: cvvFocus,
              ),
            ),
            TextButton(
              onPressed: () {
                cardKey.currentState!.toggleCard();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'Virar cartão',
                style: TextStyle(color: Color.fromARGB(255, 4, 125, 141)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
