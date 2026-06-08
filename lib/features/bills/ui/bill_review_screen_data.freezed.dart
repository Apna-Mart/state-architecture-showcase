// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_review_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillReviewScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillReviewScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BillReviewScreenData()';
}


}

/// @nodoc
class $BillReviewScreenDataCopyWith<$Res>  {
$BillReviewScreenDataCopyWith(BillReviewScreenData _, $Res Function(BillReviewScreenData) __);
}


/// Adds pattern-matching-related methods to [BillReviewScreenData].
extension BillReviewScreenDataPatterns on BillReviewScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BillReviewLoading value)?  loading,TResult Function( BillReviewError value)?  error,TResult Function( BillReviewLoaded value)?  review,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BillReviewLoading() when loading != null:
return loading(_that);case BillReviewError() when error != null:
return error(_that);case BillReviewLoaded() when review != null:
return review(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BillReviewLoading value)  loading,required TResult Function( BillReviewError value)  error,required TResult Function( BillReviewLoaded value)  review,}){
final _that = this;
switch (_that) {
case BillReviewLoading():
return loading(_that);case BillReviewError():
return error(_that);case BillReviewLoaded():
return review(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BillReviewLoading value)?  loading,TResult? Function( BillReviewError value)?  error,TResult? Function( BillReviewLoaded value)?  review,}){
final _that = this;
switch (_that) {
case BillReviewLoading() when loading != null:
return loading(_that);case BillReviewError() when error != null:
return error(_that);case BillReviewLoaded() when review != null:
return review(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( String billerId,  String categoryId,  String billerName,  String account,  String? customerName,  int? dueInDays,  int amountPaise,  bool paying,  bool canPay)?  review,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BillReviewLoading() when loading != null:
return loading();case BillReviewError() when error != null:
return error(_that.message);case BillReviewLoaded() when review != null:
return review(_that.billerId,_that.categoryId,_that.billerName,_that.account,_that.customerName,_that.dueInDays,_that.amountPaise,_that.paying,_that.canPay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( String billerId,  String categoryId,  String billerName,  String account,  String? customerName,  int? dueInDays,  int amountPaise,  bool paying,  bool canPay)  review,}) {final _that = this;
switch (_that) {
case BillReviewLoading():
return loading();case BillReviewError():
return error(_that.message);case BillReviewLoaded():
return review(_that.billerId,_that.categoryId,_that.billerName,_that.account,_that.customerName,_that.dueInDays,_that.amountPaise,_that.paying,_that.canPay);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( String billerId,  String categoryId,  String billerName,  String account,  String? customerName,  int? dueInDays,  int amountPaise,  bool paying,  bool canPay)?  review,}) {final _that = this;
switch (_that) {
case BillReviewLoading() when loading != null:
return loading();case BillReviewError() when error != null:
return error(_that.message);case BillReviewLoaded() when review != null:
return review(_that.billerId,_that.categoryId,_that.billerName,_that.account,_that.customerName,_that.dueInDays,_that.amountPaise,_that.paying,_that.canPay);case _:
  return null;

}
}

}

/// @nodoc


class BillReviewLoading implements BillReviewScreenData {
  const BillReviewLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillReviewLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BillReviewScreenData.loading()';
}


}




/// @nodoc


class BillReviewError implements BillReviewScreenData {
  const BillReviewError(this.message);
  

 final  String message;

/// Create a copy of BillReviewScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillReviewErrorCopyWith<BillReviewError> get copyWith => _$BillReviewErrorCopyWithImpl<BillReviewError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillReviewError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BillReviewScreenData.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BillReviewErrorCopyWith<$Res> implements $BillReviewScreenDataCopyWith<$Res> {
  factory $BillReviewErrorCopyWith(BillReviewError value, $Res Function(BillReviewError) _then) = _$BillReviewErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BillReviewErrorCopyWithImpl<$Res>
    implements $BillReviewErrorCopyWith<$Res> {
  _$BillReviewErrorCopyWithImpl(this._self, this._then);

  final BillReviewError _self;
  final $Res Function(BillReviewError) _then;

/// Create a copy of BillReviewScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BillReviewError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BillReviewLoaded implements BillReviewScreenData {
  const BillReviewLoaded({required this.billerId, required this.categoryId, required this.billerName, required this.account, required this.customerName, required this.dueInDays, required this.amountPaise, required this.paying, required this.canPay});
  

 final  String billerId;
 final  String categoryId;
 final  String billerName;
 final  String account;
 final  String? customerName;
 final  int? dueInDays;
 final  int amountPaise;
 final  bool paying;
 final  bool canPay;

/// Create a copy of BillReviewScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillReviewLoadedCopyWith<BillReviewLoaded> get copyWith => _$BillReviewLoadedCopyWithImpl<BillReviewLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillReviewLoaded&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.account, account) || other.account == account)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.dueInDays, dueInDays) || other.dueInDays == dueInDays)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.paying, paying) || other.paying == paying)&&(identical(other.canPay, canPay) || other.canPay == canPay));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,categoryId,billerName,account,customerName,dueInDays,amountPaise,paying,canPay);

@override
String toString() {
  return 'BillReviewScreenData.review(billerId: $billerId, categoryId: $categoryId, billerName: $billerName, account: $account, customerName: $customerName, dueInDays: $dueInDays, amountPaise: $amountPaise, paying: $paying, canPay: $canPay)';
}


}

/// @nodoc
abstract mixin class $BillReviewLoadedCopyWith<$Res> implements $BillReviewScreenDataCopyWith<$Res> {
  factory $BillReviewLoadedCopyWith(BillReviewLoaded value, $Res Function(BillReviewLoaded) _then) = _$BillReviewLoadedCopyWithImpl;
@useResult
$Res call({
 String billerId, String categoryId, String billerName, String account, String? customerName, int? dueInDays, int amountPaise, bool paying, bool canPay
});




}
/// @nodoc
class _$BillReviewLoadedCopyWithImpl<$Res>
    implements $BillReviewLoadedCopyWith<$Res> {
  _$BillReviewLoadedCopyWithImpl(this._self, this._then);

  final BillReviewLoaded _self;
  final $Res Function(BillReviewLoaded) _then;

/// Create a copy of BillReviewScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billerId = null,Object? categoryId = null,Object? billerName = null,Object? account = null,Object? customerName = freezed,Object? dueInDays = freezed,Object? amountPaise = null,Object? paying = null,Object? canPay = null,}) {
  return _then(BillReviewLoaded(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,dueInDays: freezed == dueInDays ? _self.dueInDays : dueInDays // ignore: cast_nullable_to_non_nullable
as int?,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,paying: null == paying ? _self.paying : paying // ignore: cast_nullable_to_non_nullable
as bool,canPay: null == canPay ? _self.canPay : canPay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
