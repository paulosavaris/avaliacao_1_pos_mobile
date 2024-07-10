import 'package:flutter/material.dart';

// Widget principal do aplicativo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Basic User'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Texto explicativo sobre a funcionalidade do autocomplete
              Text(
                  'Digite abaixo para autocompletar os seguintes resultados possíveis: ${AutocompleteBasicUserExample._userOptions}.'),
              // Widget de exemplo do autocomplete
              const AutocompleteBasicUserExample(),
            ],
          ),
        ),
      ),
    );
  }
}

// Classe imutável representando um usuário
@immutable
class User {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);
}

// Widget de exemplo do autocomplete
class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({super.key});

  // Lista de opções de usuários para o autocomplete
  static const List<User> _userOptions = <User>[
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Dave', email: 'dave@example.com'),
    User(name: 'Eve', email: 'eve@example.com'),
    User(name: 'Frank', email: 'frank@example.com'),
    User(name: 'Grace', email: 'grace@example.com'),
    User(name: 'Heidi', email: 'heidi@example.com'),
    User(name: 'Ivan', email: 'ivan@example.com'),
    User(name: 'Judy', email: 'judy@example.com'),
  ];

  // Método para exibir o nome do usuário como string
  static String _displayStringForOption(User option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<User>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        // Se o texto estiver vazio, não mostra opções
        if (textEditingValue.text == '') {
          return const Iterable<User>.empty();
        }
        // Filtra as opções de acordo com o texto digitado
        return _userOptions.where((User option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (User selection) {
        // Imprime no console o usuário selecionado
        debugPrint(
            'Você acabou de selecionar ${_displayStringForOption(selection)}');
      },
    );
  }
}