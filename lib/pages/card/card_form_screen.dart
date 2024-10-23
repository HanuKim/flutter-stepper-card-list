import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_x_test/model/card_model.dart';
import 'package:get_x_test/pages/card/card.ctrl.dart';

class CardFormScreen extends StatefulWidget {
  final CardModel? card;

  CardFormScreen({this.card});

  @override
  _CardFormScreenState createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  final CardController cardController = Get.find();
  late final TextEditingController cardNameController;
  late final TextEditingController cardNumberController;
  late final TextEditingController cardHolderNameController;
  late final TextEditingController expiryDateController;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    cardNameController =
        TextEditingController(text: widget.card?.cardName ?? '');
    cardNumberController =
        TextEditingController(text: widget.card?.cardNumber ?? '');
    cardHolderNameController =
        TextEditingController(text: widget.card?.cardHolderName ?? '');
    expiryDateController =
        TextEditingController(text: widget.card?.expiryDate ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card == null ? '카드 추가' : '카드 수정'),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          bool isValid = false;
          switch (currentStep) {
            case 0:
              isValid = cardNameController.text.isNotEmpty;
              break;
            case 1:
              isValid = cardNumberController.text.length == 16 &&
                  int.tryParse(cardNumberController.text) != null;
              break;
            case 2:
              isValid = cardHolderNameController.text.isNotEmpty;
              break;
            case 3:
              isValid = expiryDateController.text.isNotEmpty &&
                  RegExp(r'^\d{2}/\d{2}$').hasMatch(expiryDateController.text);
              break;
          }

          if (isValid) {
            if (currentStep < 3) {
              setState(() {
                currentStep += 1;
              });
            } else {
              if (widget.card == null) {
                // 카드 추가 로직
                final newCard = CardModel(
                  id: DateTime.now().toString(),
                  cardName: cardNameController.text,
                  cardNumber: cardNumberController.text,
                  cardHolderName: cardHolderNameController.text,
                  expiryDate: expiryDateController.text,
                );
                cardController.addCard(newCard);
              } else {
                // 카드 수정 로직
                final updatedCard = CardModel(
                  id: widget.card!.id,
                  cardName: cardNameController.text,
                  cardNumber: cardNumberController.text,
                  cardHolderName: cardHolderNameController.text,
                  expiryDate: expiryDateController.text,
                );
                cardController.updateCard(widget.card!.id, updatedCard);
              }
              Get.back();
            }
          } else {
            Get.snackbar('오류', '올바른 형식으로 입력해주세요');
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: Text('카드 이름'),
            content: TextField(
              controller: cardNameController,
              decoration: InputDecoration(hintText: '카드 이름을 입력하세요'),
            ),
          ),
          Step(
            title: Text('카드 번호'),
            content: TextField(
              controller: cardNumberController,
              decoration: InputDecoration(hintText: '16자리 숫자를 입력하세요'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
            ),
          ),
          Step(
            title: Text('카드 소유자 이름'),
            content: TextField(
              controller: cardHolderNameController,
              decoration: InputDecoration(hintText: '카드 소유자 이름을 영문으로 입력하세요'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                LengthLimitingTextInputFormatter(30),
              ],
            ),
          ),
          Step(
            title: Text('만료일'),
            content: TextField(
              controller: expiryDateController,
              decoration: InputDecoration(hintText: 'MM/YY 형식으로 입력하세요'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                LengthLimitingTextInputFormatter(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
