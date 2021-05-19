import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'state.freezed.dart';

enum AddMinerFlow { form, confirm, setting, success, failure, warning }

@freezed
abstract class MinerState with _$MinerState {
  MinerState._();

  factory MinerState({
    @Default(false) bool isRegisterResellerSuccess,
    String serialNumber,
    Color textColor,
    List networkServerList,
    String networkServerId,
    String networkServerName,
    List minerProfileList,
    String minerProfileId,
    String minerProfileName,
    int smb,
    String name,
    String description,
    String id,
    @Default(true) bool discoveryEnabled,
    double altitude,
    @Default(AddMinerFlow.form) AddMinerFlow addMinerFlowStep,
    String message,
    @Default(false) bool showLoading,
  }) = _MinerState;
}