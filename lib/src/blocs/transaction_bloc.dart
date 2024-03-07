import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/transaction_state.dart';

class TransactionBloc extends Cubit<TransactionState> {
  final PardakhtRepository _gateway;
  TransactionBloc({required PardakhtRepository gateway})
      : _gateway = gateway,
        super(const TransactionState.init());

  void toInitState() {
    emit(const TransactionState.init());
  }

  void toIdleState() {
    emit(state.idleState());
  }

  void setMessage(String? value) {
    if (value == null) return;
    final transaction = state.transaction.copyWith(description: value);
    emit(state.copyWith(transaction: transaction));
  }

  void setDestinationId(String? value) {
    if (value == null) return;
    final transaction = state.transaction.copyWith(destinationAccountId: value);
    emit(state.copyWith(transaction: transaction));
  }

  void setAmount(String? value) {
    if (value == null) return;
    final transaction =
        state.transaction.copyWith(amount: double.tryParse(value));
    emit(state.copyWith(transaction: transaction));
  }

  void sendMoney() {
    emit(state.creatingState());
    _gateway.createTransaction(state.transaction).then((_) {
      return emit(state.createdState());
    }).onError((error, stackTrace) => emit(state.failedCreateState("$error")));
  }
}
