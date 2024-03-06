import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/transaction_state.dart';

class TransactionBloc extends Cubit<TransactionState> {
  final PardakhtRepository _gateway;
  TransactionBloc({required PardakhtRepository gateway})
      : _gateway = gateway,
        super(const TransactionState.init());
}
