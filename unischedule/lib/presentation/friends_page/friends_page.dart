import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../providers/friends_page/friends_provider.dart'; // Asegúrate de que la ruta de importación sea correcta

void main() {
  runApp(ProviderScope(child: MaterialApp(home: const FriendsApp())));
}

class FriendsApp extends ConsumerStatefulWidget {
  const FriendsApp({Key? key}) : super(key: key);

  @override
  _FriendsAppState createState() => _FriendsAppState();
}

class _FriendsAppState extends ConsumerState<FriendsApp> {
  final TextEditingController _searchController =
      TextEditingController(); // Controlador para la barra de búsqueda
  final String userId =
      "0MebgXs8fBYREjDKMlwq"; // ID de usuario para la demostración

  @override
  Widget build(BuildContext context) {
    final friendsAsyncValue = ref.watch(friendsProvider(userId));

    final double itemWidth =
        MediaQuery.of(context).size.width - 60; // Margen de 30px a cada lado

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/bars.svg',
              width: 21, height: 24, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Friends',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/icons/bell.svg',
                width: 21, height: 24, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          friendsAsyncValue.when(
            data: (friends) {
              return ListView.builder(
                itemCount: friends.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Barra de búsqueda
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF686868)),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF686868)),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SvgPicture.asset(
                                  'assets/icons/magnifying-glass.svg',
                                  width: 24,
                                  height: 24,
                                  color: Color(0xFF686868)),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    );
                  } else {
                    final friend = friends[index - 1];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(
                          30, 8, 30, 6), // 8px de separación entre las cajas
                      height: 55, // Altura de la caja a 55px
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(
                              30), // Lado izquierdo totalmente redondeado
                          right: Radius.circular(
                              16), // Lado derecho ligeramente redondeado
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                2.0), // Padding ajustado para mantener el círculo del avatar dentro de la altura de 55px
                            child: CircleAvatar(
                              radius:
                                  26.5, // El radio se ajusta para que el diámetro sea de 53px
                              backgroundImage:
                                  NetworkImage(friend.profilePicture),
                            ),
                          ),
                          SizedBox(
                              width:
                                  16), // Añade espaciado horizontal entre la imagen y el nombre
                          Expanded(
                            child: Text(
                              friend.name,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/icons/comment.svg',
                              width: 24,
                              height: 24,
                              color: Color(0xFF9FA5C0),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
          Positioned(
            right: 16, // Ajusta estos valores según tus necesidades
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF9DCC18), // Color de fondo verde
                  shape: BoxShape
                      .circle, // Forma circular para que coincida con el FAB
                ),
                padding: EdgeInsets.all(
                    0), // Espacio alrededor del icono para reducir el tamaño del fondo verde
                child: SvgPicture.asset(
                  'assets/icons/square-plus.svg',
                  width: 50, // Ancho del icono reducido
                  height: 56, // Altura del icono reducida
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                side: BorderSide(
                  color: Color(0xFF9DCC18), // Color del borde
                  width: 3.8, // Ancho del borde
                ),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
