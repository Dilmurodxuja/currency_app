import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_app/converting/convert_screen.dart';
import 'package:currency_app/core/api/currency_api.dart';
import 'package:currency_app/di.dart';
import 'package:currency_app/main/main_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  Widget get page => BlocProvider(
        create: (_) => MainBloc(di.get<CurrencyApi>())
          ..add(
            GetLastEvent(),
          ),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    print("object");
    final bloc = context.read<MainBloc>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("name".tr()),
            actions: [
              IconButton(
                onPressed: () {
                  bloc.add(GetLastEvent());
                },
                icon: Icon(Icons.refresh_rounded),
              ),
              IconButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    bloc.add(GetDateEvent(date));
                  }
                },
                icon: Icon(Icons.calendar_month),
              ),
              IconButton(
                onPressed: () async {
                  final date = await showModalBottomSheet<int>(
                    elevation: 2,
                    backgroundColor: Colors.transparent,
                    context: context,
                    // constraints: BoxConstraints.loose(Size(double.infinity,220)),
                    constraints: BoxConstraints.tightForFinite(width: double.infinity, height: 220),
                    builder: (context) {
                      return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            backgroundBlendMode: null,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.setLocale(const Locale("uz", "UZ"));
                                  Navigator.pop(context, 1);
                                },
                                child: Text("O'zbekcha"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.setLocale(const Locale("uz", "UZC"));
                                  Navigator.pop(context, 1);
                                },
                                child: Text("Ўзбекча"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.setLocale(const Locale("ru", "RU"));
                                  Navigator.pop(context, 1);
                                },
                                child: Text("Русский"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.setLocale(const Locale("en", "EN"));
                                  Navigator.pop(context, 1);
                                },
                                child: Text("English"),
                              ),
                            ],
                          ));
                    },
                  );
                  if (date != null) {
                    print(' * $date');
                    // bloc.add(MainGetDateEvent(date));
                  }
                },
                icon: Icon(Icons.language),
              ),
              SizedBox(width: 10),
            ],
          ),
          body: Builder(
            builder: (context) {
              switch (state.status) {
                case Status.initial:
                  return const Center(child: Text("hello"));
                case Status.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.fail:
                  return Center(child: Text("Error ${state.message}"));
                case Status.success:
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      itemCount: state.currencies.length,
                      itemBuilder: (context, index) {
                        if (index < 2) print('${state.currencies.length}');
                        final data = state.currencies[index];
                        final image = data.ccy.substring(0, 2).toLowerCase();
                        return Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: EdgeInsets.only(left: 5, top: 8, bottom: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                                color: Color(0xFFEEEEEE)
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ConvertScreen(currency: data).page,
                                )),
                            behavior: HitTestBehavior.opaque,
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "https://countryflagsapi.com/png/$image",
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 50,
                                      width: 76,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      height: 55,
                                      width: 76,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 28,),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      height: 55,
                                      width: 76,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${data.withLocale(context.locale).ccyNm}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            Text(
                                              "${data.diff}",
                                              style: TextStyle(
                                                  color: double.parse(data.diff) >= 0 ? Colors.green : Colors.red),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "1 ${data.ccy} = ${data.rate} UZS",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_right_rounded,
                                              size: 22,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(width: 12),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Spacer(),
                                            Icon(
                                              Icons.access_time,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "${data.date}",
                                              style: TextStyle(color: Colors.blue),
                                            ),
                                            SizedBox(width: 20),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                default:
                  return SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
