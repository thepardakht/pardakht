import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/blocs/states/verification_state.dart';

class VerificationBloc extends Cubit<VerificationState> {
  final PardakhtRepository _gateway;
  VerificationBloc({required PardakhtRepository pardakhtGateway})
      : _gateway = pardakhtGateway,
        super(const VerificationState.init());

  void toInitState() {
    emit(const VerificationState.init());
  }

  void toIdleState() {
    emit(state.idleState());
  }

  void sendEmailVerificationCode() {
    emit(state.loadingState(VerificationStateStatus.isSending));
    try {
      _gateway.sendEmailVerificationCode();
      emit(state.successState(VerificationStateStatus.isSend));
    } catch (e) {
      emit(
        state.failureState(
          VerificationStateStatus.failedSend,
          error: e.toString(),
        ),
      );
    }
  }

  void verifyEmail(String code) {
    emit(state.loadingState(VerificationStateStatus.isVerifying));
    try {
      _gateway.verifyEmailVerificationCode(code);
      emit(state.successState(VerificationStateStatus.isVerified));
    } catch (e) {
      emit(
        state.failureState(
          VerificationStateStatus.faildVerify,
          error: e.toString(),
        ),
      );
    }
  }
}
