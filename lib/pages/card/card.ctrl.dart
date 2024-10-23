import 'package:get/get.dart';
import 'package:get_x_test/model/card_model.dart';

class CardController extends GetxController {
  var cards = <CardModel>[].obs;

  void addCard(CardModel card) {
    cards.add(card);
  }

  void updateCard(String id, CardModel updatedCard) {
    final index = cards.indexWhere((card) => card.id == id);
    if (index != -1) {
      cards[index] = updatedCard;
    } else {
      Get.snackbar('오류', '해당 ID의 카드를 찾을 수 없습니다.');
      throw Exception('Card not found');
    }
  }

  void deleteCard(String id) {
    cards.removeWhere((card) => card.id == id);
  }

  List<CardModel> getCards() {
    return cards;
  }
}
