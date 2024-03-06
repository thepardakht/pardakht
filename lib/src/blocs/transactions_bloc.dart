import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/transactions_state.dart';

class TransactionsBloc extends Cubit<TransactionsState> {
  final PardakhtRepository _gateway;
  TransactionsBloc({required PardakhtRepository gateway})
      : _gateway = gateway,
        super(const TransactionsState.init());
}
