import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/states/transaction_state.dart';
import 'package:pardakht/src/blocs/transaction_bloc.dart';

import 'package:pardakht/src/views/forms/form_create_transaction.dart';
import 'package:pardakht/src/views/screens/screen_error.dart';
import 'package:pardakht/src/views/screens/screen_loading.dart';

class ScreenCreateTransaction extends StatefulWidget {
  static const String path = "/transaction";
  final String? sendTo;
  const ScreenCreateTransaction({super.key, this.sendTo});

  @override
  State<ScreenCreateTransaction> createState() =>
      _ScreenCreateTransactionState();
}

class _ScreenCreateTransactionState extends State<ScreenCreateTransaction> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void transactionSendHandler() {
      final state = _formKey.currentState;
      if (state?.validate() == true) {
        state?.save();
        context.read<TransactionBloc>().sendMoney();
      }
    }

    var textButton = TextButton(
      // icon: const Icon(Icons.send_sharp),
      onPressed: transactionSendHandler,
      // icon: const Icon(Icons.send_sharp),
      child: const Text("Send"),
    );
    final appBar = AppBar(
      centerTitle: false,
      title: const Text("Transaction"),
      actions: [textButton],
    );
    return Scaffold(
        appBar: appBar,
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state.status.isCreating) {
              return const ScreenLoading();
            }
            if (state.status.isFailedCreate) {
              return ScreenError(
                state.error,
                onTryAgain: () => context.read<TransactionBloc>().toIdleState(),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: FormCreateTransaction(
                    initSendToValue: widget.sendTo,
                    formKey: _formKey,
                  ),
                )
              ],
            );
          },
        ));
  }
}
