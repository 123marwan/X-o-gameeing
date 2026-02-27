import 'package:flutter/material.dart';

import '../playermodel.dart';
import 'itemxo.dart';

class Xogame extends StatefulWidget {
  static const String routename = 'xo';
  const Xogame({super.key});

  @override
  State<Xogame> createState() => _XogameState();
}

class _XogameState extends State<Xogame> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;
  String winner = '';

  int xScore = 0;
  int oScore = 0;

  // ================= GAME LOGIC =================

  void onItemClicked(int index) {
    if (board[index].isNotEmpty || winner.isNotEmpty) return;

    setState(() {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var w in wins) {
      if (board[w[0]].isNotEmpty &&
          board[w[0]] == board[w[1]] &&
          board[w[1]] == board[w[2]]) {
        winner = board[w[0]];
        if (winner == 'X') {
          xScore++;
        } else {
          oScore++;
        }
        return;
      }
    }

    if (!board.contains('')) {
      winner = 'Draw';
    }
  }

  // ================= RESET FUNCTIONS =================

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      winner = '';
      isXTurn = true;
    });
  }

  void resetScore() {
    setState(() {
      xScore = 0;
      oScore = 0;
      board = List.filled(9, '');
      winner = '';
      isXTurn = true;
    });
  }

  void showResetScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Score'),
        content: const Text('Are you sure you want to reset the score?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              resetScore();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget buildItem(int index) {
    return Itemxo(
      value: board[index],
      onTap: () => onItemClicked(index),
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    Playermodel model =
    ModalRoute.of(context)!.settings.arguments as Playermodel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('XO Game'),
      ),
      body: Column(
        children: [
          // ===== SCORE BOARD =====
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        model.Player1name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$xScore',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        model.Player2name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$oScore',
                        style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== GAME BOARD =====
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildItem(0),
                      buildItem(1),
                      buildItem(2),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildItem(3),
                      buildItem(4),
                      buildItem(5),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildItem(6),
                      buildItem(7),
                      buildItem(8),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== GAME STATUS =====
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              winner.isEmpty
                  ? 'Turn: ${isXTurn ? model.Player1name : model.Player2name}'
                  : winner == 'Draw'
                  ? 'Draw!'
                  : 'Winner: ${winner == 'X' ? model.Player1name : model.Player2name}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // ===
          // == BUTTONS =====
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom:90),
                  child: ElevatedButton(
                    onPressed: resetGame,
                    child: const Text('Restart Round'),
                  ),
                ),
              ),
              SizedBox(width: 10,),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom:90),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: showResetScoreDialog,
                    child: const Text('Reset Score',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),


        ],
      ),
    );
  }
}