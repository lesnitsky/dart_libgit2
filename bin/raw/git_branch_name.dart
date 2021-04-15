import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:libgit2_bindings/libgit2_bindings.dart' as b;

void main(List<String> args) {
  final path = '${Directory.current.path}/libgit2.dylib';
  final pwd = Directory.current.path;

  final _g = new b.LibGit2(DynamicLibrary.open(path));

  _g.git_libgit2_init();

  final repo = malloc.allocate(0).cast<Pointer<b.git_repository>>();

  final r0 = _g.git_repository_open(repo, pwd.toNativeUtf8().cast<Int8>());
  assert(r0 == 0);

  final ref = malloc.allocate(0).cast<Pointer<b.git_reference>>();

  final r1 = _g.git_repository_head(ref, repo.value);
  assert(r1 == 0);

  final out = malloc.allocate(0).cast<Pointer<Int8>>();
  final r2 = _g.git_branch_name(out, ref.value);
  assert(r2 == 0);

  print(out.value.cast<Utf8>().toDartString());

  _g.git_libgit2_shutdown();
}
