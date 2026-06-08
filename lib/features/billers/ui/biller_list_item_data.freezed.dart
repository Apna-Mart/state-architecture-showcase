// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biller_list_item_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillerListItemData {

 String get id; String get name; String get categoryName;
/// Create a copy of BillerListItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillerListItemDataCopyWith<BillerListItemData> get copyWith => _$BillerListItemDataCopyWithImpl<BillerListItemData>(this as BillerListItemData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillerListItemData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName);

@override
String toString() {
  return 'BillerListItemData(id: $id, name: $name, categoryName: $categoryName)';
}


}

/// @nodoc
abstract mixin class $BillerListItemDataCopyWith<$Res>  {
  factory $BillerListItemDataCopyWith(BillerListItemData value, $Res Function(BillerListItemData) _then) = _$BillerListItemDataCopyWithImpl;
@useResult
$Res call({
 String id, String name, String categoryName
});




}
/// @nodoc
class _$BillerListItemDataCopyWithImpl<$Res>
    implements $BillerListItemDataCopyWith<$Res> {
  _$BillerListItemDataCopyWithImpl(this._self, this._then);

  final BillerListItemData _self;
  final $Res Function(BillerListItemData) _then;

/// Create a copy of BillerListItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillerListItemData].
extension BillerListItemDataPatterns on BillerListItemData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillerListItemData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillerListItemData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillerListItemData value)  $default,){
final _that = this;
switch (_that) {
case _BillerListItemData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillerListItemData value)?  $default,){
final _that = this;
switch (_that) {
case _BillerListItemData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String categoryName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillerListItemData() when $default != null:
return $default(_that.id,_that.name,_that.categoryName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String categoryName)  $default,) {final _that = this;
switch (_that) {
case _BillerListItemData():
return $default(_that.id,_that.name,_that.categoryName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String categoryName)?  $default,) {final _that = this;
switch (_that) {
case _BillerListItemData() when $default != null:
return $default(_that.id,_that.name,_that.categoryName);case _:
  return null;

}
}

}

/// @nodoc


class _BillerListItemData implements BillerListItemData {
  const _BillerListItemData({required this.id, required this.name, required this.categoryName});
  

@override final  String id;
@override final  String name;
@override final  String categoryName;

/// Create a copy of BillerListItemData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillerListItemDataCopyWith<_BillerListItemData> get copyWith => __$BillerListItemDataCopyWithImpl<_BillerListItemData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillerListItemData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName);

@override
String toString() {
  return 'BillerListItemData(id: $id, name: $name, categoryName: $categoryName)';
}


}

/// @nodoc
abstract mixin class _$BillerListItemDataCopyWith<$Res> implements $BillerListItemDataCopyWith<$Res> {
  factory _$BillerListItemDataCopyWith(_BillerListItemData value, $Res Function(_BillerListItemData) _then) = __$BillerListItemDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String categoryName
});




}
/// @nodoc
class __$BillerListItemDataCopyWithImpl<$Res>
    implements _$BillerListItemDataCopyWith<$Res> {
  __$BillerListItemDataCopyWithImpl(this._self, this._then);

  final _BillerListItemData _self;
  final $Res Function(_BillerListItemData) _then;

/// Create a copy of BillerListItemData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryName = null,}) {
  return _then(_BillerListItemData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
