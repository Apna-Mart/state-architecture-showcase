// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginScreenData()';
}


}

/// @nodoc
class $LoginScreenDataCopyWith<$Res>  {
$LoginScreenDataCopyWith(LoginScreenData _, $Res Function(LoginScreenData) __);
}


/// Adds pattern-matching-related methods to [LoginScreenData].
extension LoginScreenDataPatterns on LoginScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginPhoneEntry value)?  phoneEntry,TResult Function( LoginOtpEntry value)?  otpEntry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginPhoneEntry() when phoneEntry != null:
return phoneEntry(_that);case LoginOtpEntry() when otpEntry != null:
return otpEntry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginPhoneEntry value)  phoneEntry,required TResult Function( LoginOtpEntry value)  otpEntry,}){
final _that = this;
switch (_that) {
case LoginPhoneEntry():
return phoneEntry(_that);case LoginOtpEntry():
return otpEntry(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginPhoneEntry value)?  phoneEntry,TResult? Function( LoginOtpEntry value)?  otpEntry,}){
final _that = this;
switch (_that) {
case LoginPhoneEntry() when phoneEntry != null:
return phoneEntry(_that);case LoginOtpEntry() when otpEntry != null:
return otpEntry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool canSend,  bool sending)?  phoneEntry,TResult Function( String phone,  bool canVerify,  bool verifying)?  otpEntry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginPhoneEntry() when phoneEntry != null:
return phoneEntry(_that.canSend,_that.sending);case LoginOtpEntry() when otpEntry != null:
return otpEntry(_that.phone,_that.canVerify,_that.verifying);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool canSend,  bool sending)  phoneEntry,required TResult Function( String phone,  bool canVerify,  bool verifying)  otpEntry,}) {final _that = this;
switch (_that) {
case LoginPhoneEntry():
return phoneEntry(_that.canSend,_that.sending);case LoginOtpEntry():
return otpEntry(_that.phone,_that.canVerify,_that.verifying);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool canSend,  bool sending)?  phoneEntry,TResult? Function( String phone,  bool canVerify,  bool verifying)?  otpEntry,}) {final _that = this;
switch (_that) {
case LoginPhoneEntry() when phoneEntry != null:
return phoneEntry(_that.canSend,_that.sending);case LoginOtpEntry() when otpEntry != null:
return otpEntry(_that.phone,_that.canVerify,_that.verifying);case _:
  return null;

}
}

}

/// @nodoc


class LoginPhoneEntry implements LoginScreenData {
  const LoginPhoneEntry({required this.canSend, required this.sending});
  

 final  bool canSend;
 final  bool sending;

/// Create a copy of LoginScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginPhoneEntryCopyWith<LoginPhoneEntry> get copyWith => _$LoginPhoneEntryCopyWithImpl<LoginPhoneEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginPhoneEntry&&(identical(other.canSend, canSend) || other.canSend == canSend)&&(identical(other.sending, sending) || other.sending == sending));
}


@override
int get hashCode => Object.hash(runtimeType,canSend,sending);

@override
String toString() {
  return 'LoginScreenData.phoneEntry(canSend: $canSend, sending: $sending)';
}


}

/// @nodoc
abstract mixin class $LoginPhoneEntryCopyWith<$Res> implements $LoginScreenDataCopyWith<$Res> {
  factory $LoginPhoneEntryCopyWith(LoginPhoneEntry value, $Res Function(LoginPhoneEntry) _then) = _$LoginPhoneEntryCopyWithImpl;
@useResult
$Res call({
 bool canSend, bool sending
});




}
/// @nodoc
class _$LoginPhoneEntryCopyWithImpl<$Res>
    implements $LoginPhoneEntryCopyWith<$Res> {
  _$LoginPhoneEntryCopyWithImpl(this._self, this._then);

  final LoginPhoneEntry _self;
  final $Res Function(LoginPhoneEntry) _then;

/// Create a copy of LoginScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? canSend = null,Object? sending = null,}) {
  return _then(LoginPhoneEntry(
canSend: null == canSend ? _self.canSend : canSend // ignore: cast_nullable_to_non_nullable
as bool,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LoginOtpEntry implements LoginScreenData {
  const LoginOtpEntry({required this.phone, required this.canVerify, required this.verifying});
  

 final  String phone;
 final  bool canVerify;
 final  bool verifying;

/// Create a copy of LoginScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginOtpEntryCopyWith<LoginOtpEntry> get copyWith => _$LoginOtpEntryCopyWithImpl<LoginOtpEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginOtpEntry&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.canVerify, canVerify) || other.canVerify == canVerify)&&(identical(other.verifying, verifying) || other.verifying == verifying));
}


@override
int get hashCode => Object.hash(runtimeType,phone,canVerify,verifying);

@override
String toString() {
  return 'LoginScreenData.otpEntry(phone: $phone, canVerify: $canVerify, verifying: $verifying)';
}


}

/// @nodoc
abstract mixin class $LoginOtpEntryCopyWith<$Res> implements $LoginScreenDataCopyWith<$Res> {
  factory $LoginOtpEntryCopyWith(LoginOtpEntry value, $Res Function(LoginOtpEntry) _then) = _$LoginOtpEntryCopyWithImpl;
@useResult
$Res call({
 String phone, bool canVerify, bool verifying
});




}
/// @nodoc
class _$LoginOtpEntryCopyWithImpl<$Res>
    implements $LoginOtpEntryCopyWith<$Res> {
  _$LoginOtpEntryCopyWithImpl(this._self, this._then);

  final LoginOtpEntry _self;
  final $Res Function(LoginOtpEntry) _then;

/// Create a copy of LoginScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? canVerify = null,Object? verifying = null,}) {
  return _then(LoginOtpEntry(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,canVerify: null == canVerify ? _self.canVerify : canVerify // ignore: cast_nullable_to_non_nullable
as bool,verifying: null == verifying ? _self.verifying : verifying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
