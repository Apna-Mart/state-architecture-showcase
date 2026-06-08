// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_fetch_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillFetchForm {

 Map<String, String> get values; String get amountText;
/// Create a copy of BillFetchForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillFetchFormCopyWith<BillFetchForm> get copyWith => _$BillFetchFormCopyWithImpl<BillFetchForm>(this as BillFetchForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillFetchForm&&const DeepCollectionEquality().equals(other.values, values)&&(identical(other.amountText, amountText) || other.amountText == amountText));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(values),amountText);

@override
String toString() {
  return 'BillFetchForm(values: $values, amountText: $amountText)';
}


}

/// @nodoc
abstract mixin class $BillFetchFormCopyWith<$Res>  {
  factory $BillFetchFormCopyWith(BillFetchForm value, $Res Function(BillFetchForm) _then) = _$BillFetchFormCopyWithImpl;
@useResult
$Res call({
 Map<String, String> values, String amountText
});




}
/// @nodoc
class _$BillFetchFormCopyWithImpl<$Res>
    implements $BillFetchFormCopyWith<$Res> {
  _$BillFetchFormCopyWithImpl(this._self, this._then);

  final BillFetchForm _self;
  final $Res Function(BillFetchForm) _then;

/// Create a copy of BillFetchForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? values = null,Object? amountText = null,}) {
  return _then(_self.copyWith(
values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as Map<String, String>,amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillFetchForm].
extension BillFetchFormPatterns on BillFetchForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillFetchForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillFetchForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillFetchForm value)  $default,){
final _that = this;
switch (_that) {
case _BillFetchForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillFetchForm value)?  $default,){
final _that = this;
switch (_that) {
case _BillFetchForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> values,  String amountText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillFetchForm() when $default != null:
return $default(_that.values,_that.amountText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> values,  String amountText)  $default,) {final _that = this;
switch (_that) {
case _BillFetchForm():
return $default(_that.values,_that.amountText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> values,  String amountText)?  $default,) {final _that = this;
switch (_that) {
case _BillFetchForm() when $default != null:
return $default(_that.values,_that.amountText);case _:
  return null;

}
}

}

/// @nodoc


class _BillFetchForm extends BillFetchForm {
  const _BillFetchForm({required final  Map<String, String> values, required this.amountText}): _values = values,super._();
  

 final  Map<String, String> _values;
@override Map<String, String> get values {
  if (_values is EqualUnmodifiableMapView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_values);
}

@override final  String amountText;

/// Create a copy of BillFetchForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillFetchFormCopyWith<_BillFetchForm> get copyWith => __$BillFetchFormCopyWithImpl<_BillFetchForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillFetchForm&&const DeepCollectionEquality().equals(other._values, _values)&&(identical(other.amountText, amountText) || other.amountText == amountText));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_values),amountText);

@override
String toString() {
  return 'BillFetchForm(values: $values, amountText: $amountText)';
}


}

/// @nodoc
abstract mixin class _$BillFetchFormCopyWith<$Res> implements $BillFetchFormCopyWith<$Res> {
  factory _$BillFetchFormCopyWith(_BillFetchForm value, $Res Function(_BillFetchForm) _then) = __$BillFetchFormCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> values, String amountText
});




}
/// @nodoc
class __$BillFetchFormCopyWithImpl<$Res>
    implements _$BillFetchFormCopyWith<$Res> {
  __$BillFetchFormCopyWithImpl(this._self, this._then);

  final _BillFetchForm _self;
  final $Res Function(_BillFetchForm) _then;

/// Create a copy of BillFetchForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? values = null,Object? amountText = null,}) {
  return _then(_BillFetchForm(
values: null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as Map<String, String>,amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
