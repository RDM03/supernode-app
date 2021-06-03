import 'package:bloc/bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/miner.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'state.dart';

class MinerStatsCubit extends Cubit<MinerStatsState> {
  MinerStatsCubit(
    this.appCubit,
    this.supernodeCubit,
    this.supernodeRepository,
  ) : super(MinerStatsState());

  final AppCubit appCubit;
  final SupernodeCubit supernodeCubit;
  final SupernodeRepository supernodeRepository;

  void tabTime(String time) {
    MinerStatsTime selectedTime = MinerStatsTime.week;

    if (time == 'week') {
      selectedTime = MinerStatsTime.week;
    } else if (time == 'month') {
      selectedTime = MinerStatsTime.month;
    } else {
      selectedTime = MinerStatsTime.year;
    }

    emit(state.copyWith(selectedTime: selectedTime));
  }

  void setSelectedType(MinerStatsType type) {
    emit(state.copyWith(selectedType: type));
  }

  int getNumBar() {
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      return 7;
    } else if (time == MinerStatsTime.month) {
      return 5;
    } else {
      return 12;
    }
  }

  String getTooltip(MinerStatsEntity item) {
    String label = '';
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      label = '${Tools.priceFormat(item.uptime / 3600, range: 0)} h';
    } else if (type == MinerStatsType.revenue) {
      label = '${Tools.priceFormat(item.revenue)} MXC';
    } else if (type == MinerStatsType.revenue) {
      label = '${Tools.priceFormat(item.received)}';
    } else {
      label = '${Tools.priceFormat(item.transmitted)}';
    }

    return label;
  }

  String getStatsTitle() {
    List titles = [];
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      titles = ['score_weekly_total', 'total_hours', 'total_hours'];
    } else if (type == MinerStatsType.revenue) {
      titles = ['weekly_amount', 'monthly_amount', 'yearly_amount'];
    } else {
      titles = ['weekly_packet', 'monthly_packet', 'yearly_packet'];
    }

    return titles[state.selectedTime?.index ?? 0];
  }

  String getStatsSubitle() {
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      return '${getUptimeWeekScore()} h';
    } else if (type == MinerStatsType.revenue) {
      return '${countTotal().toStringAsFixed(0)} MXC ${getRevenueWeekScore()}';
    } else if (type == MinerStatsType.frameReceived) {
      return '${countTotal().toStringAsFixed(0)}';
    } else {
      return '${countTotal().toStringAsFixed(0)}';
    }
  }

  String getUptimeWeekScore() {
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      return '(${(state.uptimeWeekScore * 100).toStringAsFixed(0)}%) ${countTotal().toStringAsFixed(0)}';
    }

    return '${countTotal().toStringAsFixed(0)}';
  }

  String getRevenueWeekScore() {
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      return '(${(countTotal() / state.originList.length).toStringAsFixed(0)}/day)';
    }

    return '';
  }

  double countTotal() {
    double total = 0;
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      for (int i = 0; i < state.originList.length; i++) {
        total += state.originList[i].uptime;
      }

      total = total / 3600;
    } else if (type == MinerStatsType.revenue) {
      for (int i = 0; i < state.originList.length; i++) {
        total += state.originList[i].revenue;
      }
    } else if (type == MinerStatsType.frameReceived) {
      for (int i = 0; i < state.originList.length; i++) {
        total += state.originList[i].received;
      }
    } else {
      for (int i = 0; i < state.originList.length; i++) {
        total += state.originList[i].transmitted;
      }
    }

    return total;
  }

  String getStartTimeLabel() {
    MinerStatsTime time = state.selectedTime;

    if (state.originList.isEmpty) return null;

    if (time == MinerStatsTime.week) {
      return TimeUtil.getMD(state.originList.last.date);
    } else if(time == MinerStatsTime.month){
      return TimeUtil.getMD(state.originList.last.date);
    } else {
      return TimeUtil.getMDY(state.originList.last.date);
    }
  }

  String getEndTimeLabel() {
    MinerStatsTime time = state.selectedTime;

    if (state.originList.isEmpty) return null;

    if (time == MinerStatsTime.week) {
      return TimeUtil.getMD(state.originList.first.date);
    } else if(time == MinerStatsTime.month){
      return TimeUtil.getMD(state.originList.first.date);
    } else {
      return TimeUtil.getMDY(state.originList.first.date);
    }
  }

  Future<void> dispatchData(
      {MinerStatsType type = MinerStatsType.uptime,
      MinerStatsTime time = MinerStatsTime.week,
      bool forward = true,
      DateTime endTime,
      String minerId}) async {
    switch (type) {
      case MinerStatsType.uptime:
      case MinerStatsType.revenue:
        getStatsMinerData(type, time, forward, endTime, minerId);
        break;
      case MinerStatsType.frameReceived:
      case MinerStatsType.frameTransmitted:
        getStatsFrameData(type, time, forward, endTime, minerId);
        break;
      default:
        break;
    }
  }

  DateTime getStartTime(MinerStatsTime time, DateTime startTime) {
    if (time == MinerStatsTime.week) {
      return startTime?.add(Duration(days: -6)) ??
          DateTime.now().add(Duration(days: -6));
    } else if (time == MinerStatsTime.month) {
      return startTime?.add(Duration(days: -30)) ??
          DateTime.now().add(Duration(days: -30));
    } else {
      return startTime?.add(Duration(days: -365)) ??
          DateTime.now().add(Duration(days: -365));
    }
  }

  DateTime getEndTime(MinerStatsTime time, DateTime endTime,
      {bool forward = true}) {
    DateTime tempDate;
    if (forward) {
      if (time == MinerStatsTime.week) {
        tempDate = endTime?.add(Duration(days: -1)) ??
            DateTime.now().add(Duration(days: -1));
      } else if (time == MinerStatsTime.month) {
        tempDate = endTime?.add(Duration(days: -30)) ??
            DateTime.now().add(Duration(days: -1));
      } else {
        tempDate = endTime?.add(Duration(days: -365)) ??
            DateTime.now().add(Duration(days: -1));
      }
    } else {
       if (time == MinerStatsTime.week) {
        tempDate = endTime?.add(Duration(days: 1)) ??
            DateTime.now().add(Duration(days: 1));
      } else if (time == MinerStatsTime.month) {
        tempDate = endTime?.add(Duration(days: 30)) ??
            DateTime.now().add(Duration(days: 30));
      } else {
        tempDate = endTime?.add(Duration(days: 365)) ??
            DateTime.now().add(Duration(days: 365));
      }
    }

    if (TimeUtil.isSameDay(DateTime.now(), tempDate) || tempDate.isAfter(DateTime.now())) {
      return DateTime.now().add(Duration(days: -1));
    }

    return tempDate;
  }

  Future<void> getStatsMinerData(MinerStatsType type, MinerStatsTime time,
      bool forward, DateTime endTime, String minerId) async {
    DateTime startTime;

    endTime = getEndTime(time, endTime, forward: forward);
    startTime = getStartTime(time, endTime);

    await getSourceMinerData(
      gatewayMac: minerId,
      orgId: supernodeCubit.state.orgId,
      fromDate: DateTime.utc(startTime.year, startTime.month, startTime.day),
      tillDate: DateTime.utc(endTime.year, endTime.month, endTime.day),
      startTime: startTime,
      endTime: endTime,
      successCB: (result) {
        generateChartData(type, time, result);
      },
    );
  }

  Future<void> getStatsFrameData(MinerStatsType type, MinerStatsTime time,
      bool forward, DateTime endTime, String minerId) async {
    DateTime startTime;

    endTime = getEndTime(time, endTime, forward: forward);
    startTime = getStartTime(time, endTime);


    await getSourceFrameData(
      gatewayId: minerId,
      interval: 'DAY',
      startTimestamp: startTime,
      endTimestamp: endTime,
      startTime: startTime,
      endTime: endTime,
      successCB: (result) {
        generateChartData(type, time, result);
      },
    );
  }

  List<MinerStatsEntity> generateMinerEntities(
      DateTime startTime, DateTime endTime) {
    List<MinerStatsEntity> dates = [];
    int totalDays = endTime.difference(startTime).inDays;

    for (int i = 0; i <= totalDays; i++) {
      dates.add(MinerStatsEntity(
          date: startTime.add(Duration(days: i)),
          uptime: 0,
          revenue: 0,
          health: 0,
          received: 0,
          transmitted: 0));
    }

    return dates;
  }

  Future<void> getSourceMinerData({
    String gatewayMac,
    String orgId,
    DateTime fromDate,
    DateTime tillDate,
    DateTime startTime,
    DateTime endTime,
    Function successCB,
  }) async {
    List<MinerStatsEntity> entities = generateMinerEntities(startTime, endTime);

    try {
      emit(state.copyWith(showLoading: true));

      var result = await supernodeRepository.wallet.miningIncomeGateway(
        gatewayMac: gatewayMac,
        orgId: orgId,
        fromDate: fromDate,
        tillDate: tillDate,
      );

      if (successCB != null) {
        if (double.tryParse(result.total) > 0) {
          entities = entities.map((entity) {
            result.dailyStats.forEach((item) {
              var currentEntity = MinerStatsEntity(
                date: item.date,
                health: item.health,
                received: 0,
                transmitted: 0,
                revenue: double.tryParse(item.amount ?? '0'),
                uptime: double.tryParse(item.onlineSeconds ?? '0'),
              );

              if (currentEntity.date.year == entity.date.year &&
                  currentEntity.date.month == entity.date.month &&
                  currentEntity.date.day == entity.date.day) {
                entity = currentEntity;
                return;
              }
            });

            return entity;
          }).toList();
        }
        successCB(entities);
      }

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError(err.toString());
    }
  }

  Future<void> getSourceFrameData({
    DateTime startTime,
    DateTime endTime,
    Function successCB,
    String gatewayId,
    String interval,
    DateTime startTimestamp,
    DateTime endTimestamp,
  }) async {
    List<MinerStatsEntity> entities = generateMinerEntities(startTime, endTime);

    try {
      emit(state.copyWith(showLoading: true));

      var result = await supernodeRepository.gateways.frames(
        gatewayId,
        interval: interval,
        startTimestamp: startTimestamp,
        endTimestamp: endTimestamp,
      );

      if (successCB != null) {
        if (result.length > 0) {
          entities = entities.map((entity) {
            result.forEach((item) {
              var currentEntity = MinerStatsEntity(
                date: item.timestamp,
                health: 0,
                transmitted: item.txPacketsEmitted.toDouble(),
                received: item.rxPacketsReceivedOK.toDouble(),
                revenue: 0,
                uptime: 0,
              );

              if (currentEntity.date.year == entity.date.year &&
                  currentEntity.date.month == entity.date.month &&
                  currentEntity.date.day == entity.date.day) {
                entity = currentEntity;
                return;
              }
            });

            return entity;
          }).toList();
        }
        successCB(entities);
      }

      emit(state.copyWith(showLoading: false));
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError(err.toString());
    }
  }

  List<int> getYLabel(double maxValue) {
    List<int> yLabel = [];
    int step = 3;
    if (maxValue >= 6400) {
      step = 800;
    } else if (maxValue >= 1600) {
      step = 200;
    } else if (maxValue >= 800) {
      step = 40;
    } else if (maxValue >= 730) {
      step = 91;
    } else if (maxValue >= 240) {
      step = 30;
    } else if (maxValue >= 168) {
      step = 21;
    } else if (maxValue >= 24) {
      step = 3;
    }

    for (int y = step; y <= maxValue; y += step) {
      yLabel.add(y);
    }

    yLabel.sort((a, b) => b.compareTo(a));

    return yLabel;
  }

  void generateChartData(
      MinerStatsType type, MinerStatsTime time, List<MinerStatsEntity> data) {
    double maxValue = 0;
    List<double> xData = [];
    List<String> xLabel = [];
    List<String> yLabel = [];
    double totalScore = 0;
    List<MinerStatsEntity> newData = [];

    data.sort((a, b) => b.date.compareTo(a.date));

    if (time == MinerStatsTime.week) {
      maxValue = maxData(type, data);
      emit(state.copyWith(originList: data));

      data.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 24.0 * 3600;
          xData.add(item.uptime / maxValue);
          totalScore += item.uptime;
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        xLabel.add(TimeUtil.week[item.date.weekday]);
      });

      if (type == MinerStatsType.uptime) {
        double totalWeekScore = 24.0 * data.length;

        emit(state.copyWith(
            uptimeWeekScore: totalScore / totalWeekScore / 3600));
      }
    } else if (time == MinerStatsTime.month) {
      data.forEach((item) {
        // if (item.date.weekday != DateTime.sunday) {
        bool hasResult = newData.any((hasItem) =>
            hasItem.date.weekday != DateTime.sunday ||
            TimeUtil.isSameDay(hasItem.date,
                item.date.add(Duration(days: 7 - item.date.weekday))));

        if (hasResult) {
          for (int i = 0; i < newData.length; i++) {
            if (TimeUtil.isSameDay(newData[i].date,
                item.date.add(Duration(days: 7 - item.date.weekday)))) {
              if (type == MinerStatsType.uptime) {
                newData[i].uptime += item.uptime;
              } else if (type == MinerStatsType.revenue) {
                newData[i].revenue += item.revenue;
              } else if (type == MinerStatsType.frameReceived) {
                newData[i].received += item.received;
              } else {
                newData[i].transmitted += item.transmitted;
              }
            }
          }
        } else {
          newData.add(MinerStatsEntity(
              date: item.date.add(Duration(days: 7 - item.date.weekday)),
              uptime: item.uptime,
              revenue: item.revenue,
              health: item.health,
              received: item.received,
              transmitted: item.transmitted));
        }
      });

      maxValue = maxData(type, newData);
      newData.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 168.0 * 3600;
          xData.add(item.uptime / maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        xLabel.add(TimeUtil.getMDAbb(item.date));
      });

      emit(state.copyWith(originList: newData));
    } else {
      data.forEach((item) {
        bool hasResult = newData
            .any((hasItem) => TimeUtil.isSameMonth(hasItem.date, item.date));

        if (hasResult) {
          for (int i = 0; i < newData.length; i++) {
            if (TimeUtil.isSameMonth(newData[i].date, item.date)) {
              if (type == MinerStatsType.uptime) {
                newData[i].uptime += item.uptime;
              } else if (type == MinerStatsType.revenue) {
                newData[i].revenue += item.revenue;
              } else if (type == MinerStatsType.frameReceived) {
                newData[i].received += item.received;
              } else {
                newData[i].transmitted += item.transmitted;
              }
            }
          }
        } else {
          newData.add(MinerStatsEntity(
              date: item.date,
              uptime: item.uptime,
              revenue: item.revenue,
              health: item.health,
              received: item.received,
              transmitted: item.transmitted));
        }
      });

      maxValue = maxData(type, newData);
      newData.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 730.0 * 3600;
          xData.add(item.uptime / maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        xLabel.add('${item.date.month}');
      });

      emit(state.copyWith(originList: newData));
    }

    if (type == MinerStatsType.uptime) {
      maxValue = maxValue / 3600;
    }

    emit(state.copyWith(xDataList: xData));
    emit(state.copyWith(xLabelList: xLabel));
    emit(state.copyWith(yLabelList: getYLabel(maxValue)));
  }

  double maxData(MinerStatsType type, List<MinerStatsEntity> data) {
    double maxValue = 10;
    double tempValue = 0;

    if (data.isEmpty) {
      return maxValue;
    }

    for (int i = 0; i < data.length; i++) {
      for (int j = i + 1; j < data.length; j++) {
        if (type == MinerStatsType.uptime) {
          tempValue = data[i].uptime >= data[j].uptime
              ? data[i].uptime
              : data[j].uptime;
        } else if (type == MinerStatsType.revenue) {
          tempValue = data[i].revenue >= data[j].revenue
              ? data[i].revenue
              : data[j].revenue;
        } else if (type == MinerStatsType.frameReceived) {
          tempValue = data[i].received >= data[j].received
              ? data[i].received
              : data[j].received;
        } else {
          tempValue = data[i].transmitted >= data[j].transmitted
              ? data[i].transmitted
              : data[j].transmitted;
        }

        if (tempValue > maxValue) {
          maxValue = tempValue;
        }
      }
    }

    return maxValue;
  }
}
