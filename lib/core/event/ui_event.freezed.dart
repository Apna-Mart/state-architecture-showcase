// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UiEvent()';
}


}

/// @nodoc
class $UiEventCopyWith<$Res>  {
$UiEventCopyWith(UiEvent _, $Res Function(UiEvent) __);
}


/// Adds pattern-matching-related methods to [UiEvent].
extension UiEventPatterns on UiEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaymentStarted value)?  paymentStarted,TResult Function( PaymentFailed value)?  paymentFailed,TResult Function( OtpRejected value)?  otpRejected,TResult Function( AuthFailed value)?  authFailed,TResult Function( StorageFailed value)?  storageFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaymentStarted() when paymentStarted != null:
return paymentStarted(_that);case PaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case OtpRejected() when otpRejected != null:
return otpRejected(_that);case AuthFailed() when authFailed != null:
return authFailed(_that);case StorageFailed() when storageFailed != null:
return storageFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaymentStarted value)  paymentStarted,required TResult Function( PaymentFailed value)  paymentFailed,required TResult Function( OtpRejected value)  otpRejected,required TResult Function( AuthFailed value)  authFailed,required TResult Function( StorageFailed value)  storageFailed,}){
final _that = this;
switch (_that) {
case PaymentStarted():
return paymentStarted(_that);case PaymentFailed():
return paymentFailed(_that);case OtpRejected():
return otpRejected(_that);case AuthFailed():
return authFailed(_that);case StorageFailed():
return storageFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaymentStarted value)?  paymentStarted,TResult? Function( PaymentFailed value)?  paymentFailed,TResult? Function( OtpRejected value)?  otpRejected,TResult? Function( AuthFailed value)?  authFailed,TResult? Function( StorageFailed value)?  storageFailed,}){
final _that = this;
switch (_that) {
case PaymentStarted() when paymentStarted != null:
return paymentStarted(_that);case PaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case OtpRejected() when otpRejected != null:
return otpRejected(_that);case AuthFailed() when authFailed != null:
return authFailed(_that);case StorageFailed() when storageFailed != null:
return storageFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String paymentId)?  paymentStarted,TResult Function( String paymentId)?  paymentFailed,TResult Function()?  otpRejected,TResult Function()?  authFailed,TResult Function()?  storageFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaymentStarted() when paymentStarted != null:
return paymentStarted(_that.paymentId);case PaymentFailed() when paymentFailed != null:
return paymentFailed(_that.paymentId);case OtpRejected() when otpRejected != null:
return otpRejected();case AuthFailed() when authFailed != null:
return authFailed();case StorageFailed() when storageFailed != null:
return storageFailed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String paymentId)  paymentStarted,required TResult Function( String paymentId)  paymentFailed,required TResult Function()  otpRejected,required TResult Function()  authFailed,required TResult Function()  storageFailed,}) {final _that = this;
switch (_that) {
case PaymentStarted():
return paymentStarted(_that.paymentId);case PaymentFailed():
return paymentFailed(_that.paymentId);case OtpRejected():
return otpRejected();case AuthFailed():
return authFailed();case StorageFailed():
return storageFailed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String paymentId)?  paymentStarted,TResult? Function( String paymentId)?  paymentFailed,TResult? Function()?  otpRejected,TResult? Function()?  authFailed,TResult? Function()?  storageFailed,}) {final _that = this;
switch (_that) {
case PaymentStarted() when paymentStarted != null:
return paymentStarted(_that.paymentId);case PaymentFailed() when paymentFailed != null:
return paymentFailed(_that.paymentId);case OtpRejected() when otpRejected != null:
return otpRejected();case AuthFailed() when authFailed != null:
return authFailed();case StorageFailed() when storageFailed != null:
return storageFailed();case _:
  return null;

}
}

}

/// @nodoc


class PaymentStarted implements UiEvent {
  const PaymentStarted(this.paymentId);
  

 final  String paymentId;

/// Create a copy of UiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStartedCopyWith<PaymentStarted> get copyWith => _$PaymentStartedCopyWithImpl<PaymentStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStarted&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId);

@override
String toString() {
  return 'UiEvent.paymentStarted(paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class $PaymentStartedCopyWith<$Res> implements $UiEventCopyWith<$Res> {
  factory $PaymentStartedCopyWith(PaymentStarted value, $Res Function(PaymentStarted) _then) = _$PaymentStartedCopyWithImpl;
@useResult
$Res call({
 String paymentId
});




}
/// @nodoc
class _$PaymentStartedCopyWithImpl<$Res>
    implements $PaymentStartedCopyWith<$Res> {
  _$PaymentStartedCopyWithImpl(this._self, this._then);

  final PaymentStarted _self;
  final $Res Function(PaymentStarted) _then;

/// Create a copy of UiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,}) {
  return _then(PaymentStarted(
null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PaymentFailed implements UiEvent {
  const PaymentFailed(this.paymentId);
  

 final  String paymentId;

/// Create a copy of UiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentFailedCopyWith<PaymentFailed> get copyWith => _$PaymentFailedCopyWithImpl<PaymentFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentFailed&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId);

@override
String toString() {
  return 'UiEvent.paymentFailed(paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class $PaymentFailedCopyWith<$Res> implements $UiEventCopyWith<$Res> {
  factory $PaymentFailedCopyWith(PaymentFailed value, $Res Function(PaymentFailed) _then) = _$PaymentFailedCopyWithImpl;
@useResult
$Res call({
 String paymentId
});




}
/// @nodoc
class _$PaymentFailedCopyWithImpl<$Res>
    implements $PaymentFailedCopyWith<$Res> {
  _$PaymentFailedCopyWithImpl(this._self, this._then);

  final PaymentFailed _self;
  final $Res Function(PaymentFailed) _then;

/// Create a copy of UiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,}) {
  return _then(PaymentFailed(
null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OtpRejected implements UiEvent {
  const OtpRejected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRejected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UiEvent.otpRejected()';
}


}




/// @nodoc


class AuthFailed implements UiEvent {
  const AuthFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UiEvent.authFailed()';
}


}




/// @nodoc


class StorageFailed implements UiEvent {
  const StorageFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UiEvent.storageFailed()';
}


}




// dart format on
