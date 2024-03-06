import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/wallet_state.dart';

class WalletBloc extends Cubit<WalletState> {
  final PardakhtRepository _gateway;
  WalletBloc({required PardakhtRepository gateway})
      : _gateway = gateway,
        super(const WalletState.init());
}
