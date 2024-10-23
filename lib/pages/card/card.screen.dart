import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/pages/card/card.ctrl.dart';
import 'package:get_x_test/pages/card/card_form_screen.dart';

class CardListScreen extends StatelessWidget {
  final CardController cardController = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('카드 목록')),
      body: Obx(() => ListView.builder(
            itemCount: cardController.cards.length,
            itemBuilder: (context, index) {
              final card = cardController.cards[index];
              return ListTile(
                title: Text(
                  card.cardName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(card.cardNumber),
                    Text(card.cardHolderName),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => cardController.deleteCard(card.id),
                ),
                // 수정 화면으로 이동
                onTap: () => Get.to(() => CardFormScreen(card: card)),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(() => CardFormScreen()),
      ),
    );
  }
}
