class MultipleProductHistory {
  String? totalBill;
  String? type;
  String? date;
  String? bread;
  String? meals;
  String? drink;
  String? eggs;
  String? flour;
  String? rice;
  String? biscuits;
  String? chocolates;

  MultipleProductHistory(
      {this.totalBill,
      this.type,
      this.date,
      this.bread,
      this.rice,
      this.flour,
      this.chocolates,
      this.biscuits,
      this.meals,
      this.drink,
      this.eggs});

  MultipleProductHistory.fromJson(Map<String, dynamic> json) {
    totalBill = json['totalBill'];
    type = json['type'];
    date = json['date'];
    bread = json['bread'];
    biscuits = json['biscuits'];
    meals = json['meals'];
    drink = json['drink'];
    rice = json['rice'];
    chocolates = json['chocolates'];
    flour = json['flour'];
    eggs = json['eggs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalBill'] = totalBill;
    data['type'] = type;
    data['date'] = date;
    data['bread'] = bread;
    data['meals'] = meals;
    data['flour'] = flour;
    data['drink'] = drink;
    data['rice'] = rice;
    data['chocolates'] = chocolates;
    data['biscuits'] = biscuits;
    data['eggs'] = eggs;
    return data;
  }
}
