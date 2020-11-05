import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/models/CardItemModel.dart';

import '../menu.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {
  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0),
    Color.fromRGBO(140, 158, 255, 1.0)
  ];
  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  var icons = [Icons.search, Icons.code, Icons.work];

  List<CardItemModel> cardsList = List<CardItemModel>();

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
  var averageScore = 0.0;

  @override
  void initState() {
    super.initState();
    averageScore = 0.0;
    for (var record in data.period.records) {
      cardsList.add(CardItemModel(
          data.period.stages[record.idetapa - 1].name,
          icons[record.idetapa - 1],
          record.nota,
          data.period.stages[record.idetapa - 1].percent.toDouble() / 100));
      averageScore += (record.nota *
          (data.period.stages[record.idetapa - 1].percent.toDouble() / 100));
      print(averageScore);
    }
    cardsList.add(CardItemModel(
        'Promedio', Icons.star, averageScore.roundToDouble(), 1.0));
  }

  @override
  Widget build(BuildContext context) {
    scrollController = new ScrollController();

    return new Scaffold(
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text(
          "Notas Etapas",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: currentColor,
        centerTitle: true,
        actions: <Widget>[],
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            new Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 350.0,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cardsList.length,
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Container(
                                    width: 250.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                cardsList[position].icon,
                                                color: appColors[position],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "${cardsList[position].tasksRemaining}",
                                                      style: TextStyle(
                                                        color:
                                                            Colors.orange[400],
                                                        fontSize: 74.0,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Nota",
                                                      style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 24.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 4.0,
                                                ),
                                                child: Text(
                                                  "${cardsList[position].cardTitle}",
                                                  style:
                                                      TextStyle(fontSize: 28.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          'Porcentaje: ',
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          (cardsList[position]
                                                                          .taskCompletion *
                                                                      100)
                                                                  .toString() +
                                                              ' %',
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                              onHorizontalDragEnd: (details) {
                                animationController = AnimationController(
                                    vsync: this,
                                    duration: Duration(milliseconds: 200));
                                curvedAnimation = CurvedAnimation(
                                    parent: animationController,
                                    curve: Curves.fastOutSlowIn);
                                animationController.addListener(() {
                                  setState(() {
                                    currentColor =
                                        colorTween.evaluate(curvedAnimation);
                                  });
                                });

                                if (details.velocity.pixelsPerSecond.dx > 0) {
                                  if (cardIndex > 0) {
                                    cardIndex--;
                                    colorTween = ColorTween(
                                        begin: currentColor,
                                        end: appColors[cardIndex]);
                                  }
                                } else {
                                  if (cardIndex < 3) {
                                    cardIndex++;
                                    colorTween = ColorTween(
                                        begin: currentColor,
                                        end: appColors[cardIndex]);
                                  }
                                }
                                setState(() {
                                  scrollController.animateTo(
                                      (cardIndex) * 256.0,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.fastOutSlowIn);
                                });

                                colorTween.animate(curvedAnimation);

                                animationController.forward();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: new ApgMenu(),
    );
  }
}
