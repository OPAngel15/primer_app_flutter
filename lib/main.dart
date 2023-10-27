import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 204, 65, 55)),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier{
  var current = WordPair.random();
  var favoritos = <WordPair>[];

  void getSiguiente(){
    current = WordPair.random();
    notifyListeners();
  }
void toggleFavoritos(){
  if (favoritos.contains(current)){
    favoritos.remove(current);   
}else{
  favoritos.add(current);
}
notifyListeners();

}
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    var idea= appState.current;
    IconData icon;
    if (appState.favoritos.contains(idea)){
      icon = Icons.favorite;
    }else{
      icon = Icons.favorite_outline;
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Bigcard(idea: (appState.current)),
          SizedBox(height: 10,),
          Row(
            mainAxisSize:MainAxisSize.min ,
            children: [
              ElevatedButton.icon(
                onPressed: (){appState.toggleFavoritos();},
                icon: Icon(icon),
                label: Text("Me gusta")),
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: (){
                  appState.getSiguiente();
                }, 
                child: Text("Siguiente")),
            ],
          )
          ],
        ),
      ),
    );
  }
}

class Bigcard extends StatelessWidget{
  final WordPair idea;

  const Bigcard({
    super.key,
    required this.idea
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final textStyle = tema.textTheme.displayMedium!.copyWith(
      color: tema.colorScheme.onPrimary,
    );
    
    return Card(
      color: tema.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          idea.asLowerCase, 
          style: textStyle,
          semanticsLabel: "${idea.first} ${idea.second}",
          ),

      ),
    );
  }
}


