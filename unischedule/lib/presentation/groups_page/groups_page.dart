import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:go_router/go_router.dart';
import '../../../providers/groups_page/groups_provider.dart'; // Asegúrate de que este sea el proveedor correcto
import '../../../models/groups_page/group_model.dart'; // Importa el modelo de grupo

class GroupsPage extends ConsumerStatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends ConsumerState<GroupsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Observa el proveedor de grupos con el ID del usuario especificado
    final groupsAsyncValue = ref.watch(groupsProvider('0MebgXs8fBYREjDKMlwq'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/bars.svg',
            width: 21,
            height: 24,
            color: Colors.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('Groups', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Column(
        children: [
          // Barra de búsqueda, si es necesaria
          Expanded(
            child: groupsAsyncValue.when(
              data: (groups) => ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final Group group = groups[index];
                  final colorMasOscuro = Color(int.parse(group.color.replaceAll('#', '0xff')));
                  Color bgColor = colorMasOscuro
                      .withRed(max(0, colorMasOscuro.red - 30))
                      .withGreen(max(0, colorMasOscuro.green - 30))
                      .withBlue(max(0, colorMasOscuro.blue - 30));

                  return Container(
                    width: double.infinity,
                    height: 133,
                    margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              group.name.length > 15
                                  ? '${group.name.substring(0, 15)}...'
                                  : group.name,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CustomPaint(
                            size: const Size(100, 100),
                            painter: MyCustomPainter(colorMasOscuro),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Column(
                            children: const [
                              CircleAvatar(radius: 5, backgroundColor: Colors.white),
                              SizedBox(height: 3),
                              CircleAvatar(radius: 5, backgroundColor: Colors.white),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 12,
                          child: ProfileIconsRow(memberCount: group.members.length),
                        ),
                      ],
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileIconsRow extends StatelessWidget {
  final int memberCount;

  const ProfileIconsRow({required this.memberCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Hacer que el contenedor ocupe todo el ancho disponible
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Image.asset(
                  'assets/images/profile_pics/user_${Random().nextInt(11) + 1}.png'),
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Image.asset(
                    'assets/images/profile_pics/user_${Random().nextInt(11) + 1}.png'),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Image.asset(
                    'assets/images/profile_pics/user_${Random().nextInt(11) + 1}.png'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6, 8, 16, 8),
            alignment: Alignment.centerRight,
            child: Text(
              '+${memberCount - 3}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Color color;

  MyCustomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.25, size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.8, size.width * 0.7, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.85, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
