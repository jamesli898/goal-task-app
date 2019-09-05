import 'package:flutter/material.dart';
import './new_quote.dart';

class MotivationalQuote extends StatelessWidget {
  final Function updateQuote;
  final String quote;
  MotivationalQuote(this.updateQuote, this.quote);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      //add the function here to bring up the modal bottom sheet
                      return showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return (GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: NewQuote(updateQuote),
                            ));
                          });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          quote,
                          style: TextStyle(
                            fontFamily: 'Saira',
                            color: Colors.green,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
