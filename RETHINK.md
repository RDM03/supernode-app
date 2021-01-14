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
* No Global Actions. Everything that is global are placed in app_state, every action in app_cubit.
* No monster called 'SettingsState'. It was a state for settings page. And static global state that can be accesed from everywhere. It contained info about user, info about app theme (hey, we have only one theme in app), some parts of the state was stored in SQLite database (yes, we have sqlite database with only one table with only one row - for this state), some part (mostly the same fields, backup? :D ) was stored in shared preferences. 
* DAOs changes - no static instances, no sql db (??), no singletons
  * Remove Isolate Dao (from my personal experience json decoding in isolates leads to bugs very often)
  * Remove Settings Dao 
* No email suggest feature on login screen, but we will have multiuser soon.

We store user password in shared pref

Comments related to RETHINK are marked with RETHINK. prefix (e.g. RETHINK.TODO).

{
      await PermissionUtil.getLocationPermission();

----------------------------------------------------

## How to Navigate with Bloc?

https://bloclibrary.dev/#/recipesflutternavigation

But!

> For the sake of this example we are adding an event just for navigation. In a real application, you should not create explicit navigation events. If there is no "business logic" necessary in order to trigger navigation you should always directly navigate in response to user input (in the onPressed callback, etc...). Only navigate in response to state changes if some "business logic" is required in order to determine where to navigate.