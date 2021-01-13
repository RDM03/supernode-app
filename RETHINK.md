### Rules.

1. Always format code using `flutter format`
2. Use Effective Dart style - https://dart.dev/guides/language/effective-dart/style
* PREFER using lowerCamelCase for constant names. (constant_identifier_names)
* DO capitalize acronyms and abbreviations longer than two letters like words. (e.g. *Dao* and not *DAO*)
3. Prefer to do **not** use functional widgets - https://github.com/flutter/flutter/issues/19269 (but if it's local widget that will only be used once in code and you just want to make build method look less complex - it's ok)
4. Avoid to use `dynamic` and maps when it's not necessary - prefer objects instead of maps. 
5. Prefer to use BlocBuilder `buildWhen` param to increase performance.
6. Do **not** put TextEditingController and similar to state if not necessary, prefer to use stateful widgets 
7. Do **not** use List.add, List.remove or List.replace on structures that designed to be immutable.  
<sup>Because these methods mutate the list, it can lead to unexpected behavior:
```
(equality method can be taken from freezed or equatable or data class generator)

final aaa = SomeObj(a: 0);
final bbb = aaa.copyWith(a: 1);
assert(aaa != bbb); // OK
---------
final aaa = SomeObj(list: [1, 2, 3]);
final bbb = aaa.copyWith(list: aaa.list..add(4));
assert(aaa != bbb); // FAILS, because aaa.list and bbb.list refers to the same object. 

// Althrough aaa and bbb reference different objects, very often (always in freezed or built_value) data classes have 
// own implementation of equality operator to compare objects by inner fields and not by reference.
```
</sup>  
Instead use `[...list, newEntity]` and `list.where((t) => t != entityToRemove).toList()`



### Rethink steps

1. Remove fish_redux, it's outdated - https://github.com/alibaba/fish-redux. Replace it with Bloc.
2. Replace all states with states written using Freezed to increase readability, remove boilerplate and decrease potential errors number in future. 
3. Rewrite DAOs using types and not maps.
4. Check and remove unnecessary dependencies.
5. Setup dart analyzer and fix problems

### Other changes:
* loading map changed with Wrap<T> class, please check user state.

Comments related to RETHINK are marked with RETHINK. prefix (e.g. RETHINK.TODO).