class SingleProductHistory {
  String? totalBill;
  String? type;
  String? date;
  String? key;

  SingleProductHistory({this.totalBill, this.type, this.date, this.key});

  SingleProductHistory.fromJson(Map<String, dynamic> json) {
    totalBill = json['totalBill'];
    type = json['type'];
    date = json['date'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalBill'] = totalBill;
    data['type'] = type;
    data['key'] = key;
    data['date'] = date;
    return data;
  }
}
