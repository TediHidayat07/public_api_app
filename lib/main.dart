import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nf_tugas_public_api/providers/api_provider.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Public API',
        theme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.amber,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<ApiProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      'Memuat User...',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              );
            } else if (provider.state == ResultState.hasData) {
              User user = provider.user;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(provider.user.avatar),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(user.phoneNumber),
                  const SizedBox(height: 4),
                  Text(DateFormat("dd, MMMM y").format(user.dateOfBirth)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<ApiProvider>(context, listen: false)
                          .fetchUser();
                    },
                    child: const Text('Get New User'),
                  )
                ],
              );
            } else {
              return const Text('Get Error');
            }
          },
        ),
      ),
    );
  }
}
