import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [
    Question('Qual framework é usado para desenvolvimento de aplicações móveis com Flutter?', ['React Native', 'Ionic', 'Flutter SDK', 'Xamarin'], 2),
    Question('Qual é a linguagem de programação principal usada no Flutter?', ['Dart', 'JavaScript', 'Java', 'Python'], 0),
    Question('O que é Flutter?', ['Um sistema operacional', 'Um banco de dados', 'Uma linguagem de programação', 'Um SDK para desenvolvimento de apps'], 3),
    Question('Quais são os principais conceitos do Flutter?', ['Widgets e Layouts', 'Classes e Objetos', 'HTML e CSS', 'Comandos e Scripts'], 0),
    Question('Qual widget é usado para exibir uma lista rolável de elementos no Flutter?', ['Container', 'Stack', 'GridView', 'ListView'], 3),
    Question('Qual método é usado para construir a interface do usuário no Flutter?', ['build()', 'render()', 'create()', 'design()'], 0),
    Question('O que é JavaScript?', ['Um framework para desenvolvimento web', 'Uma linguagem de programação para o lado do cliente', 'Uma linguagem de marcação', 'Uma biblioteca de estilos'], 1),
    Question('Quais são as principais características do JavaScript?', ['Digitar e compilar', 'Orientação a objetos e herança', 'Manipulação de banco de dados', 'Interatividade e dinamismo'], 3),
    Question('Qual é a função do DOM no JavaScript?', ['Armazenar dados no servidor', 'Controlar a aparência visual dos elementos HTML', 'Criar layouts responsivos', 'Manipular a estrutura e o conteúdo de uma página web'], 3),
    Question('Qual é a biblioteca JavaScript mais popular para desenvolvimento de interfaces de usuário?', ['React', 'Angular', 'Vue', 'jQuery'], 0),
    // Adicione mais perguntas aqui
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://tse1.mm.bing.net/th?id=OIP.eERohPxiWcVEZYFD7wHZ5QHaHa&pid=Api&P=0&h=180'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pergunta ${currentQuestionIndex + 1}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Text(
              questions[currentQuestionIndex].questionText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            if (!isAnswered) ...buildAnswerButtons(),
            if (isAnswered) ...buildResult(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildAnswerButtons() {
    List<Widget> answerButtons = [];

    for (int i = 0; i < questions[currentQuestionIndex].options.length; i++) {
      answerButtons.add(
        ElevatedButton(
          onPressed: () => checkAnswer(i),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            questions[currentQuestionIndex].options[i],
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      );
      answerButtons.add(SizedBox(height: 8.0));
    }

    return answerButtons;
  }

  List<Widget> buildResult() {
    List<Widget> result = [
      Text(
        'Resposta correta!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () => nextQuestion(),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: Text('Próxima pergunta'),
      ),
    ];

    if (currentQuestionIndex == questions.length - 1) {
      result.addAll([
        SizedBox(height: 16.0),
        Text(
          'Pontuação final: $score',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () => restartGame(),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text('Recomeçar'),
        ),
      ]);
    }

    return result;
  }

  void checkAnswer(int selectedAnswerIndex) {
    setState(() {
      if (selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }
      isAnswered = true;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        isAnswered = false;
      } else {
      }
    });
  }
  
  void restartGame() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      isAnswered = false;
    });
  }
}

class Question {
  String questionText;
  List<String> options;
  int correctAnswerIndex;

  Question(this.questionText, this.options, this.correctAnswerIndex);
}
