import 'package:flutter/material.dart';
import 'image_viewer_page.dart' as viewer;

// ---- Küçük bir model ile tip güvenli liste
class Room {
  final String name;
  final int capacity;
  final String img;
  const Room({required this.name, required this.capacity, required this.img});
}

class InfrastructurePage extends StatelessWidget {
  const InfrastructurePage({super.key});

  @override
  Widget build(BuildContext context) {
    const classrooms = <Room>[
      Room(name: 'Derslik-B1', capacity: 36, img: 'assets/classrooms/B01.png'),
      Room(name: 'Derslik-B2', capacity: 15, img: 'assets/classrooms/B02.png'),
      Room(name: 'Derslik-B3', capacity: 18, img: 'assets/classrooms/B03.png'),
      Room(name: 'Derslik-B4', capacity: 24, img: 'assets/classrooms/B04.png'),
      Room(name: 'Derslik-B5', capacity: 15, img: 'assets/classrooms/B05.png'),
      Room(name: 'Derslik-B6', capacity: 18, img: 'assets/classrooms/B06.png'),
      Room(name: 'Derslik-B7', capacity: 54, img: 'assets/classrooms/B07.png'),
      Room(name: 'Laboratuvar', capacity: 30, img: 'assets/classrooms/lab.png'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Altyapı')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: classrooms.length,
        itemBuilder: (ctx, i) {
          final room = classrooms[i];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                viewer.ImageViewerPage.routeName,
                arguments: room.img,
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: room.img,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          room.img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    room.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kapasite: ${room.capacity}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
