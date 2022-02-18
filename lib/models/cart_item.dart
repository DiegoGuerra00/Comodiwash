/// Class defining the the item in the shopping cart
class CartItem {
  String icon;
  String name;
  int price;
  int qtd;

  CartItem({
    required this.icon,
    required this.name,
    required this.price,
    required this.qtd
  });
}
