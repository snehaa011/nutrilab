class MenuItemModel {
  final String name;
  final String des;
  final String img;
  final String ingr;
  final String type;
  final int cal;
  final int price;
  final String itemId;
  final bool isLiked;
  final bool isInCart;

  MenuItemModel({
    required this.name,
    required this.des,
    required this.img,
    required this.ingr,
    required this.type,
    required this.cal,
    required this.price,
    required this.itemId,
    required this.isLiked,
    required this.isInCart
  });

  factory MenuItemModel.fromMap(Map<String, dynamic> data) {
    return MenuItemModel(
      name: data['name'],
      des: data['des'],
      img: data['img'],
      ingr: data['ingr'],
      type: data['type'],
      cal: data['cal'],
      price: data['price'],
      itemId: data['itemId'],
      isLiked: data['isLiked'],
      isInCart: data['isInCart']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'des': des,
      'img': img,
      'ingr': ingr,
      'type': type,
      'cal': cal,
      'price': price,
      'itemId': itemId,
      'isLiked': isLiked,
      'isInCart': isInCart
    };
  }
}
