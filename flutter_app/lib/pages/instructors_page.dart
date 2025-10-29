import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/instructor.dart';

class InstructorsPage extends StatelessWidget {
  const InstructorsPage({super.key});

    static final _instructors = <Instructor>[
    Instructor(
      name: 'Doç.Dr. Ahmet ARSLAN',
      title: 'Doç.Dr.',
      phone: '+90 (222) 213 81 05',
      email: 'ahmeta@ogr.eskisehir.edu.tr',
      photo: 'assets/instructors/ahmet_hoca.png',
    ),
    Instructor(
      name: 'Doç.Dr. Mehmet KOÇ',
      title: 'Doç. Dr.',
      phone: '+90 (222) 213 81 06',
      email: 'mehmetkoc@eskisehir.edu.tr',
      photo: 'assets/instructors/mehmet_hoca.png',
    ),
    Instructor(
      name: 'Prof.Dr. Serkan GÜNAL',
      title: 'Prof.Dr.',
      phone: '+90 (222) 213 81 27',
      email: 'serkangunal@eskisehir.edu.tr',
      photo: 'assets/instructors/serkan_hoca.png',
    ),
    Instructor(
      name: 'Prof.Dr. Cihan KALELİ',
      title: 'Prof.Dr.',
      phone: '+90 (222) 213 81 04',
      email: 'ckaleli@eskisehir.edu.tr',
      photo: 'assets/instructors/cihan_hoca.png',
    ),
    Instructor(
      name: 'Doç.Dr. Sevcan YILMAZ GÜNDÜZ',
      title: 'Doç.Dr.',
      phone: '+90 (222) 213 81 07',
      email: 'sevcany@eskisehir.edu.tr',
      photo: 'assets/instructors/sevcan_hoca.png',
    ),
    Instructor(
      name: 'Dr.öğr.üyesi Burcu YILMAZEL',
      title: 'Dr.öğr.üyesi',
      phone: '+90 (222) 213 81 08',
      email: 'byurekli@eskisehir.edu.tr',
      photo: 'assets/instructors/burcu_hoca.png',
    ),
  ];


  Future<void> _confirmAndCall(BuildContext context, Instructor i) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ara?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(i.name),
            Text(i.title),
            const SizedBox(height: 8),
            Text('Tel: ${i.phone}'),
            Text('E-posta: ${i.email}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hayır')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Evet')),
        ],
      ),
    );

    if (ok == true) {
      final uri = Uri(scheme: 'tel', path: i.phone);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cihaz arama desteklemiyor.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _instructors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, idx) {
        final i = _instructors[idx];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: (i.photo != null && i.photo!.isNotEmpty)
                  ? AssetImage(i.photo!)
                  : null,
              child: (i.photo == null || i.photo!.isEmpty)
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(i.name),                                 // ← eklendi
            subtitle: Text('${i.title}\n${i.email}'),            // ← eklendi
            isThreeLine: true,                                   // ← eklendi (2 satır alt başlık için)
            trailing: FilledButton.icon(                         // (opsiyonel) arama butonu
            onPressed: () => _confirmAndCall(context, i),
            icon: const Icon(Icons.call),
            label: const Text('Ara'),
            ),
          ),
        );
      },
    );
  }
}
