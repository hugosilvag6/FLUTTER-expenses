import 'dart:math';
import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas despesas"),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions, removeTransaction: _deleteTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((e) => e.date.isAfter(DateTime.now().subtract(
              const Duration(days: 7),
            )))
        .toList();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransactions);
        });
  }

  void _addTransactions(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((e) => e.id == id);
    });
  }
}


// main() => runApp(ExpensesApp());
 
// class ExpensesApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData tema = ThemeData();
 
//     return MaterialApp(
//       home: MyHomePage(),
//       theme: tema.copyWith(
//         colorScheme: tema.colorScheme.copyWith(
//           primary: Colors.purple,
//           secondary: Colors.amber,
//         ),
//         textTheme: tema.textTheme.copyWith(
//           headline6: TextStyle(
//             fontFamily: 'OpenSans',
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         appBarTheme: AppBarTheme(
//           titleTextStyle: TextStyle(
//             fontFamily: 'OpenSans',
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
 
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
 
// class _MyHomePageState extends State<MyHomePage> {
//   final _transactions = [
//     Transaction(
//       id: 't1',
//       title: 'Novo Tênis de Corrida',
//       value: 310.76,
//       date: DateTime.now(),
//     ),
//     Transaction(
//       id: 't2',
//       title: 'Conta de Luz',
//       value: 211.30,
//       date: DateTime.now(),
//     ),
//   ];
 
//   _addTransaction(String title, double value) {
//     final newTransaction = Transaction(
//       id: Random().nextDouble().toString(),
//       title: title,
//       value: value,
//       date: DateTime.now(),
//     );
 
//     setState(() {
//       _transactions.add(newTransaction);
//     });
 
//     Navigator.of(context).pop();
//   }
 
//   _openTransactionFormModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return TransactionForm(onSubmit: _addTransaction);
//       },
//     );
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Despesas Pessoais'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => _openTransactionFormModal(context),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             const SizedBox(
//               width: double.infinity,
//               child: Card(
//                 color: Colors.blue,
//                 elevation: 5,
//                 child: Text('Gráfico'),
//               ),
//             ),
//             TransactionList(transactions: _transactions),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => _openTransactionFormModal(context),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }