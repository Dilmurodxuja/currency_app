import 'package:currency_app/core/api/api_base.dart';
import 'package:currency_app/core/api/currency_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

final GetIt di = GetIt.instance;

Future<void> setUp() async {
  await EasyLocalization.ensureInitialized();

  di.registerSingleton(ApiBase(
    Dio(
      BaseOptions(
        baseUrl: 'https://cbu.uz',
        connectTimeout: const Duration(seconds: 60),
      ),
    ),
  ));
  di.registerSingleton(CurrencyApi(di.get()));
}
