class MultipleProductHistory {
  String? totalBill;
  String? type;
  String? date;
  String? bread;
  String? meals;
  String? drink;
  String? eggs;

  MultipleProductHistory(
      {this.totalBill,
      this.type,
      this.date,
      this.bread,
      this.meals,
      this.drink,
      this.eggs});

  MultipleProductHistory.fromJson(Map<String, dynamic> json) {
    totalBill = json['totalBill'];
    type = json['type'];
    date = json['date'];
    bread = json['bread'];
    meals = json['meals'];
    drink = json['drink'];
    eggs = json['eggs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalBill'] = totalBill;
    data['type'] = type;
    data['date'] = date;
    data['bread'] = bread;
    data['meals'] = meals;
    data['drink'] = drink;
    data['eggs'] = eggs;
    return data;
  }
}
