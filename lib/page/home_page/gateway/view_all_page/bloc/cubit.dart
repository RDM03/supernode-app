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
    this.weekLabels,
    this.monthsAbbLabels,
    this.monthsLabels,
    this.dayLocalized,
  ) : super(MinerStatsState());

  final AppCubit appCubit;
  final SupernodeCubit supernodeCubit;
  final SupernodeRepository supernodeRepository;
  final Map<int, String> weekLabels;
  final Map<int, String> monthsAbbLabels;
  final Map<int, String> monthsLabels;
  final String dayLocalized;

  String getMD(DateTime date) {
    return '${monthsLabels[date.month]} ${date.day}';
  }

  String getMDY(DateTime date) {
    return '${monthsLabels[date.month]} ${date.day} ${date.year}';
  }

  void setTabTimePeriod(String time) {
    MinerStatsTimePeriod selectedTimePeriod = MinerStatsTimePeriod.week;

    if (time == 'week') {
      selectedTimePeriod = MinerStatsTimePeriod.week;
    } else if (time == 'month') {
      selectedTimePeriod = MinerStatsTimePeriod.month;
    } else {
      selectedTimePeriod = MinerStatsTimePeriod.year;
    }

    emit(state.copyWith(
        selectedTimePeriod: selectedTimePeriod,
        showLoading: true,
        currentIndex: -1,
        xDataList: [],
        originMonthlyList: [],
        originYearlyList: []));

    generateChartData();
    emit(state.copyWith(showLoading: false));
  }

  void setSelectedType(MinerStatsType type) {
    emit(state.copyWith(selectedType: type));
  }

  void setChartStats(int index) {
    if (index != state.currentIndex) {
      emit(state.copyWith(
          currentIndex: index,
          upperLabel: '${getParsedUpperLabel(
              index + getNumBar())} - ${getParsedUpperLabel(index)}',
          statsLabel: getStatsSubtitle(index)));
    }
  }

  String getParsedUpperLabel(int index) {
    MinerStatsTimePeriod time = state.selectedTimePeriod;
    List<MinerStatsEntity> newData = getDataByTimePeriod();

    if (index < 0 || index >= newData.length) return '';

    if (newData.isEmpty) return '';

    if (time == MinerStatsTimePeriod.week) {
      return getMD(newData[index].date);
    } else if (time == MinerStatsTimePeriod.month) {
      return getMD(newData[index].date);
    } else {
      return getMDY(newData[index].date);
    }
  }

  int getNumBar() {
    MinerStatsTimePeriod time = state.selectedTimePeriod;

    if (time == MinerStatsTimePeriod.week) {
      return 7;
    } else if (time == MinerStatsTimePeriod.month) {
      return 5;
    } else {
      return 12;
    }
  }

  String getTooltip(MinerStatsEntity item) {
    String label = '';
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      label = '${Tools.priceFormat(item.uptime / 3600)} h';
    } else if (type == MinerStatsType.revenue) {
      label = '${Tools.priceFormat(item.revenue)} MXC';
    } else if (type == MinerStatsType.frameReceived) {
      label = '${Tools.priceFormat(item.received)}';
    } else if (type == MinerStatsType.frameTransmitted) {
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

    return titles[state.selectedTimePeriod?.index ?? 0];
  }

  String getStatsSubtitle(int index) {
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      return '${getUptimeWeekScore(index)} h';
    } else if (type == MinerStatsType.revenue) {
      return '${countTotal(index).toStringAsFixed(0)} MXC $dayLocalized';
    } else if (type == MinerStatsType.frameReceived) {
      return '${countTotal(index).toStringAsFixed(0)}';
    } else {
      return '${countTotal(index).toStringAsFixed(0)}';
    }
  }

  String getUptimeWeekScore(int index) {
    MinerStatsTimePeriod time = state.selectedTimePeriod;

    if (time == MinerStatsTimePeriod.week) {
      if (state.originList.isEmpty) return '0';

      List<MinerStatsEntity> newData = getDataByTimePeriod().sublist(index, index + getNumBar());

      DateTime today = DateTime.now();
      double totalWeekScore = 24.0 * 3600 * newData.length;

      MinerStatsEntity hasTodayItem;

      if (newData.any((item) => TimeUtil.isSameDay(item.date, today))) {
        hasTodayItem =
            newData.firstWhere((item) => TimeUtil.isSameDay(item.date, today));
      }

      if (hasTodayItem != null) {
        totalWeekScore =
            24.0 * 3600 * (newData.length - 1) + (hasTodayItem.uptime);
      }

      double totalScore = newData.fold(
              0, (previousValue, item) => previousValue + item.uptime) /
          totalWeekScore *
          100;

      return '(${totalScore.toStringAsFixed(0)}%) ${countTotal(index).toStringAsFixed(0)}';
    }

    return '${countTotal(index).toStringAsFixed(0)}';
  }

  double countTotal(int index) {
    double total = 0;
    MinerStatsType type = state.selectedType;

    List<MinerStatsEntity> newData = getDataByTimePeriod().sublist(index, index + getNumBar());

    if (type == MinerStatsType.uptime) {
      total = newData.fold(
              0, (previousValue, item) => previousValue + item.uptime) /
          3600;
    } else if (type == MinerStatsType.revenue) {
      total = newData.fold(
          0, (previousValue, item) => previousValue + item.revenue);
    } else if (type == MinerStatsType.frameReceived) {
      total = newData.fold(
          0, (previousValue, item) => previousValue + item.received);
    } else {
      total = newData.fold(
          0, (previousValue, item) => previousValue + item.transmitted);
    }

    return total;
  }

  Future<void> dispatchData(
      {MinerStatsType type = MinerStatsType.uptime,
      MinerStatsTimePeriod timePeriod = MinerStatsTimePeriod.week,
      DateTime startTime,
      String minerId}) async {
    switch (type) {
      case MinerStatsType.uptime:
      case MinerStatsType.revenue:
        getStatsMinerData(type, timePeriod, startTime, minerId);
        break;
      case MinerStatsType.frameReceived:
      case MinerStatsType.frameTransmitted:
        getStatsFrameData(type, timePeriod, minerId);
        break;
      default:
        break;
    }
  }

  Future<void> getStatsMinerData(MinerStatsType type, MinerStatsTimePeriod timePeriod,
      DateTime startTime, String minerId) async {
    List<MinerStatsEntity> listRawStats = await getSourceMinerData(
      gatewayMac: minerId,
      orgId: supernodeCubit.state.orgId);
    listRawStats = appendAndSortOriginList(state.originList, listRawStats);
    emit(state.copyWith(
        selectedType: type,
        selectedTimePeriod: timePeriod,
        originList: listRawStats));

    generateChartData();
  }

  Future<void> getStatsFrameData(
      MinerStatsType type,
      MinerStatsTimePeriod timePeriod,
      String minerId) async {
    List<MinerStatsEntity> listRawStats = await getSourceFrameData(gatewayId: minerId);
    listRawStats = appendAndSortOriginList(state.originList, listRawStats);
    emit(state.copyWith(
        selectedType: type,
        selectedTimePeriod: timePeriod,
        originList: listRawStats));

    generateChartData();
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

  Future<List<MinerStatsEntity>> getSourceMinerData({
    String gatewayMac,
    String orgId,
  }) async {
    try {
      final DateTime now = DateTime.now().toUtc();
      final DateTime today = DateTime.utc(now.year, now.month, now.day);
      final DateTime before3years = DateTime.utc(now.year - 3, now.month, now.day);

      List<MinerStatsEntity> entities = generateMinerEntities(before3years, today);

      var result = await supernodeRepository.wallet.miningIncomeGateway(
        gatewayMac: gatewayMac,
        orgId: orgId,
        fromDate: before3years,
        tillDate: today,
      );

      if (double.tryParse(result.total) > 0) {
        entities = entities.map((entity) {
          result.dailyStats.forEach((item) {
            var currentEntity = MinerStatsEntity(
              date: item.date,
              health: item.health,
              received: 0,
              transmitted: 0,
              revenue: double.tryParse(item.amount ?? '0'),
              uptime: item.onlineSeconds.toDouble(),
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
      return entities;
    } catch (err) {
      appCubit.setError(err.toString());
    }
  }

  Future<List<MinerStatsEntity>> getSourceFrameData({String gatewayId}) async {
    final DateTime now = DateTime.now().toUtc();
    final DateTime today = DateTime.utc(now.year, now.month, now.day);
    final DateTime before3years = DateTime.utc(now.year - 3, now.month, now.day);
    List<MinerStatsEntity> entities = generateMinerEntities(before3years, today);

    try {
      var result = await supernodeRepository.gateways.frames(
        gatewayId,
        interval: 'DAY',
        startTimestamp: before3years,
        endTimestamp: today,
      );

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
        return entities;
      }
    } catch (err) {
      appCubit.setError(err.toString());
    }
  }

  int getYAxisStep(double maxValue) {
    int step = 3;

    if (maxValue >= 20000) {
      step = 2000;
    } else if (maxValue >= 6400) {
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
    } else if (maxValue >= 100) {
      step = 10;
    } else if (maxValue >= 24) {
      step = 3;
    }

    return step;
  }

  List<int> getYLabel(double maxValue) {
    List<int> yLabel = [];
    int step = 3;

    if(state.selectedType == MinerStatsType.uptime){
      step = getYAxisStep(maxValue);
    }else{
      step = (maxValue / 10).floor();
    }

    for (int y = step; y <= maxValue; y += step) {
      yLabel.add(y);
    }

    yLabel.sort((a, b) => b.compareTo(a));

    return yLabel;
  }

  List<MinerStatsEntity> getDataByTimePeriod() {
    MinerStatsTimePeriod timePeriod = state.selectedTimePeriod;
    if (timePeriod == MinerStatsTimePeriod.week) {
      return state.originList;
    } else if (timePeriod == MinerStatsTimePeriod.month) {
      return state.originMonthlyList;
    } else {
      return state.originYearlyList;
    }
  }

  List<MinerStatsEntity> appendAndSortOriginList(
      List<MinerStatsEntity> orginalList, List<MinerStatsEntity> data) {
    orginalList.forEach((item) {
      if (!data.any((element) => TimeUtil.isSameDay(element.date, item.date))) {
        data.add(item);
      }
    });

    data.sort((a, b) => b.date.compareTo(a.date));
    return data;
  }

  void generateChartData() {
    final MinerStatsType type = state.selectedType;
    final MinerStatsTimePeriod timePeriod = state.selectedTimePeriod;
    final List<MinerStatsEntity> data = state.originList;
    double maxValue = 0;
    List<double> xData = [];
    List<String> xLabel = [];
    List<MinerStatsEntity> newData = [];

    if (timePeriod == MinerStatsTimePeriod.week) {
      maxValue = maxData(type, state.originList);

      data.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 24.0 * 3600;
          xData.add(item.uptime / maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        if (TimeUtil.isSameDay(item.date, DateTime.now())) {
          xLabel.add('today');
        } else {
          xLabel.add(weekLabels[item.date.weekday]);
        }
      });
    } else if (timePeriod == MinerStatsTimePeriod.month) {
      data.forEach((item) {
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

      emit(state.copyWith(
          originMonthlyList:
              appendAndSortOriginList(state.originMonthlyList, newData)));
      maxValue = maxData(type, state.originMonthlyList);

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

        xLabel.add('${monthsAbbLabels[item.date.month]} ${item.date.day}');
      });
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

      emit(state.copyWith(
          originYearlyList:
              appendAndSortOriginList(state.originYearlyList, newData)));
      maxValue = maxData(type, state.originYearlyList);

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

        xLabel.add(TimeUtil.getM(item.date));
      });
    }

    if (type == MinerStatsType.uptime) {
      maxValue = maxValue / 3600;
    }

    emit(state.copyWith(
        xDataList: xData,
        xLabelList: xLabel,
        yLabelList: getYLabel(maxValue)));

    setChartStats(0);//TODO Check
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

    maxValue += (10 - (maxValue % 10));

    return maxValue;
  }
}
