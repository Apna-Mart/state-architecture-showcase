// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetched_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FetchedBill {

 String get billerId; String get account; String get customerName; int get amountPaise; DateTime get dueDate; String get billNumber;
/// Create a copy of FetchedBill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchedBillCopyWith<FetchedBill> get copyWith => _$FetchedBillCopyWithImpl<FetchedBill>(this as FetchedBill, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchedBill&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,customerName,amountPaise,dueDate,billNumber);

@override
String toString() {
  return 'FetchedBill(billerId: $billerId, account: $account, customerName: $customerName, amountPaise: $amountPaise, dueDate: $dueDate, billNumber: $billNumber)';
}


}

/// @nodoc
abstract mixin class $FetchedBillCopyWith<$Res>  {
  factory $FetchedBillCopyWith(FetchedBill value, $Res Function(FetchedBill) _then) = _$FetchedBillCopyWithImpl;
@useResult
$Res call({
 String billerId, String account, String customerName, int amountPaise, DateTime dueDate, String billNumber
});




}
/// @nodoc
class _$FetchedBillCopyWithImpl<$Res>
    implements $FetchedBillCopyWith<$Res> {
  _$FetchedBillCopyWithImpl(this._self, this._then);

  final FetchedBill _self;
  final $Res Function(FetchedBill) _then;

/// Create a copy of FetchedBill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billerId = null,Object? account = null,Object? customerName = null,Object? amountPaise = null,Object? dueDate = null,Object? billNumber = null,}) {
  return _then(_self.copyWith(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchedBill].
extension FetchedBillPatterns on FetchedBill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchedBill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchedBill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchedBill value)  $default,){
final _that = this;
switch (_that) {
case _FetchedBill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchedBill value)?  $default,){
final _that = this;
switch (_that) {
case _FetchedBill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billerId,  String account,  String customerName,  int amountPaise,  DateTime dueDate,  String billNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchedBill() when $default != null:
return $default(_that.billerId,_that.account,_that.customerName,_that.amountPaise,_that.dueDate,_that.billNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billerId,  String account,  String customerName,  int amountPaise,  DateTime dueDate,  String billNumber)  $default,) {final _that = this;
switch (_that) {
case _FetchedBill():
return $default(_that.billerId,_that.account,_that.customerName,_that.amountPaise,_that.dueDate,_that.billNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billerId,  String account,  String customerName,  int amountPaise,  DateTime dueDate,  String billNumber)?  $default,) {final _that = this;
switch (_that) {
case _FetchedBill() when $default != null:
return $default(_that.billerId,_that.account,_that.customerName,_that.amountPaise,_that.dueDate,_that.billNumber);case _:
  return null;

}
}

}

/// @nodoc


class _FetchedBill implements FetchedBill {
  const _FetchedBill({required this.billerId, required this.account, required this.customerName, required this.amountPaise, required this.dueDate, required this.billNumber});
  

@override final  String billerId;
@override final  String account;
@override final  String customerName;
@override final  int amountPaise;
@override final  DateTime dueDate;
@override final  String billNumber;

/// Create a copy of FetchedBill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchedBillCopyWith<_FetchedBill> get copyWith => __$FetchedBillCopyWithImpl<_FetchedBill>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchedBill&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,customerName,amountPaise,dueDate,billNumber);

@override
String toString() {
  return 'FetchedBill(billerId: $billerId, account: $account, customerName: $customerName, amountPaise: $amountPaise, dueDate: $dueDate, billNumber: $billNumber)';
}


}

/// @nodoc
abstract mixin class _$FetchedBillCopyWith<$Res> implements $FetchedBillCopyWith<$Res> {
  factory _$FetchedBillCopyWith(_FetchedBill value, $Res Function(_FetchedBill) _then) = __$FetchedBillCopyWithImpl;
@override @useResult
$Res call({
 String billerId, String account, String customerName, int amountPaise, DateTime dueDate, String billNumber
});




}
/// @nodoc
class __$FetchedBillCopyWithImpl<$Res>
    implements _$FetchedBillCopyWith<$Res> {
  __$FetchedBillCopyWithImpl(this._self, this._then);

  final _FetchedBill _self;
  final $Res Function(_FetchedBill) _then;

/// Create a copy of FetchedBill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billerId = null,Object? account = null,Object? customerName = null,Object? amountPaise = null,Object? dueDate = null,Object? billNumber = null,}) {
  return _then(_FetchedBill(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
