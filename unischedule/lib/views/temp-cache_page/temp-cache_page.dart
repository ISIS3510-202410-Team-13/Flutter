import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unischedule/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';  // Asegúrate de importar go_router si lo estás usando

class TempCachePage extends ConsumerStatefulWidget {
  const TempCachePage({Key? key}) : super(key: key);

  @override
  _TempCachePageState createState() => _TempCachePageState();
}

class _TempCachePageState extends ConsumerState<TempCachePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Storage List"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');  // Asegúrate de que el path sea correcto según tu configuración de rutas
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildList<Friend>('friendBox', 'Friends Local Storage')),
          Expanded(child: _buildList<GroupModel>('groupBox', 'Groups Local Storage')),
          Expanded(child: _buildList<Event>('eventBox', 'Events Local Storage')),
        ],
      ),
    );
  }

  Widget _buildList<T>(String boxName, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: FutureBuilder<Box<T>>(
            future: Hive.openBox<T>(boxName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  return Text("Error opening the $boxName");
                } else {
                  return ValueListenableBuilder(
                    valueListenable: snapshot.data!.listenable(),
                    builder: (context, Box<T> box, _) {
                      var items = box.values.toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var item = items[index] as dynamic;  // Cast as dynamic to access 'name'
                          return ListTile(
                            title: Text(item.name),
                          );
                        },
                      );
                    },
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
