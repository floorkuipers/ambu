import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ambu/pages/interactive_videos/training.dart';

class tiles extends StatefulWidget {
  final String title;
  final bool small;
  final String category;
  final String imageName;
  final double score;
  final double progress;

  tiles(this.title, this.small, this.category, this.imageName, this.score, this.progress);

  @override
  State<tiles> createState() => _tilesState();
}

class _tilesState extends State<tiles> {
  // final String _title = 'title';
   final bool _small = true;

   // final String _category = 'category';
  // final String _imageName = 'imagename';
  // final int _score = 5;

  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final String _imgPath = widget.imageName;
    final int _score = widget.score.toInt();
    final double _progress = widget.progress;
    final int _progressInt = _progress.toInt();
    //final double? _ratingValue;
    return Card(
      margin: EdgeInsets.all(_width/100),
      child: Column(
        children: <Widget>[
          InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              if(widget.title != "Coniotomie") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              }
              else{
                //TODO redirect to learning page
                String category = widget.title;
                Navigator.push(
                  context,
                 // MaterialPageRoute(builder: (context) =>  video('Coniotomie')),
                  MaterialPageRoute(builder: (context) =>  training(category)),

                );
            };
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: widget.small ? 120:200,
              height: widget.small? 200:220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    //TODO set these dimensions to responsive
                    width: widget.small? 100:175,
                    height: widget.small? 90:100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset('images/$_imgPath.jpg',
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  ),
                  //TODO responsive
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0,0),
                    child: Text(
                      widget.category,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.subText,
                      ),
                      //textAlign: TextAlign.left,
                    ),
                  ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 5, 5, 0),
                    child: widget.small? SizedBox(height:0): new LinearPercentIndicator(
                      width: 125,
                      animation: true,
                      lineHeight: 7.0,
                      animationDuration: 2000,
                      percent: _progress/100,
                      trailing: Text("$_progressInt %"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      //backgroundColor: AppTheme.colors.white,
                      progressColor: AppTheme.colors.accentColor,
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 5, 5, 0),
                    child: widget.small? SizedBox(height:10): Row(
                      children: <Widget>[
                        StarDisplay(value: widget.score.toInt()),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('$_score /5'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class StarDisplay extends StatelessWidget {
  final int value;

  const StarDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: AppTheme.colors.accentColor,
        );
      }),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Niet beschikbaar'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Omdat de app nog in ontwikkeling is, zijn op dit moment alleen de Coniotomie oefeningen beschikbaar."),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        //background: AppTheme.colors.primaryColor,
        child: const Text('Sluiten'),
      ),
    ],
  );
}