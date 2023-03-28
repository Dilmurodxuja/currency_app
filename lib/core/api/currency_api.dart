import 'package:currency_app/core/api/api_base.dart';
import 'package:currency_app/core/models/currency_model.dart';

class CurrencyApi{
  final ApiBase _base;

  CurrencyApi(this._base);

  Future<List<CurrencyModel>> getCurrencies({DateTime? date}) async{
    var url = "/uz/arkhiv-kursov-valyut/json/";
    if(date != null) {
      url = "${url}all/${date.year}-${date.month}-${date.day}/";
    }
    final response = await _base.dio.get(url);
    return (response.data as List)
        .map((e) => CurrencyModel.fromJson(e))
        .toList();
  }
}