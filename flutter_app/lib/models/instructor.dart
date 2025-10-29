class Instructor {
  final String name;
  final String title;
  final String phone;
  final String email;
  final String? photo; // asset yolu (opsiyonel)  e.g. 'assets/instructors/ahmet_arslan.jpg'

  const Instructor({
    required this.name,
    required this.title,
    required this.phone,
    required this.email,
    this.photo,
  });
}
