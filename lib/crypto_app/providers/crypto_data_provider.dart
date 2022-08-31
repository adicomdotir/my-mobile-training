import 'package:first_flutter/crypto_app/models/all_crypto_model.dart';
import 'package:first_flutter/crypto_app/network/api_provider.dart';
import 'package:first_flutter/crypto_app/network/response_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late AllCryptoModel allCryptoModel;
  late ResponseModel state;
  late Response response;

  getTopMarketCapData() async {
    state = ResponseModel.loading('is Loading ...');
    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        allCryptoModel = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(allCryptoModel);
      } else {
        state = ResponseModel.error('Something wrong ...');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection');
      notifyListeners();
    }
  }
}
