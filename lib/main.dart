import 'package:ex_bloc_counter_app/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'secondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        routes: {
          '/': (context) => BlocProvider<CounterCubit>.value(
                value: _counterCubit,
                child: MyHomePage(
                  title: 'Flutter Demo Home Page',
                ),
              ),
          '/second': (context) => BlocProvider<CounterCubit>.value(
                value: _counterCubit,
                child: MySecondPage(
                  title: 'My second Page',
                ),
              )
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented) {
            SnackBar mySnackBar = SnackBar(
              content: Text('Increment'),
              duration: Duration(milliseconds: 400),
            );
            ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
          } else {
            SnackBar mySnackBar = SnackBar(
              content: Text('Decrement'),
              duration: Duration(milliseconds: 400),
            );
            ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: Text('Go to Second')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                      color: Colors.redAccent,
                      icon: Icon(Icons.exposure_minus_1),
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).decrement();
                        //context.read<CounterCubit>().decrement();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                      color: Colors.greenAccent,
                      icon: Icon(Icons.plus_one),
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).increment();
                      },
                    ),
                  )

                ],
              )

            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
