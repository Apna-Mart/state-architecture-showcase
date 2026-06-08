// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_fetch_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FetchFieldData {

 String get key; String get label; String get hint;
/// Create a copy of FetchFieldData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchFieldDataCopyWith<FetchFieldData> get copyWith => _$FetchFieldDataCopyWithImpl<FetchFieldData>(this as FetchFieldData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchFieldData&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.hint, hint) || other.hint == hint));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,hint);

@override
String toString() {
  return 'FetchFieldData(key: $key, label: $label, hint: $hint)';
}


}

/// @nodoc
abstract mixin class $FetchFieldDataCopyWith<$Res>  {
  factory $FetchFieldDataCopyWith(FetchFieldData value, $Res Function(FetchFieldData) _then) = _$FetchFieldDataCopyWithImpl;
@useResult
$Res call({
 String key, String label, String hint
});




}
/// @nodoc
class _$FetchFieldDataCopyWithImpl<$Res>
    implements $FetchFieldDataCopyWith<$Res> {
  _$FetchFieldDataCopyWithImpl(this._self, this._then);

  final FetchFieldData _self;
  final $Res Function(FetchFieldData) _then;

/// Create a copy of FetchFieldData
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


/// Adds pattern-matching-related methods to [FetchFieldData].
extension FetchFieldDataPatterns on FetchFieldData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchFieldData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchFieldData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchFieldData value)  $default,){
final _that = this;
switch (_that) {
case _FetchFieldData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchFieldData value)?  $default,){
final _that = this;
switch (_that) {
case _FetchFieldData() when $default != null:
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
case _FetchFieldData() when $default != null:
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
case _FetchFieldData():
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
case _FetchFieldData() when $default != null:
return $default(_that.key,_that.label,_that.hint);case _:
  return null;

}
}

}

/// @nodoc


class _FetchFieldData implements FetchFieldData {
  const _FetchFieldData({required this.key, required this.label, required this.hint});
  

@override final  String key;
@override final  String label;
@override final  String hint;

/// Create a copy of FetchFieldData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchFieldDataCopyWith<_FetchFieldData> get copyWith => __$FetchFieldDataCopyWithImpl<_FetchFieldData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchFieldData&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.hint, hint) || other.hint == hint));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,hint);

@override
String toString() {
  return 'FetchFieldData(key: $key, label: $label, hint: $hint)';
}


}

/// @nodoc
abstract mixin class _$FetchFieldDataCopyWith<$Res> implements $FetchFieldDataCopyWith<$Res> {
  factory _$FetchFieldDataCopyWith(_FetchFieldData value, $Res Function(_FetchFieldData) _then) = __$FetchFieldDataCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String hint
});




}
/// @nodoc
class __$FetchFieldDataCopyWithImpl<$Res>
    implements _$FetchFieldDataCopyWith<$Res> {
  __$FetchFieldDataCopyWithImpl(this._self, this._then);

  final _FetchFieldData _self;
  final $Res Function(_FetchFieldData) _then;

/// Create a copy of FetchFieldData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? hint = null,}) {
  return _then(_FetchFieldData(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FetchInputsData {

 List<FetchFieldData> get fields; bool get showAmount;
/// Create a copy of FetchInputsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchInputsDataCopyWith<FetchInputsData> get copyWith => _$FetchInputsDataCopyWithImpl<FetchInputsData>(this as FetchInputsData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInputsData&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.showAmount, showAmount) || other.showAmount == showAmount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fields),showAmount);

@override
String toString() {
  return 'FetchInputsData(fields: $fields, showAmount: $showAmount)';
}


}

/// @nodoc
abstract mixin class $FetchInputsDataCopyWith<$Res>  {
  factory $FetchInputsDataCopyWith(FetchInputsData value, $Res Function(FetchInputsData) _then) = _$FetchInputsDataCopyWithImpl;
@useResult
$Res call({
 List<FetchFieldData> fields, bool showAmount
});




}
/// @nodoc
class _$FetchInputsDataCopyWithImpl<$Res>
    implements $FetchInputsDataCopyWith<$Res> {
  _$FetchInputsDataCopyWithImpl(this._self, this._then);

  final FetchInputsData _self;
  final $Res Function(FetchInputsData) _then;

/// Create a copy of FetchInputsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fields = null,Object? showAmount = null,}) {
  return _then(_self.copyWith(
fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<FetchFieldData>,showAmount: null == showAmount ? _self.showAmount : showAmount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchInputsData].
extension FetchInputsDataPatterns on FetchInputsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchInputsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchInputsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchInputsData value)  $default,){
final _that = this;
switch (_that) {
case _FetchInputsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchInputsData value)?  $default,){
final _that = this;
switch (_that) {
case _FetchInputsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FetchFieldData> fields,  bool showAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchInputsData() when $default != null:
return $default(_that.fields,_that.showAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FetchFieldData> fields,  bool showAmount)  $default,) {final _that = this;
switch (_that) {
case _FetchInputsData():
return $default(_that.fields,_that.showAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FetchFieldData> fields,  bool showAmount)?  $default,) {final _that = this;
switch (_that) {
case _FetchInputsData() when $default != null:
return $default(_that.fields,_that.showAmount);case _:
  return null;

}
}

}

/// @nodoc


class _FetchInputsData implements FetchInputsData {
  const _FetchInputsData({required final  List<FetchFieldData> fields, required this.showAmount}): _fields = fields;
  

 final  List<FetchFieldData> _fields;
@override List<FetchFieldData> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}

@override final  bool showAmount;

/// Create a copy of FetchInputsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchInputsDataCopyWith<_FetchInputsData> get copyWith => __$FetchInputsDataCopyWithImpl<_FetchInputsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchInputsData&&const DeepCollectionEquality().equals(other._fields, _fields)&&(identical(other.showAmount, showAmount) || other.showAmount == showAmount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fields),showAmount);

@override
String toString() {
  return 'FetchInputsData(fields: $fields, showAmount: $showAmount)';
}


}

/// @nodoc
abstract mixin class _$FetchInputsDataCopyWith<$Res> implements $FetchInputsDataCopyWith<$Res> {
  factory _$FetchInputsDataCopyWith(_FetchInputsData value, $Res Function(_FetchInputsData) _then) = __$FetchInputsDataCopyWithImpl;
@override @useResult
$Res call({
 List<FetchFieldData> fields, bool showAmount
});




}
/// @nodoc
class __$FetchInputsDataCopyWithImpl<$Res>
    implements _$FetchInputsDataCopyWith<$Res> {
  __$FetchInputsDataCopyWithImpl(this._self, this._then);

  final _FetchInputsData _self;
  final $Res Function(_FetchInputsData) _then;

/// Create a copy of FetchInputsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fields = null,Object? showAmount = null,}) {
  return _then(_FetchInputsData(
fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<FetchFieldData>,showAmount: null == showAmount ? _self.showAmount : showAmount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$FetchSubmitData {

 FetchSubmitAction get action; String? get location;
/// Create a copy of FetchSubmitData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchSubmitDataCopyWith<FetchSubmitData> get copyWith => _$FetchSubmitDataCopyWithImpl<FetchSubmitData>(this as FetchSubmitData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSubmitData&&(identical(other.action, action) || other.action == action)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,action,location);

@override
String toString() {
  return 'FetchSubmitData(action: $action, location: $location)';
}


}

/// @nodoc
abstract mixin class $FetchSubmitDataCopyWith<$Res>  {
  factory $FetchSubmitDataCopyWith(FetchSubmitData value, $Res Function(FetchSubmitData) _then) = _$FetchSubmitDataCopyWithImpl;
@useResult
$Res call({
 FetchSubmitAction action, String? location
});




}
/// @nodoc
class _$FetchSubmitDataCopyWithImpl<$Res>
    implements $FetchSubmitDataCopyWith<$Res> {
  _$FetchSubmitDataCopyWithImpl(this._self, this._then);

  final FetchSubmitData _self;
  final $Res Function(FetchSubmitData) _then;

/// Create a copy of FetchSubmitData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FetchSubmitAction,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchSubmitData].
extension FetchSubmitDataPatterns on FetchSubmitData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchSubmitData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchSubmitData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchSubmitData value)  $default,){
final _that = this;
switch (_that) {
case _FetchSubmitData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchSubmitData value)?  $default,){
final _that = this;
switch (_that) {
case _FetchSubmitData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FetchSubmitAction action,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchSubmitData() when $default != null:
return $default(_that.action,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FetchSubmitAction action,  String? location)  $default,) {final _that = this;
switch (_that) {
case _FetchSubmitData():
return $default(_that.action,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FetchSubmitAction action,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _FetchSubmitData() when $default != null:
return $default(_that.action,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _FetchSubmitData implements FetchSubmitData {
  const _FetchSubmitData({required this.action, required this.location});
  

@override final  FetchSubmitAction action;
@override final  String? location;

/// Create a copy of FetchSubmitData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchSubmitDataCopyWith<_FetchSubmitData> get copyWith => __$FetchSubmitDataCopyWithImpl<_FetchSubmitData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchSubmitData&&(identical(other.action, action) || other.action == action)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,action,location);

@override
String toString() {
  return 'FetchSubmitData(action: $action, location: $location)';
}


}

/// @nodoc
abstract mixin class _$FetchSubmitDataCopyWith<$Res> implements $FetchSubmitDataCopyWith<$Res> {
  factory _$FetchSubmitDataCopyWith(_FetchSubmitData value, $Res Function(_FetchSubmitData) _then) = __$FetchSubmitDataCopyWithImpl;
@override @useResult
$Res call({
 FetchSubmitAction action, String? location
});




}
/// @nodoc
class __$FetchSubmitDataCopyWithImpl<$Res>
    implements _$FetchSubmitDataCopyWith<$Res> {
  __$FetchSubmitDataCopyWithImpl(this._self, this._then);

  final _FetchSubmitData _self;
  final $Res Function(_FetchSubmitData) _then;

/// Create a copy of FetchSubmitData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? location = freezed,}) {
  return _then(_FetchSubmitData(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FetchSubmitAction,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$BillFetchScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillFetchScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BillFetchScreenData()';
}


}

/// @nodoc
class $BillFetchScreenDataCopyWith<$Res>  {
$BillFetchScreenDataCopyWith(BillFetchScreenData _, $Res Function(BillFetchScreenData) __);
}


/// Adds pattern-matching-related methods to [BillFetchScreenData].
extension BillFetchScreenDataPatterns on BillFetchScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BillFetchLoading value)?  loading,TResult Function( BillFetchError value)?  error,TResult Function( BillFetchFormData value)?  form,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BillFetchLoading() when loading != null:
return loading(_that);case BillFetchError() when error != null:
return error(_that);case BillFetchFormData() when form != null:
return form(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BillFetchLoading value)  loading,required TResult Function( BillFetchError value)  error,required TResult Function( BillFetchFormData value)  form,}){
final _that = this;
switch (_that) {
case BillFetchLoading():
return loading(_that);case BillFetchError():
return error(_that);case BillFetchFormData():
return form(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BillFetchLoading value)?  loading,TResult? Function( BillFetchError value)?  error,TResult? Function( BillFetchFormData value)?  form,}){
final _that = this;
switch (_that) {
case BillFetchLoading() when loading != null:
return loading(_that);case BillFetchError() when error != null:
return error(_that);case BillFetchFormData() when form != null:
return form(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( String billerName,  FetchInputsData inputs,  FetchSubmitData submit)?  form,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BillFetchLoading() when loading != null:
return loading();case BillFetchError() when error != null:
return error(_that.message);case BillFetchFormData() when form != null:
return form(_that.billerName,_that.inputs,_that.submit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( String billerName,  FetchInputsData inputs,  FetchSubmitData submit)  form,}) {final _that = this;
switch (_that) {
case BillFetchLoading():
return loading();case BillFetchError():
return error(_that.message);case BillFetchFormData():
return form(_that.billerName,_that.inputs,_that.submit);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( String billerName,  FetchInputsData inputs,  FetchSubmitData submit)?  form,}) {final _that = this;
switch (_that) {
case BillFetchLoading() when loading != null:
return loading();case BillFetchError() when error != null:
return error(_that.message);case BillFetchFormData() when form != null:
return form(_that.billerName,_that.inputs,_that.submit);case _:
  return null;

}
}

}

/// @nodoc


class BillFetchLoading implements BillFetchScreenData {
  const BillFetchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillFetchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BillFetchScreenData.loading()';
}


}




/// @nodoc


class BillFetchError implements BillFetchScreenData {
  const BillFetchError(this.message);
  

 final  String message;

/// Create a copy of BillFetchScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillFetchErrorCopyWith<BillFetchError> get copyWith => _$BillFetchErrorCopyWithImpl<BillFetchError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillFetchError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BillFetchScreenData.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BillFetchErrorCopyWith<$Res> implements $BillFetchScreenDataCopyWith<$Res> {
  factory $BillFetchErrorCopyWith(BillFetchError value, $Res Function(BillFetchError) _then) = _$BillFetchErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BillFetchErrorCopyWithImpl<$Res>
    implements $BillFetchErrorCopyWith<$Res> {
  _$BillFetchErrorCopyWithImpl(this._self, this._then);

  final BillFetchError _self;
  final $Res Function(BillFetchError) _then;

/// Create a copy of BillFetchScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BillFetchError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BillFetchFormData implements BillFetchScreenData {
  const BillFetchFormData({required this.billerName, required this.inputs, required this.submit});
  

 final  String billerName;
 final  FetchInputsData inputs;
 final  FetchSubmitData submit;

/// Create a copy of BillFetchScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillFetchFormDataCopyWith<BillFetchFormData> get copyWith => _$BillFetchFormDataCopyWithImpl<BillFetchFormData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillFetchFormData&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.inputs, inputs) || other.inputs == inputs)&&(identical(other.submit, submit) || other.submit == submit));
}


@override
int get hashCode => Object.hash(runtimeType,billerName,inputs,submit);

@override
String toString() {
  return 'BillFetchScreenData.form(billerName: $billerName, inputs: $inputs, submit: $submit)';
}


}

/// @nodoc
abstract mixin class $BillFetchFormDataCopyWith<$Res> implements $BillFetchScreenDataCopyWith<$Res> {
  factory $BillFetchFormDataCopyWith(BillFetchFormData value, $Res Function(BillFetchFormData) _then) = _$BillFetchFormDataCopyWithImpl;
@useResult
$Res call({
 String billerName, FetchInputsData inputs, FetchSubmitData submit
});


$FetchInputsDataCopyWith<$Res> get inputs;$FetchSubmitDataCopyWith<$Res> get submit;

}
/// @nodoc
class _$BillFetchFormDataCopyWithImpl<$Res>
    implements $BillFetchFormDataCopyWith<$Res> {
  _$BillFetchFormDataCopyWithImpl(this._self, this._then);

  final BillFetchFormData _self;
  final $Res Function(BillFetchFormData) _then;

/// Create a copy of BillFetchScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billerName = null,Object? inputs = null,Object? submit = null,}) {
  return _then(BillFetchFormData(
billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,inputs: null == inputs ? _self.inputs : inputs // ignore: cast_nullable_to_non_nullable
as FetchInputsData,submit: null == submit ? _self.submit : submit // ignore: cast_nullable_to_non_nullable
as FetchSubmitData,
  ));
}

/// Create a copy of BillFetchScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FetchInputsDataCopyWith<$Res> get inputs {
  
  return $FetchInputsDataCopyWith<$Res>(_self.inputs, (value) {
    return _then(_self.copyWith(inputs: value));
  });
}/// Create a copy of BillFetchScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FetchSubmitDataCopyWith<$Res> get submit {
  
  return $FetchSubmitDataCopyWith<$Res>(_self.submit, (value) {
    return _then(_self.copyWith(submit: value));
  });
}
}

// dart format on
