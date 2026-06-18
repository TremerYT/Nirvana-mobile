String nameFormatter(String name) {
  final trimmedName = name.trim();
  if (trimmedName.isEmpty) return name;
  return trimmedName[0].toUpperCase() + trimmedName.substring(1).toLowerCase();
}

String greeting(String name) {
  final hour = DateTime.now().hour;
  final formattedName = nameFormatter(name);

  if (hour >= 5 && hour < 12) {
    return 'Good morning,\n$formattedName';
  } else if (hour >= 12 && hour < 17) {
    return 'Good afternoon,\n$formattedName';
  } else {
    return 'Good evening,\n$formattedName';
  }
}
