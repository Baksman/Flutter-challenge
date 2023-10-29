import 'dart:io';

String breed(String name) =>
    File('test/response/$name').readAsStringSync();
