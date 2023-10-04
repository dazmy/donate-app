class DonateModel {
  int id = 0;
  String donationName = "";
  int donationAmountPlus = 0;
  int donationAmountMinus = 0;
  DateTime donationDate = DateTime.parse('2001-01-01 00:00:00');
  DateTime createdAt = DateTime.parse('2001-01-01T23:42:18.000000Z');
  DateTime updatedAt = DateTime.parse('2001-01-01T23:42:18.000000Z');

  DonateModel(
      this.id,
      this.donationName,
      this.donationAmountPlus,
      this.donationAmountMinus,
      this.donationDate,
      this.createdAt,
      this.updatedAt);

  DonateModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    donationName = json["donation_name"];
    donationAmountPlus = json["donation_amount_plus"];
    donationAmountMinus = json["donation_amount_minus"];
    donationDate = DateTime.parse(json["donation_date"]);
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'donation_name': donationName,
      'donation_amount_plus': donationAmountPlus,
      'donation_amount_minus': donationAmountMinus,
      'donation_date': donationDate,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString()
    };
  }
}