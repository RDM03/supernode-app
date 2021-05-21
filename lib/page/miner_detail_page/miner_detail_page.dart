import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/widgets/circular_graph.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class MinerDetailPage extends StatefulWidget {
  @override
  _MinerDetailPageState createState() => _MinerDetailPageState();
}

class _MinerDetailPageState extends State<MinerDetailPage> {
  int selectedTab = 0;

  Widget title(String text, {Widget action}) => SizedBox(
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: kBigFontOfBlack,
                ),
              ),
              if (action != null) action
            ],
          ),
        ),
      );

  Widget infoCard({
    @required Widget image,
    @required int value,
    @required String title,
    @required String description,
    @required String comment,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: image,
                ),
                Text(
                  '$value%',
                  style: kBigFontOfDarkBlue,
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title, style: kBigFontOfDarkBlue),
                  SizedBox(height: 4),
                  Text(description, style: kMiddleFontOfBlack),
                  SizedBox(height: 4),
                  Text(comment, style: kMiddleFontOfGrey),
                ],
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: PageNavBar(
                text: 'M2PRO_1',
                centerTitle: true,
                actionWidget: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                    groupValue: selectedTab,
                    onValueChanged: (tabIndex) =>
                        setState(() => selectedTab = tabIndex),
                    thumbColor: colorMxc,
                    children: <int, Widget>{
                      0: Text(
                        'Health',
                        style: TextStyle(
                          color:
                              (selectedTab == 0) ? Colors.white : Colors.grey,
                        ),
                      ),
                      1: Text(
                        'Revenue',
                        style: TextStyle(
                          color:
                              (selectedTab == 1) ? Colors.white : Colors.grey,
                        ),
                      ),
                      2: Text(
                        'Data',
                        style: TextStyle(
                          color:
                              (selectedTab == 1) ? Colors.white : Colors.grey,
                        ),
                      ),
                    }),
              ),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                GestureDetector(
                  child: Column(
                    children: [
                      Image.asset(AppImages.fuelCircle),
                      Text('Add'),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CircularGraph(
                      10,
                      fuelColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('10%', style: kSuperBigBoldFont),
                          Text(
                            FlutterI18n.translate(context, 'health_score'),
                            style: kMiddleFontOfGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Image.asset(AppImages.sendCircle),
                      Text('Send'),
                    ],
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.fuel,
                    color: healthColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '0 /1000 MXC',
                    style: kBigFontOfBlack,
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            StatisticTable(),
            title(
              'Uptime',
              action: InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    'See more',
                    style: kSmallFontOfDarkBlue,
                  ),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 8),
            title(
              'GPS (Outdoor/Indoor)',
              action: InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    'View map',
                    style: kSmallFontOfDarkBlue,
                  ),
                ),
                onTap: () {},
              ),
            ),
            infoCard(
              image: Image.asset(AppImages.gps),
              value: 100,
              title: 'We’ve got the signal',
              description: '52.231234546, 15.34546576',
              comment: 'Seems like you placed it in outdoor',
            ),
            SizedBox(height: 8),
            title('Altitude'),
            infoCard(
              image: Image.asset(AppImages.altitude),
              value: 100,
              title: 'I’m flying',
              description: '5 meters',
              comment: 'This is great!',
            ),
            SizedBox(height: 8),
            title('Proximity'),
            infoCard(
              image: Image.asset(AppImages.proximity),
              value: 100,
              title: 'I’m enjoying social distancing',
              description: '4 meters',
              comment: 'This is great!',
            ),
            SizedBox(height: 8),
            title('Orientation'),
            infoCard(
              image: Image.asset(AppImages.orientation),
              value: 100,
              title: 'Yes, queen',
              description: '0 degree',
              comment: 'The antenna is pointing correct way',
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class StatisticTable extends StatelessWidget {
  Widget _statisticItem(String title, int value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kSmallFontOfGrey,
            ),
            SizedBox(height: 8),
            Text(
              '$value%',
              style: kBigFontOfDarkBlue,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorMxc.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _statisticItem('Uptime', 50),
              _statisticItem('GPS', 100),
              _statisticItem('Altitude', 100),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _statisticItem('Proximity', 100),
              _statisticItem('Orientation', 100),
              _statisticItem('Fuel', 0),
            ],
          ),
        ],
      ),
    );
  }
}
