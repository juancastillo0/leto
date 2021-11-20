import 'package:leto_generator_example/star_wars/test/all_test.dart'
    as star_wars_test;
import 'package:leto_generator_example/star_wars_relay/test/all_test.dart'
    as star_wars_relay_test;
import 'package:leto_generator_example/test/arguments_test.dart'
    as arguments_test;
import 'package:leto_generator_example/test/class_config_test.dart'
    as class_config_test;
import 'package:leto_generator_example/test/exec_all_test.dart'
    as exec_all_test;
import 'package:leto_generator_example/test/generics_test.dart'
    as generics_test;
import 'package:leto_generator_example/test/input_test.dart' as input_test;
import 'package:leto_generator_example/test/interface_test.dart'
    as interface_test;
import 'package:leto_generator_example/test/schema_test.dart' as schema_test;
import 'package:leto_generator_example/test/tasks_test.dart' as tasks_test;
import 'package:leto_generator_example/test/union_test.dart' as union_test;

void main() {
  input_test.main();
  interface_test.main();
  union_test.main();
  schema_test.main();
  tasks_test.main();
  generics_test.main();
  exec_all_test.main();
  arguments_test.main();
  class_config_test.main();

  star_wars_test.main();
  star_wars_relay_test.main();
}
