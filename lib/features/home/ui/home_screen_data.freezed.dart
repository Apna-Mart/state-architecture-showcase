// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryItemData {

 String get id; String get name; IconData get icon;
/// Create a copy of CategoryItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryItemDataCopyWith<CategoryItemData> get copyWith => _$CategoryItemDataCopyWithImpl<CategoryItemData>(this as CategoryItemData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'CategoryItemData(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $CategoryItemDataCopyWith<$Res>  {
  factory $CategoryItemDataCopyWith(CategoryItemData value, $Res Function(CategoryItemData) _then) = _$CategoryItemDataCopyWithImpl;
@useResult
$Res call({
 String id, String name, IconData icon
});




}
/// @nodoc
class _$CategoryItemDataCopyWithImpl<$Res>
    implements $CategoryItemDataCopyWith<$Res> {
  _$CategoryItemDataCopyWithImpl(this._self, this._then);

  final CategoryItemData _self;
  final $Res Function(CategoryItemData) _then;

/// Create a copy of CategoryItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryItemData].
extension CategoryItemDataPatterns on CategoryItemData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryItemData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryItemData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryItemData value)  $default,){
final _that = this;
switch (_that) {
case _CategoryItemData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryItemData value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryItemData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  IconData icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryItemData() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  IconData icon)  $default,) {final _that = this;
switch (_that) {
case _CategoryItemData():
return $default(_that.id,_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  IconData icon)?  $default,) {final _that = this;
switch (_that) {
case _CategoryItemData() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryItemData implements CategoryItemData {
  const _CategoryItemData({required this.id, required this.name, required this.icon});
  

@override final  String id;
@override final  String name;
@override final  IconData icon;

/// Create a copy of CategoryItemData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryItemDataCopyWith<_CategoryItemData> get copyWith => __$CategoryItemDataCopyWithImpl<_CategoryItemData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryItemData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'CategoryItemData(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$CategoryItemDataCopyWith<$Res> implements $CategoryItemDataCopyWith<$Res> {
  factory _$CategoryItemDataCopyWith(_CategoryItemData value, $Res Function(_CategoryItemData) _then) = __$CategoryItemDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, IconData icon
});




}
/// @nodoc
class __$CategoryItemDataCopyWithImpl<$Res>
    implements _$CategoryItemDataCopyWith<$Res> {
  __$CategoryItemDataCopyWithImpl(this._self, this._then);

  final _CategoryItemData _self;
  final $Res Function(_CategoryItemData) _then;

/// Create a copy of CategoryItemData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = null,}) {
  return _then(_CategoryItemData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,
  ));
}


}

/// @nodoc
mixin _$DueBillItemData {

 String get billerId; String get account; String get billerName; int get amountPaise; int get dueInDays;
/// Create a copy of DueBillItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DueBillItemDataCopyWith<DueBillItemData> get copyWith => _$DueBillItemDataCopyWithImpl<DueBillItemData>(this as DueBillItemData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DueBillItemData&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.dueInDays, dueInDays) || other.dueInDays == dueInDays));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,billerName,amountPaise,dueInDays);

@override
String toString() {
  return 'DueBillItemData(billerId: $billerId, account: $account, billerName: $billerName, amountPaise: $amountPaise, dueInDays: $dueInDays)';
}


}

/// @nodoc
abstract mixin class $DueBillItemDataCopyWith<$Res>  {
  factory $DueBillItemDataCopyWith(DueBillItemData value, $Res Function(DueBillItemData) _then) = _$DueBillItemDataCopyWithImpl;
@useResult
$Res call({
 String billerId, String account, String billerName, int amountPaise, int dueInDays
});




}
/// @nodoc
class _$DueBillItemDataCopyWithImpl<$Res>
    implements $DueBillItemDataCopyWith<$Res> {
  _$DueBillItemDataCopyWithImpl(this._self, this._then);

  final DueBillItemData _self;
  final $Res Function(DueBillItemData) _then;

/// Create a copy of DueBillItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billerId = null,Object? account = null,Object? billerName = null,Object? amountPaise = null,Object? dueInDays = null,}) {
  return _then(_self.copyWith(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,dueInDays: null == dueInDays ? _self.dueInDays : dueInDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DueBillItemData].
extension DueBillItemDataPatterns on DueBillItemData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DueBillItemData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DueBillItemData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DueBillItemData value)  $default,){
final _that = this;
switch (_that) {
case _DueBillItemData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DueBillItemData value)?  $default,){
final _that = this;
switch (_that) {
case _DueBillItemData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billerId,  String account,  String billerName,  int amountPaise,  int dueInDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DueBillItemData() when $default != null:
return $default(_that.billerId,_that.account,_that.billerName,_that.amountPaise,_that.dueInDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billerId,  String account,  String billerName,  int amountPaise,  int dueInDays)  $default,) {final _that = this;
switch (_that) {
case _DueBillItemData():
return $default(_that.billerId,_that.account,_that.billerName,_that.amountPaise,_that.dueInDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billerId,  String account,  String billerName,  int amountPaise,  int dueInDays)?  $default,) {final _that = this;
switch (_that) {
case _DueBillItemData() when $default != null:
return $default(_that.billerId,_that.account,_that.billerName,_that.amountPaise,_that.dueInDays);case _:
  return null;

}
}

}

/// @nodoc


class _DueBillItemData implements DueBillItemData {
  const _DueBillItemData({required this.billerId, required this.account, required this.billerName, required this.amountPaise, required this.dueInDays});
  

@override final  String billerId;
@override final  String account;
@override final  String billerName;
@override final  int amountPaise;
@override final  int dueInDays;

/// Create a copy of DueBillItemData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DueBillItemDataCopyWith<_DueBillItemData> get copyWith => __$DueBillItemDataCopyWithImpl<_DueBillItemData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DueBillItemData&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.dueInDays, dueInDays) || other.dueInDays == dueInDays));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,billerName,amountPaise,dueInDays);

@override
String toString() {
  return 'DueBillItemData(billerId: $billerId, account: $account, billerName: $billerName, amountPaise: $amountPaise, dueInDays: $dueInDays)';
}


}

/// @nodoc
abstract mixin class _$DueBillItemDataCopyWith<$Res> implements $DueBillItemDataCopyWith<$Res> {
  factory _$DueBillItemDataCopyWith(_DueBillItemData value, $Res Function(_DueBillItemData) _then) = __$DueBillItemDataCopyWithImpl;
@override @useResult
$Res call({
 String billerId, String account, String billerName, int amountPaise, int dueInDays
});




}
/// @nodoc
class __$DueBillItemDataCopyWithImpl<$Res>
    implements _$DueBillItemDataCopyWith<$Res> {
  __$DueBillItemDataCopyWithImpl(this._self, this._then);

  final _DueBillItemData _self;
  final $Res Function(_DueBillItemData) _then;

/// Create a copy of DueBillItemData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billerId = null,Object? account = null,Object? billerName = null,Object? amountPaise = null,Object? dueInDays = null,}) {
  return _then(_DueBillItemData(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,dueInDays: null == dueInDays ? _self.dueInDays : dueInDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SavedBillerItemData {

 String get billerId; String get account; String get nickname; String get billerName; bool get openAmount;
/// Create a copy of SavedBillerItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedBillerItemDataCopyWith<SavedBillerItemData> get copyWith => _$SavedBillerItemDataCopyWithImpl<SavedBillerItemData>(this as SavedBillerItemData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedBillerItemData&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.openAmount, openAmount) || other.openAmount == openAmount));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,nickname,billerName,openAmount);

@override
String toString() {
  return 'SavedBillerItemData(billerId: $billerId, account: $account, nickname: $nickname, billerName: $billerName, openAmount: $openAmount)';
}


}

/// @nodoc
abstract mixin class $SavedBillerItemDataCopyWith<$Res>  {
  factory $SavedBillerItemDataCopyWith(SavedBillerItemData value, $Res Function(SavedBillerItemData) _then) = _$SavedBillerItemDataCopyWithImpl;
@useResult
$Res call({
 String billerId, String account, String nickname, String billerName, bool openAmount
});




}
/// @nodoc
class _$SavedBillerItemDataCopyWithImpl<$Res>
    implements $SavedBillerItemDataCopyWith<$Res> {
  _$SavedBillerItemDataCopyWithImpl(this._self, this._then);

  final SavedBillerItemData _self;
  final $Res Function(SavedBillerItemData) _then;

/// Create a copy of SavedBillerItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billerId = null,Object? account = null,Object? nickname = null,Object? billerName = null,Object? openAmount = null,}) {
  return _then(_self.copyWith(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,openAmount: null == openAmount ? _self.openAmount : openAmount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedBillerItemData].
extension SavedBillerItemDataPatterns on SavedBillerItemData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedBillerItemData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedBillerItemData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedBillerItemData value)  $default,){
final _that = this;
switch (_that) {
case _SavedBillerItemData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedBillerItemData value)?  $default,){
final _that = this;
switch (_that) {
case _SavedBillerItemData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billerId,  String account,  String nickname,  String billerName,  bool openAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedBillerItemData() when $default != null:
return $default(_that.billerId,_that.account,_that.nickname,_that.billerName,_that.openAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billerId,  String account,  String nickname,  String billerName,  bool openAmount)  $default,) {final _that = this;
switch (_that) {
case _SavedBillerItemData():
return $default(_that.billerId,_that.account,_that.nickname,_that.billerName,_that.openAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billerId,  String account,  String nickname,  String billerName,  bool openAmount)?  $default,) {final _that = this;
switch (_that) {
case _SavedBillerItemData() when $default != null:
return $default(_that.billerId,_that.account,_that.nickname,_that.billerName,_that.openAmount);case _:
  return null;

}
}

}

/// @nodoc


class _SavedBillerItemData implements SavedBillerItemData {
  const _SavedBillerItemData({required this.billerId, required this.account, required this.nickname, required this.billerName, required this.openAmount});
  

@override final  String billerId;
@override final  String account;
@override final  String nickname;
@override final  String billerName;
@override final  bool openAmount;

/// Create a copy of SavedBillerItemData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedBillerItemDataCopyWith<_SavedBillerItemData> get copyWith => __$SavedBillerItemDataCopyWithImpl<_SavedBillerItemData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedBillerItemData&&(identical(other.billerId, billerId) || other.billerId == billerId)&&(identical(other.account, account) || other.account == account)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.billerName, billerName) || other.billerName == billerName)&&(identical(other.openAmount, openAmount) || other.openAmount == openAmount));
}


@override
int get hashCode => Object.hash(runtimeType,billerId,account,nickname,billerName,openAmount);

@override
String toString() {
  return 'SavedBillerItemData(billerId: $billerId, account: $account, nickname: $nickname, billerName: $billerName, openAmount: $openAmount)';
}


}

/// @nodoc
abstract mixin class _$SavedBillerItemDataCopyWith<$Res> implements $SavedBillerItemDataCopyWith<$Res> {
  factory _$SavedBillerItemDataCopyWith(_SavedBillerItemData value, $Res Function(_SavedBillerItemData) _then) = __$SavedBillerItemDataCopyWithImpl;
@override @useResult
$Res call({
 String billerId, String account, String nickname, String billerName, bool openAmount
});




}
/// @nodoc
class __$SavedBillerItemDataCopyWithImpl<$Res>
    implements _$SavedBillerItemDataCopyWith<$Res> {
  __$SavedBillerItemDataCopyWithImpl(this._self, this._then);

  final _SavedBillerItemData _self;
  final $Res Function(_SavedBillerItemData) _then;

/// Create a copy of SavedBillerItemData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billerId = null,Object? account = null,Object? nickname = null,Object? billerName = null,Object? openAmount = null,}) {
  return _then(_SavedBillerItemData(
billerId: null == billerId ? _self.billerId : billerId // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,billerName: null == billerName ? _self.billerName : billerName // ignore: cast_nullable_to_non_nullable
as String,openAmount: null == openAmount ? _self.openAmount : openAmount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$HomeRemindersData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRemindersData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeRemindersData()';
}


}

/// @nodoc
class $HomeRemindersDataCopyWith<$Res>  {
$HomeRemindersDataCopyWith(HomeRemindersData _, $Res Function(HomeRemindersData) __);
}


/// Adds pattern-matching-related methods to [HomeRemindersData].
extension HomeRemindersDataPatterns on HomeRemindersData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeRemindersLoading value)?  loading,TResult Function( HomeRemindersLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeRemindersLoading() when loading != null:
return loading(_that);case HomeRemindersLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeRemindersLoading value)  loading,required TResult Function( HomeRemindersLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case HomeRemindersLoading():
return loading(_that);case HomeRemindersLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeRemindersLoading value)?  loading,TResult? Function( HomeRemindersLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case HomeRemindersLoading() when loading != null:
return loading(_that);case HomeRemindersLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<DueBillItemData> items)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeRemindersLoading() when loading != null:
return loading();case HomeRemindersLoaded() when loaded != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<DueBillItemData> items)  loaded,}) {final _that = this;
switch (_that) {
case HomeRemindersLoading():
return loading();case HomeRemindersLoaded():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<DueBillItemData> items)?  loaded,}) {final _that = this;
switch (_that) {
case HomeRemindersLoading() when loading != null:
return loading();case HomeRemindersLoaded() when loaded != null:
return loaded(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class HomeRemindersLoading implements HomeRemindersData {
  const HomeRemindersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRemindersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeRemindersData.loading()';
}


}




/// @nodoc


class HomeRemindersLoaded implements HomeRemindersData {
  const HomeRemindersLoaded(final  List<DueBillItemData> items): _items = items;
  

 final  List<DueBillItemData> _items;
 List<DueBillItemData> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HomeRemindersData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeRemindersLoadedCopyWith<HomeRemindersLoaded> get copyWith => _$HomeRemindersLoadedCopyWithImpl<HomeRemindersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRemindersLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HomeRemindersData.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $HomeRemindersLoadedCopyWith<$Res> implements $HomeRemindersDataCopyWith<$Res> {
  factory $HomeRemindersLoadedCopyWith(HomeRemindersLoaded value, $Res Function(HomeRemindersLoaded) _then) = _$HomeRemindersLoadedCopyWithImpl;
@useResult
$Res call({
 List<DueBillItemData> items
});




}
/// @nodoc
class _$HomeRemindersLoadedCopyWithImpl<$Res>
    implements $HomeRemindersLoadedCopyWith<$Res> {
  _$HomeRemindersLoadedCopyWithImpl(this._self, this._then);

  final HomeRemindersLoaded _self;
  final $Res Function(HomeRemindersLoaded) _then;

/// Create a copy of HomeRemindersData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(HomeRemindersLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DueBillItemData>,
  ));
}


}

/// @nodoc
mixin _$HomeSavedBillersData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSavedBillersData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeSavedBillersData()';
}


}

/// @nodoc
class $HomeSavedBillersDataCopyWith<$Res>  {
$HomeSavedBillersDataCopyWith(HomeSavedBillersData _, $Res Function(HomeSavedBillersData) __);
}


/// Adds pattern-matching-related methods to [HomeSavedBillersData].
extension HomeSavedBillersDataPatterns on HomeSavedBillersData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeSavedBillersLoading value)?  loading,TResult Function( HomeSavedBillersLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeSavedBillersLoading() when loading != null:
return loading(_that);case HomeSavedBillersLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeSavedBillersLoading value)  loading,required TResult Function( HomeSavedBillersLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case HomeSavedBillersLoading():
return loading(_that);case HomeSavedBillersLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeSavedBillersLoading value)?  loading,TResult? Function( HomeSavedBillersLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case HomeSavedBillersLoading() when loading != null:
return loading(_that);case HomeSavedBillersLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<SavedBillerItemData> items)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeSavedBillersLoading() when loading != null:
return loading();case HomeSavedBillersLoaded() when loaded != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<SavedBillerItemData> items)  loaded,}) {final _that = this;
switch (_that) {
case HomeSavedBillersLoading():
return loading();case HomeSavedBillersLoaded():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<SavedBillerItemData> items)?  loaded,}) {final _that = this;
switch (_that) {
case HomeSavedBillersLoading() when loading != null:
return loading();case HomeSavedBillersLoaded() when loaded != null:
return loaded(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class HomeSavedBillersLoading implements HomeSavedBillersData {
  const HomeSavedBillersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSavedBillersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeSavedBillersData.loading()';
}


}




/// @nodoc


class HomeSavedBillersLoaded implements HomeSavedBillersData {
  const HomeSavedBillersLoaded(final  List<SavedBillerItemData> items): _items = items;
  

 final  List<SavedBillerItemData> _items;
 List<SavedBillerItemData> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HomeSavedBillersData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSavedBillersLoadedCopyWith<HomeSavedBillersLoaded> get copyWith => _$HomeSavedBillersLoadedCopyWithImpl<HomeSavedBillersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSavedBillersLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HomeSavedBillersData.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $HomeSavedBillersLoadedCopyWith<$Res> implements $HomeSavedBillersDataCopyWith<$Res> {
  factory $HomeSavedBillersLoadedCopyWith(HomeSavedBillersLoaded value, $Res Function(HomeSavedBillersLoaded) _then) = _$HomeSavedBillersLoadedCopyWithImpl;
@useResult
$Res call({
 List<SavedBillerItemData> items
});




}
/// @nodoc
class _$HomeSavedBillersLoadedCopyWithImpl<$Res>
    implements $HomeSavedBillersLoadedCopyWith<$Res> {
  _$HomeSavedBillersLoadedCopyWithImpl(this._self, this._then);

  final HomeSavedBillersLoaded _self;
  final $Res Function(HomeSavedBillersLoaded) _then;

/// Create a copy of HomeSavedBillersData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(HomeSavedBillersLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SavedBillerItemData>,
  ));
}


}

/// @nodoc
mixin _$HomeCategoriesData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCategoriesData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeCategoriesData()';
}


}

/// @nodoc
class $HomeCategoriesDataCopyWith<$Res>  {
$HomeCategoriesDataCopyWith(HomeCategoriesData _, $Res Function(HomeCategoriesData) __);
}


/// Adds pattern-matching-related methods to [HomeCategoriesData].
extension HomeCategoriesDataPatterns on HomeCategoriesData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeCategoriesLoading value)?  loading,TResult Function( HomeCategoriesError value)?  error,TResult Function( HomeCategoriesLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeCategoriesLoading() when loading != null:
return loading(_that);case HomeCategoriesError() when error != null:
return error(_that);case HomeCategoriesLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeCategoriesLoading value)  loading,required TResult Function( HomeCategoriesError value)  error,required TResult Function( HomeCategoriesLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case HomeCategoriesLoading():
return loading(_that);case HomeCategoriesError():
return error(_that);case HomeCategoriesLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeCategoriesLoading value)?  loading,TResult? Function( HomeCategoriesError value)?  error,TResult? Function( HomeCategoriesLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case HomeCategoriesLoading() when loading != null:
return loading(_that);case HomeCategoriesError() when error != null:
return error(_that);case HomeCategoriesLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( List<CategoryItemData> items)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeCategoriesLoading() when loading != null:
return loading();case HomeCategoriesError() when error != null:
return error(_that.message);case HomeCategoriesLoaded() when loaded != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( List<CategoryItemData> items)  loaded,}) {final _that = this;
switch (_that) {
case HomeCategoriesLoading():
return loading();case HomeCategoriesError():
return error(_that.message);case HomeCategoriesLoaded():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( List<CategoryItemData> items)?  loaded,}) {final _that = this;
switch (_that) {
case HomeCategoriesLoading() when loading != null:
return loading();case HomeCategoriesError() when error != null:
return error(_that.message);case HomeCategoriesLoaded() when loaded != null:
return loaded(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class HomeCategoriesLoading implements HomeCategoriesData {
  const HomeCategoriesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCategoriesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeCategoriesData.loading()';
}


}




/// @nodoc


class HomeCategoriesError implements HomeCategoriesData {
  const HomeCategoriesError(this.message);
  

 final  String message;

/// Create a copy of HomeCategoriesData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeCategoriesErrorCopyWith<HomeCategoriesError> get copyWith => _$HomeCategoriesErrorCopyWithImpl<HomeCategoriesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCategoriesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeCategoriesData.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HomeCategoriesErrorCopyWith<$Res> implements $HomeCategoriesDataCopyWith<$Res> {
  factory $HomeCategoriesErrorCopyWith(HomeCategoriesError value, $Res Function(HomeCategoriesError) _then) = _$HomeCategoriesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HomeCategoriesErrorCopyWithImpl<$Res>
    implements $HomeCategoriesErrorCopyWith<$Res> {
  _$HomeCategoriesErrorCopyWithImpl(this._self, this._then);

  final HomeCategoriesError _self;
  final $Res Function(HomeCategoriesError) _then;

/// Create a copy of HomeCategoriesData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeCategoriesError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HomeCategoriesLoaded implements HomeCategoriesData {
  const HomeCategoriesLoaded(final  List<CategoryItemData> items): _items = items;
  

 final  List<CategoryItemData> _items;
 List<CategoryItemData> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HomeCategoriesData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeCategoriesLoadedCopyWith<HomeCategoriesLoaded> get copyWith => _$HomeCategoriesLoadedCopyWithImpl<HomeCategoriesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCategoriesLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HomeCategoriesData.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $HomeCategoriesLoadedCopyWith<$Res> implements $HomeCategoriesDataCopyWith<$Res> {
  factory $HomeCategoriesLoadedCopyWith(HomeCategoriesLoaded value, $Res Function(HomeCategoriesLoaded) _then) = _$HomeCategoriesLoadedCopyWithImpl;
@useResult
$Res call({
 List<CategoryItemData> items
});




}
/// @nodoc
class _$HomeCategoriesLoadedCopyWithImpl<$Res>
    implements $HomeCategoriesLoadedCopyWith<$Res> {
  _$HomeCategoriesLoadedCopyWithImpl(this._self, this._then);

  final HomeCategoriesLoaded _self;
  final $Res Function(HomeCategoriesLoaded) _then;

/// Create a copy of HomeCategoriesData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(HomeCategoriesLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CategoryItemData>,
  ));
}


}

/// @nodoc
mixin _$HomeScreenData {

 HomeRemindersData get reminders; HomeSavedBillersData get savedBillers; HomeCategoriesData get categories;
/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeScreenDataCopyWith<HomeScreenData> get copyWith => _$HomeScreenDataCopyWithImpl<HomeScreenData>(this as HomeScreenData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeScreenData&&(identical(other.reminders, reminders) || other.reminders == reminders)&&(identical(other.savedBillers, savedBillers) || other.savedBillers == savedBillers)&&(identical(other.categories, categories) || other.categories == categories));
}


@override
int get hashCode => Object.hash(runtimeType,reminders,savedBillers,categories);

@override
String toString() {
  return 'HomeScreenData(reminders: $reminders, savedBillers: $savedBillers, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $HomeScreenDataCopyWith<$Res>  {
  factory $HomeScreenDataCopyWith(HomeScreenData value, $Res Function(HomeScreenData) _then) = _$HomeScreenDataCopyWithImpl;
@useResult
$Res call({
 HomeRemindersData reminders, HomeSavedBillersData savedBillers, HomeCategoriesData categories
});


$HomeRemindersDataCopyWith<$Res> get reminders;$HomeSavedBillersDataCopyWith<$Res> get savedBillers;$HomeCategoriesDataCopyWith<$Res> get categories;

}
/// @nodoc
class _$HomeScreenDataCopyWithImpl<$Res>
    implements $HomeScreenDataCopyWith<$Res> {
  _$HomeScreenDataCopyWithImpl(this._self, this._then);

  final HomeScreenData _self;
  final $Res Function(HomeScreenData) _then;

/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reminders = null,Object? savedBillers = null,Object? categories = null,}) {
  return _then(_self.copyWith(
reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as HomeRemindersData,savedBillers: null == savedBillers ? _self.savedBillers : savedBillers // ignore: cast_nullable_to_non_nullable
as HomeSavedBillersData,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as HomeCategoriesData,
  ));
}
/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeRemindersDataCopyWith<$Res> get reminders {
  
  return $HomeRemindersDataCopyWith<$Res>(_self.reminders, (value) {
    return _then(_self.copyWith(reminders: value));
  });
}/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeSavedBillersDataCopyWith<$Res> get savedBillers {
  
  return $HomeSavedBillersDataCopyWith<$Res>(_self.savedBillers, (value) {
    return _then(_self.copyWith(savedBillers: value));
  });
}/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeCategoriesDataCopyWith<$Res> get categories {
  
  return $HomeCategoriesDataCopyWith<$Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeScreenData].
extension HomeScreenDataPatterns on HomeScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeScreenData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeScreenData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeScreenData value)  $default,){
final _that = this;
switch (_that) {
case _HomeScreenData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeScreenData value)?  $default,){
final _that = this;
switch (_that) {
case _HomeScreenData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeRemindersData reminders,  HomeSavedBillersData savedBillers,  HomeCategoriesData categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeScreenData() when $default != null:
return $default(_that.reminders,_that.savedBillers,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeRemindersData reminders,  HomeSavedBillersData savedBillers,  HomeCategoriesData categories)  $default,) {final _that = this;
switch (_that) {
case _HomeScreenData():
return $default(_that.reminders,_that.savedBillers,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeRemindersData reminders,  HomeSavedBillersData savedBillers,  HomeCategoriesData categories)?  $default,) {final _that = this;
switch (_that) {
case _HomeScreenData() when $default != null:
return $default(_that.reminders,_that.savedBillers,_that.categories);case _:
  return null;

}
}

}

/// @nodoc


class _HomeScreenData implements HomeScreenData {
  const _HomeScreenData({required this.reminders, required this.savedBillers, required this.categories});
  

@override final  HomeRemindersData reminders;
@override final  HomeSavedBillersData savedBillers;
@override final  HomeCategoriesData categories;

/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeScreenDataCopyWith<_HomeScreenData> get copyWith => __$HomeScreenDataCopyWithImpl<_HomeScreenData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeScreenData&&(identical(other.reminders, reminders) || other.reminders == reminders)&&(identical(other.savedBillers, savedBillers) || other.savedBillers == savedBillers)&&(identical(other.categories, categories) || other.categories == categories));
}


@override
int get hashCode => Object.hash(runtimeType,reminders,savedBillers,categories);

@override
String toString() {
  return 'HomeScreenData(reminders: $reminders, savedBillers: $savedBillers, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$HomeScreenDataCopyWith<$Res> implements $HomeScreenDataCopyWith<$Res> {
  factory _$HomeScreenDataCopyWith(_HomeScreenData value, $Res Function(_HomeScreenData) _then) = __$HomeScreenDataCopyWithImpl;
@override @useResult
$Res call({
 HomeRemindersData reminders, HomeSavedBillersData savedBillers, HomeCategoriesData categories
});


@override $HomeRemindersDataCopyWith<$Res> get reminders;@override $HomeSavedBillersDataCopyWith<$Res> get savedBillers;@override $HomeCategoriesDataCopyWith<$Res> get categories;

}
/// @nodoc
class __$HomeScreenDataCopyWithImpl<$Res>
    implements _$HomeScreenDataCopyWith<$Res> {
  __$HomeScreenDataCopyWithImpl(this._self, this._then);

  final _HomeScreenData _self;
  final $Res Function(_HomeScreenData) _then;

/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reminders = null,Object? savedBillers = null,Object? categories = null,}) {
  return _then(_HomeScreenData(
reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as HomeRemindersData,savedBillers: null == savedBillers ? _self.savedBillers : savedBillers // ignore: cast_nullable_to_non_nullable
as HomeSavedBillersData,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as HomeCategoriesData,
  ));
}

/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeRemindersDataCopyWith<$Res> get reminders {
  
  return $HomeRemindersDataCopyWith<$Res>(_self.reminders, (value) {
    return _then(_self.copyWith(reminders: value));
  });
}/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeSavedBillersDataCopyWith<$Res> get savedBillers {
  
  return $HomeSavedBillersDataCopyWith<$Res>(_self.savedBillers, (value) {
    return _then(_self.copyWith(savedBillers: value));
  });
}/// Create a copy of HomeScreenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeCategoriesDataCopyWith<$Res> get categories {
  
  return $HomeCategoriesDataCopyWith<$Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}
}

// dart format on
