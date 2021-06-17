import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/select_picker.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/miner.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/page/home_page/gateway/bloc/state.dart';

class MinerCubit extends Cubit<MinerState> {
  // final SupernodeUserCubit supernodeUserCubit;
  final AppCubit appCubit;
  final SupernodeRepository supernodeRepository;
  final SupernodeCubit supernodeCubit;

  MinerCubit(this.appCubit, this.supernodeRepository, this.supernodeCubit)
      : super(MinerState());

  void setSerialNumber(String serialNumber) {
    List itemData = serialNumber.split(',');

    List snData = itemData[0].split(':');
    String number = snData[1];

    List macData = itemData[itemData.length - 1].split(':');
    String macAddress = macData.sublist(1, 4).join().toLowerCase() +
        'fffe' +
        macData.sublist(4).join().toLowerCase();

    emit(state.copyWith(serialNumber: number));
    emit(state.copyWith(id: macAddress));
  }

  void setFlowStep(AddMinerFlow step){
    emit(state.copyWith(addMinerFlowStep: step));
  }

  void changeColor(String text) {
    var textColor;

    if (text.length == 9 || text.length == 24) {
      textColor = Colors.green;
    } else {
      textColor = Colors.red;
    }
    emit(state.copyWith(textColor: textColor));
  }

  Future<void> dispathRegister(String serialNumber, {bool scan = true}) async {
    try {
      String number = serialNumber;

      if (scan) {
        List itemData = serialNumber.split(',');
        List snData = itemData[0].split(':');
        number = snData[1];
      }

      if (Reg.onValidSerialNumber(number)) {
        await register(number);
      } else if (serialNumber.length == 24) {
        await registerReseller(serialNumber);
      } else {
        emit(state.copyWith(serialNumber: serialNumber));
        emit(state.copyWith(addMinerFlowStep: AddMinerFlow.setting));
      }
    } catch (err) {
      tip('Scan Error: $err');
    }
  }

  Future<void> register(String serialNumber) async {
    try {
      String orgId = supernodeCubit.state.orgId;
      Map data = {"organizationId": orgId, "sn": serialNumber.trim()};

      emit(state.copyWith(showLoading: true));

      MinerRegister result = await supernodeRepository.gateways.register(data);
      // appCubit.setSuccess(result.status);
      emit(state.copyWith(addMinerFlowStep: AddMinerFlow.success));
      emit(state.copyWith(serialNumber: ''));

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      dispatchError(err);
    }
  }

  Future<void> registerReseller(String serialNumber) async {
    try {
      String orgId = supernodeCubit.state.orgId;
      Map data = {
        'manufacturerNr': serialNumber.trim(),
        'organizationId': orgId
      };

      emit(state.copyWith(showLoading: true));

      MinerRegister result =
          await supernodeRepository.gateways.registerReseller(data);
      emit(state.copyWith(isRegisterResellerSuccess: true));

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      dispatchError(err);
    }
  }

  Future<void> submitSerialNumber(String serialNumber) async {
    try {
      emit(state.copyWith(showLoading: true));

      await dispathRegister(serialNumber, scan: false);

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      emit(state.copyWith(showLoading: false));

      appCubit.setError(err.toString());
    }
  }

  // Miner Profile Setting
  Future<void> networkServerList() async {
    try {
      String orgId = supernodeCubit.state.orgId;
      Map data = {"offset": 0, "limit": 999};

      emit(state.copyWith(showLoading: true));

      if (orgId.isEmpty) {
        final result = await supernodeRepository.organization.list(data);

        supernodeCubit.setOrganizationId(result['result'][0]['id']);
        networkServerList.call();
        return;
      }

      data = {"organizationID": orgId, "offset": 0, "limit": 999};

      final result = await supernodeRepository.networkServer.list(data);
      mLog('NetworkServerDao list', result);

      if ((result as Map).containsKey('result') &&
          result['result'].length > 0) {
        emit(state.copyWith(networkServerList: result['result']));
      }

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      emit(state.copyWith(message: err.toString()));
    }
  }

  Future<void> networkServerPicker(BuildContext context) {
    int selectedIndex = -1;

    if (state.networkServerList == null || state.networkServerList.isEmpty) {
      appCubit.setError('no_data');
      return null;
    }

    List data = state.networkServerList.asMap().keys.map((index) {
      if (state.networkServerList[index]['id'] == state.networkServerId) {
        selectedIndex = index;
      }
      return state.networkServerList[index]['name'];
    }).toList();

    selectPicker(context, data: data, value: selectedIndex,
        onSelected: (index) {
      dynamic selectedData = state.networkServerList[index];

      emit(state.copyWith(networkServerId: selectedData['id']));
      emit(state.copyWith(networkServerName: selectedData['name']));

      if (state.minerProfileList == null || state.minerProfileList.isEmpty) {
        minerProfileList(selectedData['id']);
      }
    });
  }

  Future<void> minerProfileList(String id) async {
    try {
      Map data = {"networkServerID": id, "offset": 0, "limit": 999};

      final result = await supernodeRepository.gateways.profile(data);
      mLog('minerProfileList', result);

      mLog('Gateway profile', result);
      if (result.containsKey('result') && result['result'].length > 0) {
        emit(state.copyWith(minerProfileList: result['result']));
      }
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      emit(state.copyWith(message: err.toString()));
    }
  }

  void gatewayProfilePicker(BuildContext context) {
    int selectedIndex = -1;

    if (state.minerProfileList == null || state.minerProfileList.isEmpty) {
      appCubit.setError('no_data');
      return null;
    }

    List data = state.minerProfileList.asMap().keys.map((index) {
      if (state.minerProfileList[index]['id'] == state.minerProfileList) {
        selectedIndex = index;
      }

      return state.minerProfileList[index]['name'];
    }).toList();

    selectPicker(context, data: data, value: selectedIndex,
        onSelected: (index) {
      dynamic selectedData = state.minerProfileList[index];

      emit(state.copyWith(minerProfileId: selectedData['id']));
      emit(state.copyWith(minerProfileName: selectedData['name']));
    });
  }

  void changeDiscoveryEnabled(bool value) {
    emit(state.copyWith(discoveryEnabled: value));
  }

  Future<void> submitProfileSetting(
      {String networkServerId,
      String minerProfileId,
      String name,
      String description,
      String id,
      bool discoveryEnabled,
      String altitude}) async {
    try {
      emit(state.copyWith(showLoading: true));

      String orgId = supernodeCubit.state.orgId;

      Map data = {
        "gateway": {
          "id": id.trim(),
          "name": name.trim(),
          "description": description.trim(),
          "location": {
            "latitude": 0,
            "longitude": 0,
            "altitude": double.parse(altitude),
            "source": "UNKNOWN",
            "accuracy": 0
          },
          "organizationID": orgId,
          "discoveryEnabled": discoveryEnabled,
          "networkServerID": networkServerId,
          "gatewayProfileID": minerProfileId,
          /* "boards": [
            {
              "fpgaID": "string",
              "fineTimestampKey": "string"
            }
          ]*/
        }
      };

      final result = await supernodeRepository.gateways.add(data);
      mLog('GatewaysDao add', result);
      emit(state.copyWith(addMinerFlowStep: AddMinerFlow.success));

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      dispatchError(err);
    }
  }

  void dispatchError(err) {
    emit(state.copyWith(showLoading: false));
    emit(state.copyWith(message: err.toString()));
    emit(state.copyWith(addMinerFlowStep: AddMinerFlow.form));

    if (err.toString().contains('already registered')) {
      emit(state.copyWith(addMinerFlowStep: AddMinerFlow.warning));
    } else {
      emit(state.copyWith(addMinerFlowStep: AddMinerFlow.failure));
    }
  }
}
