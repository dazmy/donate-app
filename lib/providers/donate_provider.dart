import 'dart:convert';

import 'package:donate_app/global/constant.dart';
import 'package:donate_app/models/donate_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonateProvider with ChangeNotifier {
  DonateModel _donateModel = DonateModel(0, "", 0, 0, DateTime.parse('2001-01-01 00:00:00'), DateTime.parse('2001-01-01 00:00:00'), DateTime.parse('2001-01-01 00:00:00'));
  List<DonateModel> _listDonateModel= [];
  int _totalDonation = 0;

  DonateModel get donateModel => _donateModel;

  set donateModel(DonateModel value) {
    _donateModel = value;
    notifyListeners();
  }

  List<DonateModel> get listDonateModel => _listDonateModel;

  set listDonateModel(List<DonateModel> value) {
    _listDonateModel = value;
    notifyListeners();
  }

  int get totalDonation => _totalDonation;

  set totalDonation(int value) {
    _totalDonation = value;
    notifyListeners();
  }

  // CRUD BELOW
  // READ ALL
  Future<bool> getAllDonation() async {
    try {
      var url = Uri.parse('${Constant.baseUrl}/donations');
      var headers = {
        'Accept': 'application/json'
      };

      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      print(response.body);
      // better with logging

      if (response.statusCode == 200) {
        int totalDonation = jsonDecode(response.body)['data']['total_donation'];
        _totalDonation = totalDonation;

        List donate = jsonDecode(response.body)['data']['donations'];
        List<DonateModel> listDonateModel = donate.map((e) => DonateModel.fromJson(e)).toList();
        _listDonateModel = listDonateModel;

        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  // INSERT DONATION
  Future<bool> insertDonation(String nameDonation, String donationAmount, String donationDate) async {
    try {
      var url = Uri.parse('${Constant.baseUrl}/donations');
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var body = {
        'donation_name': nameDonation,
        'donation_amount_plus': int.parse(donationAmount),
        'donation_amount_minus': 0,
        'donation_date': donationDate
      };

      var response = await http.post(url, headers: headers, body: jsonEncode(body));
      print(response.statusCode);
      // better with logging

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  // DELETE DONATION
  Future<bool> deleteDonation(int id) async {
    try {
      var url = Uri.parse('${Constant.baseUrl}/donations/$id');
      var headers = {
        'Accept': 'application/json'
      };

      var response = await http.delete(url, headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  // UPDATE DONATION
  Future<bool> updateDonation(String nameDonation, String donationAmount, String donationDate, int id) async {
    try {
      var url = Uri.parse('${Constant.baseUrl}/donations/$id');
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var body = {
        'donation_name': nameDonation,
        'donation_amount_plus': int.parse(donationAmount),
        'donation_amount_minus': 0,
        'donation_date': donationDate
      };

      var response = await http.put(url, headers: headers, body: jsonEncode(body));
      print(response.statusCode);
      print(response.body);
      // better with logging

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}