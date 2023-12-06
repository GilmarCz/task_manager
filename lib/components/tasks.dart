import 'package:flutter/material.dart';
import 'package:task_manager/components/dificulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  const Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);
  @override
  State<Task> createState() => _TaskState();
}
class _TaskState extends State<Task> {

  final Map<int, Color> masteryColors = {
    1: Colors.lightBlueAccent,
    2: Colors.green,
    3: Colors.yellow,
    4: Colors.orange,
    5: Colors.red,
  };

  int nivel = 0;

  @override
  Widget build(BuildContext context) {
    bool reachedMaxMastery = nivel >= widget.dificuldade;
    bool reachedMinLevelForColorChange = nivel >= 10;

    Color taskColor = reachedMaxMastery
        ? (reachedMinLevelForColorChange
        ? masteryColors[widget.dificuldade] ?? Colors.grey
        : Colors.blue)
        : Colors.blue;

    Color textColor = reachedMaxMastery && reachedMinLevelForColorChange
        ? masteryColors[widget.dificuldade] != null
        ? ThemeData.estimateBrightnessForColor(
        masteryColors[widget.dificuldade]!) ==
        Brightness.light
        ? Colors.black
        : Colors.white
        : Colors.white
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: taskColor,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 80,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          widget.foto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(widget.dificuldade),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 82,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nivel++;
                          });
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_drop_up),
                            Text(
                              'Lvl Up',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0 &&
                            nivel <= widget.dificuldade)
                            ? (nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                    Text(
                      'Nível: $nivel',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}