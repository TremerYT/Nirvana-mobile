String nameFormatter(String name) {
  if (name.isEmpty) return name;
  return name[0].toLowerCase() + name.substring(1).toLowerCase();
}
