// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Auth {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Auth);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Auth()';
}


}

/// @nodoc
class $AuthCopyWith<$Res>  {
$AuthCopyWith(Auth _, $Res Function(Auth) __);
}


/// Adds pattern-matching-related methods to [Auth].
extension AuthPatterns on Auth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Unauthenticated value)?  unauthenticated,TResult Function( SendingOtp value)?  sendingOtp,TResult Function( OtpSent value)?  otpSent,TResult Function( Verifying value)?  verifying,TResult Function( Authenticated value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case SendingOtp() when sendingOtp != null:
return sendingOtp(_that);case OtpSent() when otpSent != null:
return otpSent(_that);case Verifying() when verifying != null:
return verifying(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Unauthenticated value)  unauthenticated,required TResult Function( SendingOtp value)  sendingOtp,required TResult Function( OtpSent value)  otpSent,required TResult Function( Verifying value)  verifying,required TResult Function( Authenticated value)  authenticated,}){
final _that = this;
switch (_that) {
case Unauthenticated():
return unauthenticated(_that);case SendingOtp():
return sendingOtp(_that);case OtpSent():
return otpSent(_that);case Verifying():
return verifying(_that);case Authenticated():
return authenticated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Unauthenticated value)?  unauthenticated,TResult? Function( SendingOtp value)?  sendingOtp,TResult? Function( OtpSent value)?  otpSent,TResult? Function( Verifying value)?  verifying,TResult? Function( Authenticated value)?  authenticated,}){
final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case SendingOtp() when sendingOtp != null:
return sendingOtp(_that);case OtpSent() when otpSent != null:
return otpSent(_that);case Verifying() when verifying != null:
return verifying(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unauthenticated,TResult Function( String phone)?  sendingOtp,TResult Function( String phone)?  otpSent,TResult Function( String phone)?  verifying,TResult Function( String userId,  String phone)?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated();case SendingOtp() when sendingOtp != null:
return sendingOtp(_that.phone);case OtpSent() when otpSent != null:
return otpSent(_that.phone);case Verifying() when verifying != null:
return verifying(_that.phone);case Authenticated() when authenticated != null:
return authenticated(_that.userId,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unauthenticated,required TResult Function( String phone)  sendingOtp,required TResult Function( String phone)  otpSent,required TResult Function( String phone)  verifying,required TResult Function( String userId,  String phone)  authenticated,}) {final _that = this;
switch (_that) {
case Unauthenticated():
return unauthenticated();case SendingOtp():
return sendingOtp(_that.phone);case OtpSent():
return otpSent(_that.phone);case Verifying():
return verifying(_that.phone);case Authenticated():
return authenticated(_that.userId,_that.phone);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unauthenticated,TResult? Function( String phone)?  sendingOtp,TResult? Function( String phone)?  otpSent,TResult? Function( String phone)?  verifying,TResult? Function( String userId,  String phone)?  authenticated,}) {final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated();case SendingOtp() when sendingOtp != null:
return sendingOtp(_that.phone);case OtpSent() when otpSent != null:
return otpSent(_that.phone);case Verifying() when verifying != null:
return verifying(_that.phone);case Authenticated() when authenticated != null:
return authenticated(_that.userId,_that.phone);case _:
  return null;

}
}

}

/// @nodoc


class Unauthenticated extends Auth {
  const Unauthenticated(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Auth.unauthenticated()';
}


}




/// @nodoc


class SendingOtp extends Auth {
  const SendingOtp(this.phone): super._();
  

 final  String phone;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendingOtpCopyWith<SendingOtp> get copyWith => _$SendingOtpCopyWithImpl<SendingOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendingOtp&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'Auth.sendingOtp(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $SendingOtpCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $SendingOtpCopyWith(SendingOtp value, $Res Function(SendingOtp) _then) = _$SendingOtpCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$SendingOtpCopyWithImpl<$Res>
    implements $SendingOtpCopyWith<$Res> {
  _$SendingOtpCopyWithImpl(this._self, this._then);

  final SendingOtp _self;
  final $Res Function(SendingOtp) _then;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(SendingOtp(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OtpSent extends Auth {
  const OtpSent(this.phone): super._();
  

 final  String phone;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpSentCopyWith<OtpSent> get copyWith => _$OtpSentCopyWithImpl<OtpSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpSent&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'Auth.otpSent(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $OtpSentCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $OtpSentCopyWith(OtpSent value, $Res Function(OtpSent) _then) = _$OtpSentCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$OtpSentCopyWithImpl<$Res>
    implements $OtpSentCopyWith<$Res> {
  _$OtpSentCopyWithImpl(this._self, this._then);

  final OtpSent _self;
  final $Res Function(OtpSent) _then;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(OtpSent(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Verifying extends Auth {
  const Verifying(this.phone): super._();
  

 final  String phone;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyingCopyWith<Verifying> get copyWith => _$VerifyingCopyWithImpl<Verifying>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Verifying&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'Auth.verifying(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $VerifyingCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $VerifyingCopyWith(Verifying value, $Res Function(Verifying) _then) = _$VerifyingCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$VerifyingCopyWithImpl<$Res>
    implements $VerifyingCopyWith<$Res> {
  _$VerifyingCopyWithImpl(this._self, this._then);

  final Verifying _self;
  final $Res Function(Verifying) _then;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(Verifying(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Authenticated extends Auth {
  const Authenticated({required this.userId, required this.phone}): super._();
  

 final  String userId;
 final  String phone;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedCopyWith<Authenticated> get copyWith => _$AuthenticatedCopyWithImpl<Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,userId,phone);

@override
String toString() {
  return 'Auth.authenticated(userId: $userId, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $AuthenticatedCopyWith(Authenticated value, $Res Function(Authenticated) _then) = _$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 String userId, String phone
});




}
/// @nodoc
class _$AuthenticatedCopyWithImpl<$Res>
    implements $AuthenticatedCopyWith<$Res> {
  _$AuthenticatedCopyWithImpl(this._self, this._then);

  final Authenticated _self;
  final $Res Function(Authenticated) _then;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? phone = null,}) {
  return _then(Authenticated(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
