// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biller_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillerCatalog {

 List<BillerCategory> get categories; List<Biller> get billers;
/// Create a copy of BillerCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillerCatalogCopyWith<BillerCatalog> get copyWith => _$BillerCatalogCopyWithImpl<BillerCatalog>(this as BillerCatalog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillerCatalog&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.billers, billers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(billers));

@override
String toString() {
  return 'BillerCatalog(categories: $categories, billers: $billers)';
}


}

/// @nodoc
abstract mixin class $BillerCatalogCopyWith<$Res>  {
  factory $BillerCatalogCopyWith(BillerCatalog value, $Res Function(BillerCatalog) _then) = _$BillerCatalogCopyWithImpl;
@useResult
$Res call({
 List<BillerCategory> categories, List<Biller> billers
});




}
/// @nodoc
class _$BillerCatalogCopyWithImpl<$Res>
    implements $BillerCatalogCopyWith<$Res> {
  _$BillerCatalogCopyWithImpl(this._self, this._then);

  final BillerCatalog _self;
  final $Res Function(BillerCatalog) _then;

/// Create a copy of BillerCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? billers = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<BillerCategory>,billers: null == billers ? _self.billers : billers // ignore: cast_nullable_to_non_nullable
as List<Biller>,
  ));
}

}


/// Adds pattern-matching-related methods to [BillerCatalog].
extension BillerCatalogPatterns on BillerCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillerCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillerCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillerCatalog value)  $default,){
final _that = this;
switch (_that) {
case _BillerCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillerCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _BillerCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BillerCategory> categories,  List<Biller> billers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillerCatalog() when $default != null:
return $default(_that.categories,_that.billers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BillerCategory> categories,  List<Biller> billers)  $default,) {final _that = this;
switch (_that) {
case _BillerCatalog():
return $default(_that.categories,_that.billers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BillerCategory> categories,  List<Biller> billers)?  $default,) {final _that = this;
switch (_that) {
case _BillerCatalog() when $default != null:
return $default(_that.categories,_that.billers);case _:
  return null;

}
}

}

/// @nodoc


class _BillerCatalog extends BillerCatalog {
  const _BillerCatalog({required final  List<BillerCategory> categories, required final  List<Biller> billers}): _categories = categories,_billers = billers,super._();
  

 final  List<BillerCategory> _categories;
@override List<BillerCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Biller> _billers;
@override List<Biller> get billers {
  if (_billers is EqualUnmodifiableListView) return _billers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_billers);
}


/// Create a copy of BillerCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillerCatalogCopyWith<_BillerCatalog> get copyWith => __$BillerCatalogCopyWithImpl<_BillerCatalog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillerCatalog&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._billers, _billers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_billers));

@override
String toString() {
  return 'BillerCatalog(categories: $categories, billers: $billers)';
}


}

/// @nodoc
abstract mixin class _$BillerCatalogCopyWith<$Res> implements $BillerCatalogCopyWith<$Res> {
  factory _$BillerCatalogCopyWith(_BillerCatalog value, $Res Function(_BillerCatalog) _then) = __$BillerCatalogCopyWithImpl;
@override @useResult
$Res call({
 List<BillerCategory> categories, List<Biller> billers
});




}
/// @nodoc
class __$BillerCatalogCopyWithImpl<$Res>
    implements _$BillerCatalogCopyWith<$Res> {
  __$BillerCatalogCopyWithImpl(this._self, this._then);

  final _BillerCatalog _self;
  final $Res Function(_BillerCatalog) _then;

/// Create a copy of BillerCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? billers = null,}) {
  return _then(_BillerCatalog(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<BillerCategory>,billers: null == billers ? _self._billers : billers // ignore: cast_nullable_to_non_nullable
as List<Biller>,
  ));
}


}

// dart format on
