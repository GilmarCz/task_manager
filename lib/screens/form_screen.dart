import 'package:flutter/material.dart';
//import 'package:task_manager/components/tasks.dart';
import 'package:task_manager/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if(value != null && value.isEmpty){
      return true;
    }
    return false;
  }

  bool difficultyValidator (String? value) {
    if(value!.isEmpty || int.parse(value) > 5 || int.parse(value) < 1) {
      return true;
      }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(05),
                  border: Border.all(width: 3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value){
                        if(valueValidator(value)){
                          return 'Insira o nome da Tarefa';
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value){
                        if(difficultyValidator(value)){
                          return 'Insira uma Dificuldade entre 1 e 5';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Dificuldade',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Insira uma URL de Imagem!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      onChanged: (Text) {
                        setState(() {});
                      },
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Imagem',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(180),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageController.text,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/nophoto.png');
                            },
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //print(nameController.text);
                        //print(int.parse(difficultyController.text));
                        //print(imageController.text);
                        TaskInherited.of(widget.taskContext).newTask(
                            nameController.text,
                            imageController.text,
                            int.parse(difficultyController.text),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Criando uma nova Tarefa!'),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const FormScreen(),
                        //   ),
                        // );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Adicionar!'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
