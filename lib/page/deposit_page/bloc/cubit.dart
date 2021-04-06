import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/cubit.dart';

import 'state.dart';

class DepositCubit extends Cubit<DepositState> {
  final SupernodeUserCubit supernodeUserCubit;
  final AppCubit appCubit;
  final SupernodeRepository supernodeRepository;

  DepositCubit(this.supernodeUserCubit, this.appCubit, this.supernodeRepository) : super(DepositState());

  Future<void> loadAddress(String currency) async {
    emit(state.copyWith(address: Wrap.pending()));
    String orgId = supernodeUserCubit.orgId;

    try {
      Map data = {
        "orgId": orgId,
        "currency": map2serverCurrency[currency],
      };

      TopupAccount res = await supernodeRepository.topup.account(data);
      emit(state.copyWith(address: Wrap(res.activeAccount)));
    } catch (err) {
      appCubit.setError(err.toString());
    }
  }

  void copy() {
    Clipboard.setData(ClipboardData(text: state.address.value));
  }
}
