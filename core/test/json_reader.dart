import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;

  // Adjust the directory path if it ends with 'test' or 'core/test'
  if (dir.endsWith('test') || dir.endsWith('core/test')) {
    return File(name).readAsStringSync();
  } else if (dir.contains('core')) {
    return File('core/test/$name').readAsStringSync();
  } else {
    return File('core/test/$name').readAsStringSync();
  }
}
