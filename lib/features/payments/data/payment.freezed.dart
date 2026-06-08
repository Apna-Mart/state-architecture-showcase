// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Payment {

 String get id; String get billerId; String get billerName; String get categoryId; String get account; int get amountPaise; DateTime get paidAtUtc; PaymentStatus get status;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.account, account) || other.account == account)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.paidAtUtc, paidAtUtc) || other.paidAtUtc == paidAtUtc)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,billerId,billerName,categoryId,account,amountPaise,paidAtUtc,status);

@override
String toString() {
  return 'Payment(id: $id, billerId: $billerId, billerName: $billerName, categoryId: $categoryId, account: $account, amountPaise: $amountPaise, paidAtUtc: $paidAtUtc, status: $status)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String billerId, String billerName, String categoryId, String account, int amountPaise, DateTime paidAtUtc, PaymentStatus status
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? billerId = null,Object? billerName = null,Object? categoryId = null,Object? account = null,Object? amountPaise = null,Object? paidAtUtc = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,paidAtUtc: null == paidAtUtc ? _self.paidAtUtc : paidAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String billerId,  String billerName,  String categoryId,  String account,  int amountPaise,  DateTime paidAtUtc,  PaymentStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.billerId,_that.billerName,_that.categoryId,_that.account,_that.amountPaise,_that.paidAtUtc,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String billerId,  String billerName,  String categoryId,  String account,  int amountPaise,  DateTime paidAtUtc,  PaymentStatus status)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.billerId,_that.billerName,_that.categoryId,_that.account,_that.amountPaise,_that.paidAtUtc,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String billerId,  String billerName,  String categoryId,  String account,  int amountPaise,  DateTime paidAtUtc,  PaymentStatus status)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.billerId,_that.billerName,_that.categoryId,_that.account,_that.amountPaise,_that.paidAtUtc,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Payment implements Payment {
  const _Payment({required this.id, required this.billerId, required this.billerName, required this.categoryId, required this.account, required this.amountPaise, required this.paidAtUtc, required this.status});
  

@override final  String id;
@override final  String billerId;
@override final  String billerName;
@override final  String categoryId;
@override final  String account;
@override final  int amountPaise;
@override final  DateTime paidAtUtc;
@override final  PaymentStatus status;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.account, account) || other.account == account)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.paidAtUtc, paidAtUtc) || other.paidAtUtc == paidAtUtc)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,billerId,billerName,categoryId,account,amountPaise,paidAtUtc,status);

@override
String toString() {
  return 'Payment(id: $id, billerId: $billerId, billerName: $billerName, categoryId: $categoryId, account: $account, amountPaise: $amountPaise, paidAtUtc: $paidAtUtc, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String billerId, String billerName, String categoryId, String account, int amountPaise, DateTime paidAtUtc, PaymentStatus status
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? billerId = null,Object? billerName = null,Object? categoryId = null,Object? account = null,Object? amountPaise = null,Object? paidAtUtc = null,Object? status = null,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,paidAtUtc: null == paidAtUtc ? _self.paidAtUtc : paidAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,
  ));
}


}

/// @nodoc
mixin _$Payments {

 List<Payment> get items; int get nextId;
/// Create a copy of Payments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentsCopyWith<Payments> get copyWith => _$PaymentsCopyWithImpl<Payments>(this as Payments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payments&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextId, nextId) || other.nextId == nextId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextId);

@override
String toString() {
  return 'Payments(items: $items, nextId: $nextId)';
}


}

/// @nodoc
abstract mixin class $PaymentsCopyWith<$Res>  {
  factory $PaymentsCopyWith(Payments value, $Res Function(Payments) _then) = _$PaymentsCopyWithImpl;
@useResult
$Res call({
 List<Payment> items, int nextId
});




}
/// @nodoc
class _$PaymentsCopyWithImpl<$Res>
    implements $PaymentsCopyWith<$Res> {
  _$PaymentsCopyWithImpl(this._self, this._then);

  final Payments _self;
  final $Res Function(Payments) _then;

/// Create a copy of Payments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextId = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Payment>,nextId: null == nextId ? _self.nextId : nextId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Payments].
extension PaymentsPatterns on Payments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payments value)  $default,){
final _that = this;
switch (_that) {
case _Payments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payments value)?  $default,){
final _that = this;
switch (_that) {
case _Payments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Payment> items,  int nextId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payments() when $default != null:
return $default(_that.items,_that.nextId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Payment> items,  int nextId)  $default,) {final _that = this;
switch (_that) {
case _Payments():
return $default(_that.items,_that.nextId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Payment> items,  int nextId)?  $default,) {final _that = this;
switch (_that) {
case _Payments() when $default != null:
return $default(_that.items,_that.nextId);case _:
  return null;

}
}

}

/// @nodoc


class _Payments extends Payments {
  const _Payments({required final  List<Payment> items, required this.nextId}): _items = items,super._();
  

 final  List<Payment> _items;
@override List<Payment> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int nextId;

/// Create a copy of Payments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentsCopyWith<_Payments> get copyWith => __$PaymentsCopyWithImpl<_Payments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payments&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextId, nextId) || other.nextId == nextId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextId);

@override
String toString() {
  return 'Payments(items: $items, nextId: $nextId)';
}


}

/// @nodoc
abstract mixin class _$PaymentsCopyWith<$Res> implements $PaymentsCopyWith<$Res> {
  factory _$PaymentsCopyWith(_Payments value, $Res Function(_Payments) _then) = __$PaymentsCopyWithImpl;
@override @useResult
$Res call({
 List<Payment> items, int nextId
});




}
/// @nodoc
class __$PaymentsCopyWithImpl<$Res>
    implements _$PaymentsCopyWith<$Res> {
  __$PaymentsCopyWithImpl(this._self, this._then);

  final _Payments _self;
  final $Res Function(_Payments) _then;

/// Create a copy of Payments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextId = null,}) {
  return _then(_Payments(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Payment>,nextId: null == nextId ? _self.nextId : nextId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
