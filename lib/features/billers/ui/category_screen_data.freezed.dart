// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryScreenData()';
}


}

/// @nodoc
class $CategoryScreenDataCopyWith<$Res>  {
$CategoryScreenDataCopyWith(CategoryScreenData _, $Res Function(CategoryScreenData) __);
}


/// Adds pattern-matching-related methods to [CategoryScreenData].
extension CategoryScreenDataPatterns on CategoryScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CategoryLoading value)?  loading,TResult Function( CategoryError value)?  error,TResult Function( CategoryLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CategoryLoading() when loading != null:
return loading(_that);case CategoryError() when error != null:
return error(_that);case CategoryLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CategoryLoading value)  loading,required TResult Function( CategoryError value)  error,required TResult Function( CategoryLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case CategoryLoading():
return loading(_that);case CategoryError():
return error(_that);case CategoryLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CategoryLoading value)?  loading,TResult? Function( CategoryError value)?  error,TResult? Function( CategoryLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case CategoryLoading() when loading != null:
return loading(_that);case CategoryError() when error != null:
return error(_that);case CategoryLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( String categoryName,  List<BillerListItemData> billers)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CategoryLoading() when loading != null:
return loading();case CategoryError() when error != null:
return error(_that.message);case CategoryLoaded() when loaded != null:
return loaded(_that.categoryName,_that.billers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( String categoryName,  List<BillerListItemData> billers)  loaded,}) {final _that = this;
switch (_that) {
case CategoryLoading():
return loading();case CategoryError():
return error(_that.message);case CategoryLoaded():
return loaded(_that.categoryName,_that.billers);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( String categoryName,  List<BillerListItemData> billers)?  loaded,}) {final _that = this;
switch (_that) {
case CategoryLoading() when loading != null:
return loading();case CategoryError() when error != null:
return error(_that.message);case CategoryLoaded() when loaded != null:
return loaded(_that.categoryName,_that.billers);case _:
  return null;

}
}

}

/// @nodoc


class CategoryLoading implements CategoryScreenData {
  const CategoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryScreenData.loading()';
}


}




/// @nodoc


class CategoryError implements CategoryScreenData {
  const CategoryError(this.message);
  

 final  String message;

/// Create a copy of CategoryScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryErrorCopyWith<CategoryError> get copyWith => _$CategoryErrorCopyWithImpl<CategoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CategoryScreenData.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CategoryErrorCopyWith<$Res> implements $CategoryScreenDataCopyWith<$Res> {
  factory $CategoryErrorCopyWith(CategoryError value, $Res Function(CategoryError) _then) = _$CategoryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CategoryErrorCopyWithImpl<$Res>
    implements $CategoryErrorCopyWith<$Res> {
  _$CategoryErrorCopyWithImpl(this._self, this._then);

  final CategoryError _self;
  final $Res Function(CategoryError) _then;

/// Create a copy of CategoryScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CategoryError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CategoryLoaded implements CategoryScreenData {
  const CategoryLoaded({required this.categoryName, required final  List<BillerListItemData> billers}): _billers = billers;
  

 final  String categoryName;
 final  List<BillerListItemData> _billers;
 List<BillerListItemData> get billers {
  if (_billers is EqualUnmodifiableListView) return _billers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_billers);
}


/// Create a copy of CategoryScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryLoadedCopyWith<CategoryLoaded> get copyWith => _$CategoryLoadedCopyWithImpl<CategoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoaded&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other._billers, _billers));
}


@override
int get hashCode => Object.hash(runtimeType,categoryName,const DeepCollectionEquality().hash(_billers));

@override
String toString() {
  return 'CategoryScreenData.loaded(categoryName: $categoryName, billers: $billers)';
}


}

/// @nodoc
abstract mixin class $CategoryLoadedCopyWith<$Res> implements $CategoryScreenDataCopyWith<$Res> {
  factory $CategoryLoadedCopyWith(CategoryLoaded value, $Res Function(CategoryLoaded) _then) = _$CategoryLoadedCopyWithImpl;
@useResult
$Res call({
 String categoryName, List<BillerListItemData> billers
});




}
/// @nodoc
class _$CategoryLoadedCopyWithImpl<$Res>
    implements $CategoryLoadedCopyWith<$Res> {
  _$CategoryLoadedCopyWithImpl(this._self, this._then);

  final CategoryLoaded _self;
  final $Res Function(CategoryLoaded) _then;

/// Create a copy of CategoryScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoryName = null,Object? billers = null,}) {
  return _then(CategoryLoaded(
categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,billers: null == billers ? _self._billers : billers // ignore: cast_nullable_to_non_nullable
as List<BillerListItemData>,
  ));
}


}

// dart format on
