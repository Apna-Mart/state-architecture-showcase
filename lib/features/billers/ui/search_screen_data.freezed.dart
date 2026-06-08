// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_screen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchScreenData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchScreenData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchScreenData()';
}


}

/// @nodoc
class $SearchScreenDataCopyWith<$Res>  {
$SearchScreenDataCopyWith(SearchScreenData _, $Res Function(SearchScreenData) __);
}


/// Adds pattern-matching-related methods to [SearchScreenData].
extension SearchScreenDataPatterns on SearchScreenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchIdle value)?  idle,TResult Function( SearchSearching value)?  searching,TResult Function( SearchEmpty value)?  empty,TResult Function( SearchError value)?  error,TResult Function( SearchResults value)?  results,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle(_that);case SearchSearching() when searching != null:
return searching(_that);case SearchEmpty() when empty != null:
return empty(_that);case SearchError() when error != null:
return error(_that);case SearchResults() when results != null:
return results(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchIdle value)  idle,required TResult Function( SearchSearching value)  searching,required TResult Function( SearchEmpty value)  empty,required TResult Function( SearchError value)  error,required TResult Function( SearchResults value)  results,}){
final _that = this;
switch (_that) {
case SearchIdle():
return idle(_that);case SearchSearching():
return searching(_that);case SearchEmpty():
return empty(_that);case SearchError():
return error(_that);case SearchResults():
return results(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchIdle value)?  idle,TResult? Function( SearchSearching value)?  searching,TResult? Function( SearchEmpty value)?  empty,TResult? Function( SearchError value)?  error,TResult? Function( SearchResults value)?  results,}){
final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle(_that);case SearchSearching() when searching != null:
return searching(_that);case SearchEmpty() when empty != null:
return empty(_that);case SearchError() when error != null:
return error(_that);case SearchResults() when results != null:
return results(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  searching,TResult Function( String query)?  empty,TResult Function( String query)?  error,TResult Function( List<BillerListItemData> billers)?  results,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle();case SearchSearching() when searching != null:
return searching();case SearchEmpty() when empty != null:
return empty(_that.query);case SearchError() when error != null:
return error(_that.query);case SearchResults() when results != null:
return results(_that.billers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  searching,required TResult Function( String query)  empty,required TResult Function( String query)  error,required TResult Function( List<BillerListItemData> billers)  results,}) {final _that = this;
switch (_that) {
case SearchIdle():
return idle();case SearchSearching():
return searching();case SearchEmpty():
return empty(_that.query);case SearchError():
return error(_that.query);case SearchResults():
return results(_that.billers);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  searching,TResult? Function( String query)?  empty,TResult? Function( String query)?  error,TResult? Function( List<BillerListItemData> billers)?  results,}) {final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle();case SearchSearching() when searching != null:
return searching();case SearchEmpty() when empty != null:
return empty(_that.query);case SearchError() when error != null:
return error(_that.query);case SearchResults() when results != null:
return results(_that.billers);case _:
  return null;

}
}

}

/// @nodoc


class SearchIdle implements SearchScreenData {
  const SearchIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchScreenData.idle()';
}


}




/// @nodoc


class SearchSearching implements SearchScreenData {
  const SearchSearching();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSearching);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchScreenData.searching()';
}


}




/// @nodoc


class SearchEmpty implements SearchScreenData {
  const SearchEmpty(this.query);
  

 final  String query;

/// Create a copy of SearchScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchEmptyCopyWith<SearchEmpty> get copyWith => _$SearchEmptyCopyWithImpl<SearchEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEmpty&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchScreenData.empty(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchEmptyCopyWith<$Res> implements $SearchScreenDataCopyWith<$Res> {
  factory $SearchEmptyCopyWith(SearchEmpty value, $Res Function(SearchEmpty) _then) = _$SearchEmptyCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchEmptyCopyWithImpl<$Res>
    implements $SearchEmptyCopyWith<$Res> {
  _$SearchEmptyCopyWithImpl(this._self, this._then);

  final SearchEmpty _self;
  final $Res Function(SearchEmpty) _then;

/// Create a copy of SearchScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchEmpty(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchError implements SearchScreenData {
  const SearchError(this.query);
  

 final  String query;

/// Create a copy of SearchScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchErrorCopyWith<SearchError> get copyWith => _$SearchErrorCopyWithImpl<SearchError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchError&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchScreenData.error(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchErrorCopyWith<$Res> implements $SearchScreenDataCopyWith<$Res> {
  factory $SearchErrorCopyWith(SearchError value, $Res Function(SearchError) _then) = _$SearchErrorCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchErrorCopyWithImpl<$Res>
    implements $SearchErrorCopyWith<$Res> {
  _$SearchErrorCopyWithImpl(this._self, this._then);

  final SearchError _self;
  final $Res Function(SearchError) _then;

/// Create a copy of SearchScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchError(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchResults implements SearchScreenData {
  const SearchResults({required final  List<BillerListItemData> billers}): _billers = billers;
  

 final  List<BillerListItemData> _billers;
 List<BillerListItemData> get billers {
  if (_billers is EqualUnmodifiableListView) return _billers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_billers);
}


/// Create a copy of SearchScreenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultsCopyWith<SearchResults> get copyWith => _$SearchResultsCopyWithImpl<SearchResults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResults&&const DeepCollectionEquality().equals(other._billers, _billers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_billers));

@override
String toString() {
  return 'SearchScreenData.results(billers: $billers)';
}


}

/// @nodoc
abstract mixin class $SearchResultsCopyWith<$Res> implements $SearchScreenDataCopyWith<$Res> {
  factory $SearchResultsCopyWith(SearchResults value, $Res Function(SearchResults) _then) = _$SearchResultsCopyWithImpl;
@useResult
$Res call({
 List<BillerListItemData> billers
});




}
/// @nodoc
class _$SearchResultsCopyWithImpl<$Res>
    implements $SearchResultsCopyWith<$Res> {
  _$SearchResultsCopyWithImpl(this._self, this._then);

  final SearchResults _self;
  final $Res Function(SearchResults) _then;

/// Create a copy of SearchScreenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billers = null,}) {
  return _then(SearchResults(
billers: null == billers ? _self._billers : billers // ignore: cast_nullable_to_non_nullable
as List<BillerListItemData>,
  ));
}


}

// dart format on
