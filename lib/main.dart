import 'package:flutter/material.dart';
import 'package:tictactoe/component/confetti.dart';
import 'package:tictactoe/component/logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TicScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicScreen extends StatefulWidget {
  const TicScreen({Key? key}) : super(key: key);

  @override
  _TicScreenState createState() => _TicScreenState();
}

class _TicScreenState extends State<TicScreen> {
  //variables

  String lastvalue = "X";
  bool gameover = false;
  int turn = 0;
  List<int> score = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  String result = "";

  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = List.generate(Game.length, (index) => Player.empty);
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's $lastvalue turn".toUpperCase(),
            style: const TextStyle(fontSize: 30.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),

          // now the actual game rectangle.
          Container(
            width: boardwidth,
            height: boardwidth,
            child: GridView.count(
              crossAxisCount: Game.length ~/ 3,
              padding: const EdgeInsets.all(14.0),
              mainAxisSpacing: 7,
              crossAxisSpacing: 7.0,
              children: List.generate(Game.length, (index) {
                return InkWell(
                  onTap: gameover
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastvalue;
                              turn++;
                              gameover =
                                  game.checkWinner(lastvalue, index, score, 3);
                              if (gameover) {
                                result = " The winner is $lastvalue";
                                const Homepage();
                              } else if (!gameover && turn == 9) {
                                result = "Draw";
                                gameover = true;
                              }
                              if (lastvalue == "X") {
                                lastvalue = "O";
                              } else {
                                lastvalue = "X";
                              }
                            });
                          }
                        },
                  child: Container(
                      width: Game.blocksize,
                      height: Game.blocksize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.black
                                : Colors.red[900],
                            fontSize: 60.0,
                          ),
                        ),
                      )),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            result,
            style: const TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board =
                      List.generate(Game.length, (index) => Player.empty);
                  lastvalue = "X";
                  gameover = false;
                  turn = 0;
                  result = "";
                  score = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: const Icon(
                Icons.replay,
                color: Colors.white,
              ),
              label: const Text(
                "Restart",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              )),
        ],
      ),
    );
  }
}
