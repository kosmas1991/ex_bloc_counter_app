import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

class MySecondPage extends StatefulWidget {
  MySecondPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
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
                    Navigator.of(context).pop();
                  },
                  child: Text('Go Back')),
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
