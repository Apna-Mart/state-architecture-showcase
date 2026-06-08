// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentListItemData {

 String get id; String get billerName; String get account; int get amountPaise; DateTime get paidAt; PaymentStatus get status;
/// Create a copy of PaymentListItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentListItemDataCopyWith<PaymentListItemData> get copyWith => _$PaymentListItemDataCopyWithImpl<PaymentListItemData>(this as PaymentListItemData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentListItemData&&(identical(other.id, id) || other.id == id)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.account, account) || other.account == account)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,billerName,account,amountPaise,paidAt,status);

@override
String toString() {
  return 'PaymentListItemData(id: $id, billerName: $billerName, account: $account, amountPaise: $amountPaise, paidAt: $paidAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $PaymentListItemDataCopyWith<$Res>  {
  factory $PaymentListItemDataCopyWith(PaymentListItemData value, $Res Function(PaymentListItemData) _then) = _$PaymentListItemDataCopyWithImpl;
@useResult
$Res call({
 String id, String billerName, String account, int amountPaise, DateTime paidAt, PaymentStatus status
});




}
/// @nodoc
class _$PaymentListItemDataCopyWithImpl<$Res>
    implements $PaymentListItemDataCopyWith<$Res> {
  _$PaymentListItemDataCopyWithImpl(this._self, this._then);

  final PaymentListItemData _self;
  final $Res Function(PaymentListItemData) _then;

/// Create a copy of PaymentListItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? billerName = null,Object? account = null,Object? amountPaise = null,Object? paidAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentListItemData].
extension PaymentListItemDataPatterns on PaymentListItemData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentListItemData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentListItemData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentListItemData value)  $default,){
final _that = this;
switch (_that) {
case _PaymentListItemData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentListItemData value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentListItemData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String billerName,  String account,  int amountPaise,  DateTime paidAt,  PaymentStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentListItemData() when $default != null:
return $default(_that.id,_that.billerName,_that.account,_that.amountPaise,_that.paidAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String billerName,  String account,  int amountPaise,  DateTime paidAt,  PaymentStatus status)  $default,) {final _that = this;
switch (_that) {
case _PaymentListItemData():
return $default(_that.id,_that.billerName,_that.account,_that.amountPaise,_that.paidAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String billerName,  String account,  int amountPaise,  DateTime paidAt,  PaymentStatus status)?  $default,) {final _that = this;
switch (_that) {
case _PaymentListItemData() when $default != null:
return $default(_that.id,_that.billerName,_that.account,_that.amountPaise,_that.paidAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentListItemData implements PaymentListItemData {
  const _PaymentListItemData({required this.id, required this.billerName, required this.account, required this.amountPaise, required this.paidAt, required this.status});
  

@override final  String id;
@override final  String billerName;
@override final  String account;
@override final  int amountPaise;
@override final  DateTime paidAt;
@override final  PaymentStatus status;

/// Create a copy of PaymentListItemData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentListItemDataCopyWith<_PaymentListItemData> get copyWith => __$PaymentListItemDataCopyWithImpl<_PaymentListItemData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentListItemData&&(identical(other.id, id) || other.id == id)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.account, account) || other.account == account)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,billerName,account,amountPaise,paidAt,status);

@override
String toString() {
  return 'PaymentListItemData(id: $id, billerName: $billerName, account: $account, amountPaise: $amountPaise, paidAt: $paidAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PaymentListItemDataCopyWith<$Res> implements $PaymentListItemDataCopyWith<$Res> {
  factory _$PaymentListItemDataCopyWith(_PaymentListItemData value, $Res Function(_PaymentListItemData) _then) = __$PaymentListItemDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String billerName, String account, int amountPaise, DateTime paidAt, PaymentStatus status
});




}
/// @nodoc
class __$PaymentListItemDataCopyWithImpl<$Res>
    implements _$PaymentListItemDataCopyWith<$Res> {
  __$PaymentListItemDataCopyWithImpl(this._self, this._then);

  final _PaymentListItemData _self;
  final $Res Function(_PaymentListItemData) _then;

/// Create a copy of PaymentListItemData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? billerName = null,Object? account = null,Object? amountPaise = null,Object? paidAt = null,Object? status = null,}) {
  return _then(_PaymentListItemData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,
  ));
}


}

/// @nodoc
mixin _$HistoryScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryScreenData()';
}


}

/// @nodoc
class $HistoryScreenDataCopyWith<$Res>  {
$HistoryScreenDataCopyWith(HistoryScreenData _, $Res Function(HistoryScreenData) __);
}


/// Adds pattern-matching-related methods to [HistoryScreenData].
extension HistoryScreenDataPatterns on HistoryScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HistoryEmpty value)?  empty,TResult Function( HistoryLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HistoryEmpty() when empty != null:
return empty(_that);case HistoryLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HistoryEmpty value)  empty,required TResult Function( HistoryLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case HistoryEmpty():
return empty(_that);case HistoryLoaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HistoryEmpty value)?  empty,TResult? Function( HistoryLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case HistoryEmpty() when empty != null:
return empty(_that);case HistoryLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  empty,TResult Function( List<PaymentListItemData> items)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryEmpty() when empty != null:
return empty();case HistoryLoaded() when loaded != null:
return loaded(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  empty,required TResult Function( List<PaymentListItemData> items)  loaded,}) {final _that = this;
switch (_that) {
case HistoryEmpty():
return empty();case HistoryLoaded():
return loaded(_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  empty,TResult? Function( List<PaymentListItemData> items)?  loaded,}) {final _that = this;
switch (_that) {
case HistoryEmpty() when empty != null:
return empty();case HistoryLoaded() when loaded != null:
return loaded(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class HistoryEmpty implements HistoryScreenData {
  const HistoryEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryScreenData.empty()';
}


}




/// @nodoc


class HistoryLoaded implements HistoryScreenData {
  const HistoryLoaded({required final  List<PaymentListItemData> items}): _items = items;
  

 final  List<PaymentListItemData> _items;
 List<PaymentListItemData> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HistoryScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLoadedCopyWith<HistoryLoaded> get copyWith => _$HistoryLoadedCopyWithImpl<HistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HistoryScreenData.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $HistoryLoadedCopyWith<$Res> implements $HistoryScreenDataCopyWith<$Res> {
  factory $HistoryLoadedCopyWith(HistoryLoaded value, $Res Function(HistoryLoaded) _then) = _$HistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<PaymentListItemData> items
});




}
/// @nodoc
class _$HistoryLoadedCopyWithImpl<$Res>
    implements $HistoryLoadedCopyWith<$Res> {
  _$HistoryLoadedCopyWithImpl(this._self, this._then);

  final HistoryLoaded _self;
  final $Res Function(HistoryLoaded) _then;

/// Create a copy of HistoryScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(HistoryLoaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PaymentListItemData>,
  ));
}


}

// dart format on
