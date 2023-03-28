import 'package:currency_app/ui/converting/convert_bloc.dart';
import 'package:currency_app/core/models/currency_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertScreen extends StatelessWidget {
  const ConvertScreen({Key? key, required this.currency}) : super(key: key);
  final CurrencyModel currency;

  Widget get page => BlocProvider(
        create: (_) => ConvertBloc()
          ..add(
            EnterRateEvent(currency.rate),
          ),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ConvertBloc>();
    return BlocBuilder<ConvertBloc, ConvertState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(currency.withLocale(context.locale).ccyNm),
          ),
          body: Center(
            heightFactor: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          onChanged: (v) {
                            if (v.isEmpty) {
                              bloc.add(TypeAmountEvent('0'));
                            } else {
                              bloc.add(TypeAmountEvent(v));
                            }
                          },
                          maxLines: 1,
                          decoration: const InputDecoration(
                            hintText: "Enter an amount here",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 42,
                        child: Text(
                          state.secondUzs ? currency.ccy : 'UZS',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        bloc.add(ChangeEvent());
                      },
                      child: const Text("Change")),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: state.calculated == 0 ? "Enter an amount" : '${state.calculated}',
                            hintStyle: TextStyle(
                              color: state.calculated == 0 ? Colors.grey : Colors.black,
                              fontSize: 16,
                            ),
                            hintMaxLines: 1,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 42,
                        child: Text(
                          state.secondUzs ? 'UZS' : currency.ccy,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
