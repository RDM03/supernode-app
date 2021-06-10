import 'package:bloc/bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/state.dart';

const Map map2serverCurrency = {'MXC': 'ETH_MXC', 'DHX': 'DHX', 'BTC': 'BTC'};

class WithdrawCubit extends Cubit<WithdrawState> {
  final SupernodeUserCubit supernodeUserCubit;
  final AppCubit appCubit;
  final SupernodeRepository supernodeRepository;

  WithdrawCubit(
      this.supernodeUserCubit, this.appCubit, this.supernodeRepository)
      : super(WithdrawState());

  Future<void> withdrawFee(Token tkn) async {
    try {
      WithdrawFee withdrawFee = await supernodeRepository.withdraw
          .fee(currency: map2serverCurrency[tkn.name]);

      emit(state.copyWith(token: tkn, fee: withdrawFee.withdrawFee));
    } catch (err) {
      appCubit.setError('WithdrawDao fee: $err');
    }
  }

  Future<void> requestTOTPStatus() async {
    try {
      TotpEnabledResponse res = await supernodeRepository.user.getTOTPStatus();

      if (res.enabled != null) {
        emit(state.copyWith(isEnabled: res.enabled));
      }
    } catch (err) {
      appCubit.setError('$err');
    }
  }

  onAddressBook() {}

  void setAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void goToConfirmation(double amount, String address) {
    emit(state.copyWith(
        amount: amount,
        address: address,
        withdrawFlowStep: WithdrawFlow.confirm,
        confirmTime: DateTime.now().add(Duration(seconds: 30))));
  }

  void backToForm() {
    emit(state.copyWith(withdrawFlowStep: WithdrawFlow.form));
  }

  void gotoWithdrawSecurityCode() {
    emit(state.copyWith(withdrawFlowStep: WithdrawFlow.securityCode));
  }

  void backToConfirm() {
    emit(state.copyWith(withdrawFlowStep: WithdrawFlow.confirm));
  }

  Future<void> submit(String orgId, String otpCode) async {
    Map data = {
      "orgId": orgId,
      "amount": state.amount.toString(),
      "currency": map2serverCurrency[state.token.name],
      "ethAddress": state.address,
      "otp_code": otpCode
    };

    emit(state.copyWith(showLoading: true));
    try {
      dynamic withdrawReq =
          await supernodeUserCubit.supernodeRepository.withdraw.withdraw(data);
      emit(state.copyWith(showLoading: false));

      if (withdrawReq.status)
        emit(state.copyWith(withdrawFlowStep: WithdrawFlow.finish));
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError(err.toString());
    }
  }
}
