import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/auth_state.dart';
import 'package:pardakht/src/blocs/states/verification_state.dart';

class VerificationBloc extends Cubit<VerificationState> {
  final PardakhtRepository _gateway;
  final AuthState _authState;
  VerificationBloc(
      {required PardakhtRepository pardakhtGateway,
      required AuthState authState})
      : _gateway = pardakhtGateway,
        _authState = authState,
        super(const VerificationState.init());

  void toInitState() {
    emit(const VerificationState.init());
  }

  void toIdleState() {
    emit(state.idleState());
  }

}
