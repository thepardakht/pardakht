import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/wallet_state.dart';

class WalletBloc extends Cubit<WalletState> {
  final PardakhtRepository _gateway;
  WalletBloc({required PardakhtRepository gateway})
      : _gateway = gateway,
        super(const WalletState.init()) {
    fetchCurrenAccount();
  }

  StreamSubscription<void>? _walletSub;
  void fetchCurrenAccount() async {
    _walletSub?.cancel();
    _walletSub = _gateway.fetchCurrentUserWallet().listen((event) {
      emit(state.fetchedState(
        wallet: event,
      ));
    }, onError: (err) {
      emit(state.failedFetchState('$err'));
    });
  }

  @override
  Future<void> close() {
    _walletSub?.cancel();
    return super.close();
  }
}
