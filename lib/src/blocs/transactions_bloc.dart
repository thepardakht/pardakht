import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/transactions_state.dart';

class TransactionsBloc extends Cubit<TransactionsState> {
  final PardakhtRepository _gateway;
  TransactionsBloc({required PardakhtRepository gateway})
      : _gateway = gateway,
        super(const TransactionsState.init()) {
    fetchUserTransactions();
  }

  StreamSubscription<void>? _transactionSub;
  void fetchUserTransactions() async {
    emit(state.fetchingState());
    _transactionSub = _gateway.fetchUserTransactions().listen((event) {
      emit(state.fetchedState(transactions: event));
    }, onError: (err) {
      emit(state.failedFetchState('$err'));
    });
  }

  @override
  Future<void> close() {
    _transactionSub?.cancel();
    return super.close();
  }
}
