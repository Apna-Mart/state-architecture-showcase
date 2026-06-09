// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReceiptScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReceiptScreenData()';
}


}

/// @nodoc
class $ReceiptScreenDataCopyWith<$Res>  {
$ReceiptScreenDataCopyWith(ReceiptScreenData _, $Res Function(ReceiptScreenData) __);
}


/// Adds pattern-matching-related methods to [ReceiptScreenData].
extension ReceiptScreenDataPatterns on ReceiptScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReceiptLoading value)?  loading,TResult Function( ReceiptNotFound value)?  notFound,TResult Function( ReceiptProcessing value)?  processing,TResult Function( ReceiptSuccess value)?  success,TResult Function( ReceiptFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReceiptLoading() when loading != null:
return loading(_that);case ReceiptNotFound() when notFound != null:
return notFound(_that);case ReceiptProcessing() when processing != null:
return processing(_that);case ReceiptSuccess() when success != null:
return success(_that);case ReceiptFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReceiptLoading value)  loading,required TResult Function( ReceiptNotFound value)  notFound,required TResult Function( ReceiptProcessing value)  processing,required TResult Function( ReceiptSuccess value)  success,required TResult Function( ReceiptFailed value)  failed,}){
final _that = this;
switch (_that) {
case ReceiptLoading():
return loading(_that);case ReceiptNotFound():
return notFound(_that);case ReceiptProcessing():
return processing(_that);case ReceiptSuccess():
return success(_that);case ReceiptFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReceiptLoading value)?  loading,TResult? Function( ReceiptNotFound value)?  notFound,TResult? Function( ReceiptProcessing value)?  processing,TResult? Function( ReceiptSuccess value)?  success,TResult? Function( ReceiptFailed value)?  failed,}){
final _that = this;
switch (_that) {
case ReceiptLoading() when loading != null:
return loading(_that);case ReceiptNotFound() when notFound != null:
return notFound(_that);case ReceiptProcessing() when processing != null:
return processing(_that);case ReceiptSuccess() when success != null:
return success(_that);case ReceiptFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  notFound,TResult Function( String billerName,  int amountPaise)?  processing,TResult Function( String paymentId,  String billerId,  String billerName,  String account,  int amountPaise,  DateTime paidAt,  bool canSaveBiller)?  success,TResult Function( String billerId,  String billerName,  String categoryId,  String account,  int amountPaise)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReceiptLoading() when loading != null:
return loading();case ReceiptNotFound() when notFound != null:
return notFound();case ReceiptProcessing() when processing != null:
return processing(_that.billerName,_that.amountPaise);case ReceiptSuccess() when success != null:
return success(_that.paymentId,_that.billerId,_that.billerName,_that.account,_that.amountPaise,_that.paidAt,_that.canSaveBiller);case ReceiptFailed() when failed != null:
return failed(_that.billerId,_that.billerName,_that.categoryId,_that.account,_that.amountPaise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  notFound,required TResult Function( String billerName,  int amountPaise)  processing,required TResult Function( String paymentId,  String billerId,  String billerName,  String account,  int amountPaise,  DateTime paidAt,  bool canSaveBiller)  success,required TResult Function( String billerId,  String billerName,  String categoryId,  String account,  int amountPaise)  failed,}) {final _that = this;
switch (_that) {
case ReceiptLoading():
return loading();case ReceiptNotFound():
return notFound();case ReceiptProcessing():
return processing(_that.billerName,_that.amountPaise);case ReceiptSuccess():
return success(_that.paymentId,_that.billerId,_that.billerName,_that.account,_that.amountPaise,_that.paidAt,_that.canSaveBiller);case ReceiptFailed():
return failed(_that.billerId,_that.billerName,_that.categoryId,_that.account,_that.amountPaise);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  notFound,TResult? Function( String billerName,  int amountPaise)?  processing,TResult? Function( String paymentId,  String billerId,  String billerName,  String account,  int amountPaise,  DateTime paidAt,  bool canSaveBiller)?  success,TResult? Function( String billerId,  String billerName,  String categoryId,  String account,  int amountPaise)?  failed,}) {final _that = this;
switch (_that) {
case ReceiptLoading() when loading != null:
return loading();case ReceiptNotFound() when notFound != null:
return notFound();case ReceiptProcessing() when processing != null:
return processing(_that.billerName,_that.amountPaise);case ReceiptSuccess() when success != null:
return success(_that.paymentId,_that.billerId,_that.billerName,_that.account,_that.amountPaise,_that.paidAt,_that.canSaveBiller);case ReceiptFailed() when failed != null:
return failed(_that.billerId,_that.billerName,_that.categoryId,_that.account,_that.amountPaise);case _:
  return null;

}
}

}

/// @nodoc


class ReceiptLoading implements ReceiptScreenData {
  const ReceiptLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReceiptScreenData.loading()';
}


}




/// @nodoc


class ReceiptNotFound implements ReceiptScreenData {
  const ReceiptNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReceiptScreenData.notFound()';
}


}




/// @nodoc


class ReceiptProcessing implements ReceiptScreenData {
  const ReceiptProcessing({required this.billerName, required this.amountPaise});
  

 final  String billerName;
 final  int amountPaise;

/// Create a copy of ReceiptScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptProcessingCopyWith<ReceiptProcessing> get copyWith => _$ReceiptProcessingCopyWithImpl<ReceiptProcessing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptProcessing&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise));
}


@override
int get hashCode => Object.hash(runtimeType,billerName,amountPaise);

@override
String toString() {
  return 'ReceiptScreenData.processing(billerName: $billerName, amountPaise: $amountPaise)';
}


}

/// @nodoc
abstract mixin class $ReceiptProcessingCopyWith<$Res> implements $ReceiptScreenDataCopyWith<$Res> {
  factory $ReceiptProcessingCopyWith(ReceiptProcessing value, $Res Function(ReceiptProcessing) _then) = _$ReceiptProcessingCopyWithImpl;
@useResult
$Res call({
 String billerName, int amountPaise
});




}
/// @nodoc
class _$ReceiptProcessingCopyWithImpl<$Res>
    implements $ReceiptProcessingCopyWith<$Res> {
  _$ReceiptProcessingCopyWithImpl(this._self, this._then);

  final ReceiptProcessing _self;
  final $Res Function(ReceiptProcessing) _then;

/// Create a copy of ReceiptScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billerName = null,Object? amountPaise = null,}) {
  return _then(ReceiptProcessing(
billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ReceiptSuccess implements ReceiptScreenData {
  const ReceiptSuccess({required this.paymentId, required this.billerId, required this.billerName, required this.account, required this.amountPaise, required this.paidAt, required this.canSaveBiller});
  

 final  String paymentId;
 final  String billerId;
 final  String billerName;
 final  String account;
 final  int amountPaise;
 final  DateTime paidAt;
 final  bool canSaveBiller;

/// Create a copy of ReceiptScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptSuccessCopyWith<ReceiptSuccess> get copyWith => _$ReceiptSuccessCopyWithImpl<ReceiptSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptSuccess&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.account, account) || other.account == account)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.canSaveBiller, canSaveBiller) || other.canSaveBiller == canSaveBiller));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId,billerId,billerName,account,amountPaise,paidAt,canSaveBiller);

@override
String toString() {
  return 'ReceiptScreenData.success(paymentId: $paymentId, billerId: $billerId, billerName: $billerName, account: $account, amountPaise: $amountPaise, paidAt: $paidAt, canSaveBiller: $canSaveBiller)';
}


}

/// @nodoc
abstract mixin class $ReceiptSuccessCopyWith<$Res> implements $ReceiptScreenDataCopyWith<$Res> {
  factory $ReceiptSuccessCopyWith(ReceiptSuccess value, $Res Function(ReceiptSuccess) _then) = _$ReceiptSuccessCopyWithImpl;
@useResult
$Res call({
 String paymentId, String billerId, String billerName, String account, int amountPaise, DateTime paidAt, bool canSaveBiller
});




}
/// @nodoc
class _$ReceiptSuccessCopyWithImpl<$Res>
    implements $ReceiptSuccessCopyWith<$Res> {
  _$ReceiptSuccessCopyWithImpl(this._self, this._then);

  final ReceiptSuccess _self;
  final $Res Function(ReceiptSuccess) _then;

/// Create a copy of ReceiptScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? billerId = null,Object? billerName = null,Object? account = null,Object? amountPaise = null,Object? paidAt = null,Object? canSaveBiller = null,}) {
  return _then(ReceiptSuccess(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,canSaveBiller: null == canSaveBiller ? _self.canSaveBiller : canSaveBiller // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ReceiptFailed implements ReceiptScreenData {
  const ReceiptFailed({required this.billerId, required this.billerName, required this.categoryId, required this.account, required this.amountPaise});
  

 final  String billerId;
 final  String billerName;
 final  String categoryId;
 final  String account;
 final  int amountPaise;

/// Create a copy of ReceiptScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptFailedCopyWith<ReceiptFailed> get copyWith => _$ReceiptFailedCopyWithImpl<ReceiptFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptFailed&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.account, account) || other.account == account)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,billerName,categoryId,account,amountPaise);

@override
String toString() {
  return 'ReceiptScreenData.failed(billerId: $billerId, billerName: $billerName, categoryId: $categoryId, account: $account, amountPaise: $amountPaise)';
}


}

/// @nodoc
abstract mixin class $ReceiptFailedCopyWith<$Res> implements $ReceiptScreenDataCopyWith<$Res> {
  factory $ReceiptFailedCopyWith(ReceiptFailed value, $Res Function(ReceiptFailed) _then) = _$ReceiptFailedCopyWithImpl;
@useResult
$Res call({
 String billerId, String billerName, String categoryId, String account, int amountPaise
});




}
/// @nodoc
class _$ReceiptFailedCopyWithImpl<$Res>
    implements $ReceiptFailedCopyWith<$Res> {
  _$ReceiptFailedCopyWithImpl(this._self, this._then);

  final ReceiptFailed _self;
  final $Res Function(ReceiptFailed) _then;

/// Create a copy of ReceiptScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billerId = null,Object? billerName = null,Object? categoryId = null,Object? account = null,Object? amountPaise = null,}) {
  return _then(ReceiptFailed(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
