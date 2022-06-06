import 'package:cleanarchitecureflutter/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injector.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: BlocProvider(
          create: (context) {
            return ic<NumberTriviaBloc>();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                      builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(message: 'Start Searching!');
                    } else if (state is Error) {
                      return MessageDisplay(message: state.message);
                    } else if (state is Loading) {
                      return const LoadingWidget();
                    } else if (state is Loaded) {
                      return TriviaDisplay(numberTrivia: state.trivia);
                    }
                    return Container();
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  TriviaControls()
                ],
              ),
            ),
          ),
        ));
  }
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputStr = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: ((value) {
            setState(() {
              inputStr = value;
            });
          }),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      dispatchConcrete();
                    },
                    child: const Text('search'))),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  dispatchRandom();
                },
                child: const Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}
