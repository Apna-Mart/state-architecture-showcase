// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillerCategory {

 String get id; String get name;
/// Create a copy of BillerCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillerCategoryCopyWith<BillerCategory> get copyWith => _$BillerCategoryCopyWithImpl<BillerCategory>(this as BillerCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillerCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'BillerCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $BillerCategoryCopyWith<$Res>  {
  factory $BillerCategoryCopyWith(BillerCategory value, $Res Function(BillerCategory) _then) = _$BillerCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$BillerCategoryCopyWithImpl<$Res>
    implements $BillerCategoryCopyWith<$Res> {
  _$BillerCategoryCopyWithImpl(this._self, this._then);

  final BillerCategory _self;
  final $Res Function(BillerCategory) _then;

/// Create a copy of BillerCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillerCategory].
extension BillerCategoryPatterns on BillerCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillerCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillerCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillerCategory value)  $default,){
final _that = this;
switch (_that) {
case _BillerCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillerCategory value)?  $default,){
final _that = this;
switch (_that) {
case _BillerCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillerCategory() when $default != null:
return $default(_that.id,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _BillerCategory():
return $default(_that.id,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _BillerCategory() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _BillerCategory implements BillerCategory {
  const _BillerCategory({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of BillerCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillerCategoryCopyWith<_BillerCategory> get copyWith => __$BillerCategoryCopyWithImpl<_BillerCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillerCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'BillerCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BillerCategoryCopyWith<$Res> implements $BillerCategoryCopyWith<$Res> {
  factory _$BillerCategoryCopyWith(_BillerCategory value, $Res Function(_BillerCategory) _then) = __$BillerCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$BillerCategoryCopyWithImpl<$Res>
    implements _$BillerCategoryCopyWith<$Res> {
  __$BillerCategoryCopyWithImpl(this._self, this._then);

  final _BillerCategory _self;
  final $Res Function(_BillerCategory) _then;

/// Create a copy of BillerCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_BillerCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BillerInputParam {

 String get key; String get label; String get hint;
/// Create a copy of BillerInputParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillerInputParamCopyWith<BillerInputParam> get copyWith => _$BillerInputParamCopyWithImpl<BillerInputParam>(this as BillerInputParam, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillerInputParam&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.hint, hint) || other.hint == hint));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,hint);

@override
String toString() {
  return 'BillerInputParam(key: $key, label: $label, hint: $hint)';
}


}

/// @nodoc
abstract mixin class $BillerInputParamCopyWith<$Res>  {
  factory $BillerInputParamCopyWith(BillerInputParam value, $Res Function(BillerInputParam) _then) = _$BillerInputParamCopyWithImpl;
@useResult
$Res call({
 String key, String label, String hint
});




}
/// @nodoc
class _$BillerInputParamCopyWithImpl<$Res>
    implements $BillerInputParamCopyWith<$Res> {
  _$BillerInputParamCopyWithImpl(this._self, this._then);

  final BillerInputParam _self;
  final $Res Function(BillerInputParam) _then;

/// Create a copy of BillerInputParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? hint = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillerInputParam].
extension BillerInputParamPatterns on BillerInputParam {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillerInputParam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillerInputParam() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillerInputParam value)  $default,){
final _that = this;
switch (_that) {
case _BillerInputParam():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillerInputParam value)?  $default,){
final _that = this;
switch (_that) {
case _BillerInputParam() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String hint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillerInputParam() when $default != null:
return $default(_that.key,_that.label,_that.hint);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String hint)  $default,) {final _that = this;
switch (_that) {
case _BillerInputParam():
return $default(_that.key,_that.label,_that.hint);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String hint)?  $default,) {final _that = this;
switch (_that) {
case _BillerInputParam() when $default != null:
return $default(_that.key,_that.label,_that.hint);case _:
  return null;

}
}

}

/// @nodoc


class _BillerInputParam implements BillerInputParam {
  const _BillerInputParam({required this.key, required this.label, required this.hint});
  

@override final  String key;
@override final  String label;
@override final  String hint;

/// Create a copy of BillerInputParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillerInputParamCopyWith<_BillerInputParam> get copyWith => __$BillerInputParamCopyWithImpl<_BillerInputParam>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillerInputParam&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.hint, hint) || other.hint == hint));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,hint);

@override
String toString() {
  return 'BillerInputParam(key: $key, label: $label, hint: $hint)';
}


}

/// @nodoc
abstract mixin class _$BillerInputParamCopyWith<$Res> implements $BillerInputParamCopyWith<$Res> {
  factory _$BillerInputParamCopyWith(_BillerInputParam value, $Res Function(_BillerInputParam) _then) = __$BillerInputParamCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String hint
});




}
/// @nodoc
class __$BillerInputParamCopyWithImpl<$Res>
    implements _$BillerInputParamCopyWith<$Res> {
  __$BillerInputParamCopyWithImpl(this._self, this._then);

  final _BillerInputParam _self;
  final $Res Function(_BillerInputParam) _then;

/// Create a copy of BillerInputParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? hint = null,}) {
  return _then(_BillerInputParam(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Biller {

 String get id; String get categoryId; String get name; BillerMode get mode; List<BillerInputParam> get inputParams;
/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillerCopyWith<Biller> get copyWith => _$BillerCopyWithImpl<Biller>(this as Biller, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Biller&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.inputParams, inputParams));
}


@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,mode,const DeepCollectionEquality().hash(inputParams));

@override
String toString() {
  return 'Biller(id: $id, categoryId: $categoryId, name: $name, mode: $mode, inputParams: $inputParams)';
}


}

/// @nodoc
abstract mixin class $BillerCopyWith<$Res>  {
  factory $BillerCopyWith(Biller value, $Res Function(Biller) _then) = _$BillerCopyWithImpl;
@useResult
$Res call({
 String id, String categoryId, String name, BillerMode mode, List<BillerInputParam> inputParams
});




}
/// @nodoc
class _$BillerCopyWithImpl<$Res>
    implements $BillerCopyWith<$Res> {
  _$BillerCopyWithImpl(this._self, this._then);

  final Biller _self;
  final $Res Function(Biller) _then;

/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? mode = null,Object? inputParams = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as BillerMode,inputParams: null == inputParams ? _self.inputParams : inputParams // ignore: cast_nullable_to_non_nullable
as List<BillerInputParam>,
  ));
}

}


/// Adds pattern-matching-related methods to [Biller].
extension BillerPatterns on Biller {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Biller value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Biller() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Biller value)  $default,){
final _that = this;
switch (_that) {
case _Biller():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Biller value)?  $default,){
final _that = this;
switch (_that) {
case _Biller() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String categoryId,  String name,  BillerMode mode,  List<BillerInputParam> inputParams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Biller() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.mode,_that.inputParams);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String categoryId,  String name,  BillerMode mode,  List<BillerInputParam> inputParams)  $default,) {final _that = this;
switch (_that) {
case _Biller():
return $default(_that.id,_that.categoryId,_that.name,_that.mode,_that.inputParams);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String categoryId,  String name,  BillerMode mode,  List<BillerInputParam> inputParams)?  $default,) {final _that = this;
switch (_that) {
case _Biller() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.mode,_that.inputParams);case _:
  return null;

}
}

}

/// @nodoc


class _Biller implements Biller {
  const _Biller({required this.id, required this.categoryId, required this.name, required this.mode, required final  List<BillerInputParam> inputParams}): _inputParams = inputParams;
  

@override final  String id;
@override final  String categoryId;
@override final  String name;
@override final  BillerMode mode;
 final  List<BillerInputParam> _inputParams;
@override List<BillerInputParam> get inputParams {
  if (_inputParams is EqualUnmodifiableListView) return _inputParams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inputParams);
}


/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillerCopyWith<_Biller> get copyWith => __$BillerCopyWithImpl<_Biller>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Biller&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._inputParams, _inputParams));
}


@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,mode,const DeepCollectionEquality().hash(_inputParams));

@override
String toString() {
  return 'Biller(id: $id, categoryId: $categoryId, name: $name, mode: $mode, inputParams: $inputParams)';
}


}

/// @nodoc
abstract mixin class _$BillerCopyWith<$Res> implements $BillerCopyWith<$Res> {
  factory _$BillerCopyWith(_Biller value, $Res Function(_Biller) _then) = __$BillerCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryId, String name, BillerMode mode, List<BillerInputParam> inputParams
});




}
/// @nodoc
class __$BillerCopyWithImpl<$Res>
    implements _$BillerCopyWith<$Res> {
  __$BillerCopyWithImpl(this._self, this._then);

  final _Biller _self;
  final $Res Function(_Biller) _then;

/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? mode = null,Object? inputParams = null,}) {
  return _then(_Biller(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as BillerMode,inputParams: null == inputParams ? _self._inputParams : inputParams // ignore: cast_nullable_to_non_nullable
as List<BillerInputParam>,
  ));
}


}

// dart format on
