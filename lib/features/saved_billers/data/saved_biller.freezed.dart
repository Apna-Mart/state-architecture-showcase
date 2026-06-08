// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_biller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedBiller {

 String get billerId; String get account; String get nickname;
/// Create a copy of SavedBiller
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedBillerCopyWith<SavedBiller> get copyWith => _$SavedBillerCopyWithImpl<SavedBiller>(this as SavedBiller, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedBiller&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,nickname);

@override
String toString() {
  return 'SavedBiller(billerId: $billerId, account: $account, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $SavedBillerCopyWith<$Res>  {
  factory $SavedBillerCopyWith(SavedBiller value, $Res Function(SavedBiller) _then) = _$SavedBillerCopyWithImpl;
@useResult
$Res call({
 String billerId, String account, String nickname
});




}
/// @nodoc
class _$SavedBillerCopyWithImpl<$Res>
    implements $SavedBillerCopyWith<$Res> {
  _$SavedBillerCopyWithImpl(this._self, this._then);

  final SavedBiller _self;
  final $Res Function(SavedBiller) _then;

/// Create a copy of SavedBiller
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billerId = null,Object? account = null,Object? nickname = null,}) {
  return _then(_self.copyWith(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedBiller].
extension SavedBillerPatterns on SavedBiller {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedBiller value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedBiller() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedBiller value)  $default,){
final _that = this;
switch (_that) {
case _SavedBiller():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedBiller value)?  $default,){
final _that = this;
switch (_that) {
case _SavedBiller() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billerId,  String account,  String nickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedBiller() when $default != null:
return $default(_that.billerId,_that.account,_that.nickname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billerId,  String account,  String nickname)  $default,) {final _that = this;
switch (_that) {
case _SavedBiller():
return $default(_that.billerId,_that.account,_that.nickname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billerId,  String account,  String nickname)?  $default,) {final _that = this;
switch (_that) {
case _SavedBiller() when $default != null:
return $default(_that.billerId,_that.account,_that.nickname);case _:
  return null;

}
}

}

/// @nodoc


class _SavedBiller implements SavedBiller {
  const _SavedBiller({required this.billerId, required this.account, required this.nickname});
  

@override final  String billerId;
@override final  String account;
@override final  String nickname;

/// Create a copy of SavedBiller
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedBillerCopyWith<_SavedBiller> get copyWith => __$SavedBillerCopyWithImpl<_SavedBiller>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedBiller&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,nickname);

@override
String toString() {
  return 'SavedBiller(billerId: $billerId, account: $account, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class _$SavedBillerCopyWith<$Res> implements $SavedBillerCopyWith<$Res> {
  factory _$SavedBillerCopyWith(_SavedBiller value, $Res Function(_SavedBiller) _then) = __$SavedBillerCopyWithImpl;
@override @useResult
$Res call({
 String billerId, String account, String nickname
});




}
/// @nodoc
class __$SavedBillerCopyWithImpl<$Res>
    implements _$SavedBillerCopyWith<$Res> {
  __$SavedBillerCopyWithImpl(this._self, this._then);

  final _SavedBiller _self;
  final $Res Function(_SavedBiller) _then;

/// Create a copy of SavedBiller
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billerId = null,Object? account = null,Object? nickname = null,}) {
  return _then(_SavedBiller(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SavedBillers {

 List<SavedBiller> get items;
/// Create a copy of SavedBillers
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedBillersCopyWith<SavedBillers> get copyWith => _$SavedBillersCopyWithImpl<SavedBillers>(this as SavedBillers, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedBillers&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SavedBillers(items: $items)';
}


}

/// @nodoc
abstract mixin class $SavedBillersCopyWith<$Res>  {
  factory $SavedBillersCopyWith(SavedBillers value, $Res Function(SavedBillers) _then) = _$SavedBillersCopyWithImpl;
@useResult
$Res call({
 List<SavedBiller> items
});




}
/// @nodoc
class _$SavedBillersCopyWithImpl<$Res>
    implements $SavedBillersCopyWith<$Res> {
  _$SavedBillersCopyWithImpl(this._self, this._then);

  final SavedBillers _self;
  final $Res Function(SavedBillers) _then;

/// Create a copy of SavedBillers
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SavedBiller>,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedBillers].
extension SavedBillersPatterns on SavedBillers {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedBillers value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedBillers() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedBillers value)  $default,){
final _that = this;
switch (_that) {
case _SavedBillers():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedBillers value)?  $default,){
final _that = this;
switch (_that) {
case _SavedBillers() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SavedBiller> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedBillers() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SavedBiller> items)  $default,) {final _that = this;
switch (_that) {
case _SavedBillers():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SavedBiller> items)?  $default,) {final _that = this;
switch (_that) {
case _SavedBillers() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _SavedBillers extends SavedBillers {
  const _SavedBillers({required final  List<SavedBiller> items}): _items = items,super._();
  

 final  List<SavedBiller> _items;
@override List<SavedBiller> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SavedBillers
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedBillersCopyWith<_SavedBillers> get copyWith => __$SavedBillersCopyWithImpl<_SavedBillers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedBillers&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SavedBillers(items: $items)';
}


}

/// @nodoc
abstract mixin class _$SavedBillersCopyWith<$Res> implements $SavedBillersCopyWith<$Res> {
  factory _$SavedBillersCopyWith(_SavedBillers value, $Res Function(_SavedBillers) _then) = __$SavedBillersCopyWithImpl;
@override @useResult
$Res call({
 List<SavedBiller> items
});




}
/// @nodoc
class __$SavedBillersCopyWithImpl<$Res>
    implements _$SavedBillersCopyWith<$Res> {
  __$SavedBillersCopyWithImpl(this._self, this._then);

  final _SavedBillers _self;
  final $Res Function(_SavedBillers) _then;

/// Create a copy of SavedBillers
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_SavedBillers(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SavedBiller>,
  ));
}


}

// dart format on
