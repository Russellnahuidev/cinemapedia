import 'package:flutter/material.dart';

class FullScerenLoader extends StatelessWidget {
  const FullScerenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas...',
      'Comprando palomitas de maíz',
      'Estamos preparando algo especial para ti.',
      'Cargando pulares.',
      'Un momento, estamos cargando los datos.',
      'Casi listo, gracias por tu paciencia.',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (count) {
      return messages[count];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2.5),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Cargando...');
              }
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
