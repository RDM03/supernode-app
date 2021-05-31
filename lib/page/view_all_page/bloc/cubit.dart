import 'package:bloc/bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/miner.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
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

  void tabTime(String time){
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

  void setSelectedType(MinerStatsType type){
    emit(state.copyWith(selectedType: type));
  }

  int getNumBar(){
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      return 7;
    } else if (time == MinerStatsTime.month) {
      return 5;
    } else {
      return 12;
    }
  }

  String getStatsTitle() {
    List titles = [];
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      titles = ['score_weekly_total', 'total_hours', 'total_hours'];
    }else if (type == MinerStatsType.revenue) {
      titles = ['weekly_amount', 'monthly_amount', 'yearly_amount'];
    }else {
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
      for (int i = 0; i < state.originList.length; i++){
        total += state.originList[i].uptime; 
      }
    } else if (type == MinerStatsType.revenue) {
      for (int i = 0; i < state.originList.length; i++){
        total += state.originList[i].revenue; 
      }
    } else if (type == MinerStatsType.frameReceived) {
      for (int i = 0; i < state.originList.length; i++){
        total += state.originList[i].received; 
      }
    } else {
      for (int i = 0; i < state.originList.length; i++){
        total += state.originList[i].transmitted; 
      }
    }

    return total;
  }

  String getStartTimeLabel(){
    MinerStatsTime time = state.selectedTime;

    if (state.originList.isEmpty) return null;

    if (time == MinerStatsTime.week) {
      return Tools.dateMonthDayFormat(state.originList.last.date);
    } else {
      return Tools.dateMonthDayYearFormat(state.originList.last.date);
    }
  }

  String getEndTimeLabel(){
    MinerStatsTime time = state.selectedTime;

    if (state.originList.isEmpty) return null;
    
    if (time == MinerStatsTime.week) {
      return Tools.dateMonthDayFormat(state.originList.first.date);
    } else {
      return Tools.dateMonthDayYearFormat(state.originList.first.date);
    }
  }


  Future<void> dispatchData({
        MinerStatsType type = MinerStatsType.uptime,
        MinerStatsTime time = MinerStatsTime.week, 
        DateTime startTime, 
        DateTime endTime, 
        String minerId
      }) async {

    switch(type){
      case MinerStatsType.uptime:
      case MinerStatsType.revenue:
        getStatsMinerData(type,time,startTime,endTime,minerId);
        break;
      case MinerStatsType.frameReceived:
      case MinerStatsType.frameTransmitted:
        getStatsFrameData(type,time,startTime,endTime,minerId);
        break;
      default:
        break;
    }
    
  }

  DateTime getStartTime(MinerStatsTime time, DateTime startTime) {
    if (time == MinerStatsTime.week){
      return startTime?.add(Duration(days: -8)) ?? DateTime.now().add(Duration(days: -8));
    } else if (time == MinerStatsTime.month) {
      return startTime?.add(Duration(days: -30)) ?? DateTime.now().add(Duration(days: -30));
    } else {
      return startTime?.add(Duration(days: -365)) ?? DateTime.now().add(Duration(days: -365));
    }
  }

  DateTime getEndTime(DateTime endTime) {
    return endTime ?? DateTime.now().add(Duration(days: -1));
  }

  Future<void> getStatsMinerData(
        MinerStatsType type, 
        MinerStatsTime time, 
        DateTime startTime,
        DateTime endTime,
        String minerId
    ) async {
      startTime = getStartTime(time, startTime);
      endTime = getEndTime(endTime);
    
      Map data = {
        'gatewayMac': minerId,
        'orgId': supernodeCubit.state.orgId,
        'fromDate': DateTime.utc(
                startTime.year, startTime.month, startTime.day)
            .toIso8601String(),
        'tillDate':
            DateTime.utc(endTime.year, endTime.month, endTime.day)
                .toIso8601String(),
      };

      getSourceMinerData(
        data, 
        startTime: startTime,
        endTime: endTime,
        successCB: (result){
          generateChartData(type, time, result);
        }
      );
  }

  Future<void> getStatsFrameData(
        MinerStatsType type, 
        MinerStatsTime time, 
        DateTime startTime,
        DateTime endTime,
        String minerId
    ) async {
      startTime = getStartTime(time, startTime);
      endTime = getEndTime(endTime);
    
      Map data = {
        'gatewayID': minerId,
        'interval': 'DAY',
        'startTimestamp': startTime.toIso8601String() + 'Z',
        'endTimestamp': endTime.toIso8601String() + 'Z'
      };

      getSourceFrameData(
        data, 
        startTime: startTime,
        endTime: endTime,
        successCB: (result){
          generateChartData(type, time, result);
        }
      );
  }

  List<MinerStatsEntity> generateMinerEntities(DateTime startTime, DateTime endTime){
    List<MinerStatsEntity> dates = [];
    int totalDays = endTime.difference(startTime).inDays;

    for (int i = 0; i <= totalDays; i++) {
      dates.add(MinerStatsEntity(
        date: startTime.add(Duration(days: i)),
        uptime: 0,
        revenue: 0,
        health: 0,
        received: 0,
        transmitted: 0
      ));
    }

    return dates;
  }

  Future<void> getSourceMinerData(Map data, {DateTime startTime, DateTime endTime, Function successCB}) async {
    List<MinerStatsEntity> entities = generateMinerEntities(startTime,endTime);

    try {
      emit(state.copyWith(showLoading: true));

      var result = await supernodeRepository.wallet.miningIncomeGateway(data);
    
      // var result = await DemoWalletDao().miningIncomeGateway(data);

      if (successCB != null) {
        if(int.tryParse(result['total']) > 0){
          entities = entities.map((entity) {

            result['dailyStats'].forEach((item){
              var currentEntity = MinerStatsEntity.fromMap(item);

              if (currentEntity.date.year == entity.date.year &&
                currentEntity.date.month == entity.date.month &&
                currentEntity.date.day == entity.date.day
              ){
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

  Future<void> getSourceFrameData(Map data, {DateTime startTime, DateTime endTime, Function successCB}) async {
    List<MinerStatsEntity> entities = generateMinerEntities(startTime,endTime);

    try {
      emit(state.copyWith(showLoading: true));

      var result = await supernodeRepository.gateways.frames(data['gatewayID'], data);
      // var result = await DemoGatewaysDao().frames(data['gatewayID'], data);
      
      if (successCB != null) {
        if(result['result'].length > 0){
          entities = entities.map((entity) {

            result['result'].forEach((item){
              var currentEntity = MinerStatsEntity.fromMap(item);

              if (currentEntity.date.year == entity.date.year &&
                currentEntity.date.month == entity.date.month &&
                currentEntity.date.day == entity.date.day
              ){
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

  List<double> getYLabel(double maxValue) {
    List<double> yLabel = []; 
    int step = 2;
    if(maxValue > 1200){
      step = 200;
    }else if(maxValue > 800){
      step = 40;
    }else if(maxValue > 400){
      step = 20;
    }else if(maxValue > 30){
      step = 5;
    }

    for(double y = 0; y <= maxValue; y += step){
      yLabel.add(y);
    }

    yLabel.sort((a,b) => b.compareTo(a));

    return yLabel;
  }

  void generateChartData(
      MinerStatsType type, 
      MinerStatsTime time, 
      List<MinerStatsEntity> data) {
    double maxValue = 0;
    List<double> xData = [];
    List<String> xLabel = [];
    List<String> yLabel = [];
    double totalScore = 0;
    List<MinerStatsEntity> newData = [];

    data.sort((a,b) => b.date.compareTo(a.date));

    if (time == MinerStatsTime.week) {
      maxValue = maxData(type,data);
      emit(state.copyWith(originList: data));

      data.forEach((item) { 
        if (type == MinerStatsType.uptime) {
          xData.add(item.uptime/maxValue);
          totalScore += item.uptime;
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue/maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received/maxValue);
        } else {
          xData.add(item.transmitted/maxValue);
        } 

        xLabel.add(Tools.dateMonthDayFormat(item.date));        
      });

      if (type == MinerStatsType.uptime) {
        double totalWeekScore = 24.0 * data.length;
        
        emit(state.copyWith(uptimeWeekScore: totalScore/totalWeekScore));
      }
    } else if (time == MinerStatsTime.month) {
      data.forEach((item){
        // if (item.date.weekday != DateTime.sunday) {
          bool hasResult = newData.any((hasItem) => hasItem.date.weekday != DateTime.sunday || Tools.isSameDay(hasItem.date,item.date.add(Duration(days: 7 - item.date.weekday))));

          if (hasResult) {
            for(int i = 0; i < newData.length; i++) {
              if (Tools.isSameDay(newData[i].date, item.date.add(Duration(days: 7 - item.date.weekday)))) {
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
              transmitted: item.transmitted
            ));
          }
      });

      maxValue = maxData(type,newData);
      newData.forEach((item) {
        if (type == MinerStatsType.uptime) {
          xData.add(item.uptime/maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue/maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received/maxValue);
        } else {
          xData.add(item.transmitted/maxValue);
        }

        xLabel.add(Tools.dateMonthDayFormat(item.date)); 
      });

      emit(state.copyWith(originList: newData));
    } else {
      data.forEach((item){
        bool hasResult = newData.any((hasItem) => Tools.isSameMonth(hasItem.date, item.date));

        if (hasResult) {
          for(int i = 0; i < newData.length; i++) {
            if (Tools.isSameMonth(newData[i].date, item.date)) {
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
            transmitted: item.transmitted
          ));
        }
      });

      maxValue = maxData(type,newData);
      newData.forEach((item) {
        if (type == MinerStatsType.uptime) {
          xData.add(item.uptime/maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue/maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received/maxValue);
        } else {
          xData.add(item.transmitted/maxValue);
        }

        xLabel.add(Tools.dateMonthDayFormat(item.date)); 
      });

      emit(state.copyWith(originList: newData));
    }

    emit(state.copyWith(xDataList: xData));
    emit(state.copyWith(xLabelList: xLabel));
    emit(state.copyWith(yLabelList: getYLabel(maxValue)));
   
  }

  double maxData(MinerStatsType type, List<MinerStatsEntity> data) {
    double maxValue = 10;
    double tempValue = 0;

    if(data.isEmpty) {
      return maxValue;
    }
     
    for(int i = 0; i < data.length; i++){
      for(int j = i + 1; j < data.length; j++){
        if(type == MinerStatsType.uptime){
          tempValue = data[i].uptime >= data[j].uptime ? data[i].uptime : data[j].uptime;
        } else if (type == MinerStatsType.revenue) {
          tempValue = data[i].revenue >= data[j].revenue ? data[i].revenue : data[j].revenue;
        } else if (type == MinerStatsType.frameReceived) {
          tempValue = data[i].received >= data[j].received ? data[i].received : data[j].received;
        } else {
          tempValue = data[i].transmitted >= data[j].transmitted ? data[i].transmitted : data[j].transmitted;
        }

        if(tempValue > maxValue) {
          maxValue = tempValue;
        }
      }
    }

    return maxValue;
  }

}
