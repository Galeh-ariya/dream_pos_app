// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_access_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListAccessEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListAccessEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListAccessEvent()';
}


}

/// @nodoc
class $ListAccessEventCopyWith<$Res>  {
$ListAccessEventCopyWith(ListAccessEvent _, $Res Function(ListAccessEvent) __);
}


/// Adds pattern-matching-related methods to [ListAccessEvent].
extension ListAccessEventPatterns on ListAccessEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchAccess value)?  fetchAccess,TResult Function( _FetchAccessByJabatan value)?  fetchAccessByJabatan,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchAccess() when fetchAccess != null:
return fetchAccess(_that);case _FetchAccessByJabatan() when fetchAccessByJabatan != null:
return fetchAccessByJabatan(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchAccess value)  fetchAccess,required TResult Function( _FetchAccessByJabatan value)  fetchAccessByJabatan,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchAccess():
return fetchAccess(_that);case _FetchAccessByJabatan():
return fetchAccessByJabatan(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchAccess value)?  fetchAccess,TResult? Function( _FetchAccessByJabatan value)?  fetchAccessByJabatan,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchAccess() when fetchAccess != null:
return fetchAccess(_that);case _FetchAccessByJabatan() when fetchAccessByJabatan != null:
return fetchAccessByJabatan(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String outletId)?  fetchAccess,TResult Function( String outletId,  int jabatanId)?  fetchAccessByJabatan,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchAccess() when fetchAccess != null:
return fetchAccess(_that.outletId);case _FetchAccessByJabatan() when fetchAccessByJabatan != null:
return fetchAccessByJabatan(_that.outletId,_that.jabatanId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String outletId)  fetchAccess,required TResult Function( String outletId,  int jabatanId)  fetchAccessByJabatan,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchAccess():
return fetchAccess(_that.outletId);case _FetchAccessByJabatan():
return fetchAccessByJabatan(_that.outletId,_that.jabatanId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String outletId)?  fetchAccess,TResult? Function( String outletId,  int jabatanId)?  fetchAccessByJabatan,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchAccess() when fetchAccess != null:
return fetchAccess(_that.outletId);case _FetchAccessByJabatan() when fetchAccessByJabatan != null:
return fetchAccessByJabatan(_that.outletId,_that.jabatanId);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ListAccessEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListAccessEvent.started()';
}


}




/// @nodoc


class _FetchAccess implements ListAccessEvent {
  const _FetchAccess(this.outletId);
  

 final  String outletId;

/// Create a copy of ListAccessEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchAccessCopyWith<_FetchAccess> get copyWith => __$FetchAccessCopyWithImpl<_FetchAccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchAccess&&(identical(other.outletId, outletId) || other.outletId == outletId));
}


@override
int get hashCode => Object.hash(runtimeType,outletId);

@override
String toString() {
  return 'ListAccessEvent.fetchAccess(outletId: $outletId)';
}


}

/// @nodoc
abstract mixin class _$FetchAccessCopyWith<$Res> implements $ListAccessEventCopyWith<$Res> {
  factory _$FetchAccessCopyWith(_FetchAccess value, $Res Function(_FetchAccess) _then) = __$FetchAccessCopyWithImpl;
@useResult
$Res call({
 String outletId
});




}
/// @nodoc
class __$FetchAccessCopyWithImpl<$Res>
    implements _$FetchAccessCopyWith<$Res> {
  __$FetchAccessCopyWithImpl(this._self, this._then);

  final _FetchAccess _self;
  final $Res Function(_FetchAccess) _then;

/// Create a copy of ListAccessEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? outletId = null,}) {
  return _then(_FetchAccess(
null == outletId ? _self.outletId : outletId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FetchAccessByJabatan implements ListAccessEvent {
  const _FetchAccessByJabatan(this.outletId, this.jabatanId);
  

 final  String outletId;
 final  int jabatanId;

/// Create a copy of ListAccessEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchAccessByJabatanCopyWith<_FetchAccessByJabatan> get copyWith => __$FetchAccessByJabatanCopyWithImpl<_FetchAccessByJabatan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchAccessByJabatan&&(identical(other.outletId, outletId) || other.outletId == outletId)&&(identical(other.jabatanId, jabatanId) || other.jabatanId == jabatanId));
}


@override
int get hashCode => Object.hash(runtimeType,outletId,jabatanId);

@override
String toString() {
  return 'ListAccessEvent.fetchAccessByJabatan(outletId: $outletId, jabatanId: $jabatanId)';
}


}

/// @nodoc
abstract mixin class _$FetchAccessByJabatanCopyWith<$Res> implements $ListAccessEventCopyWith<$Res> {
  factory _$FetchAccessByJabatanCopyWith(_FetchAccessByJabatan value, $Res Function(_FetchAccessByJabatan) _then) = __$FetchAccessByJabatanCopyWithImpl;
@useResult
$Res call({
 String outletId, int jabatanId
});




}
/// @nodoc
class __$FetchAccessByJabatanCopyWithImpl<$Res>
    implements _$FetchAccessByJabatanCopyWith<$Res> {
  __$FetchAccessByJabatanCopyWithImpl(this._self, this._then);

  final _FetchAccessByJabatan _self;
  final $Res Function(_FetchAccessByJabatan) _then;

/// Create a copy of ListAccessEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? outletId = null,Object? jabatanId = null,}) {
  return _then(_FetchAccessByJabatan(
null == outletId ? _self.outletId : outletId // ignore: cast_nullable_to_non_nullable
as String,null == jabatanId ? _self.jabatanId : jabatanId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ListAccessState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListAccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListAccessState()';
}


}

/// @nodoc
class $ListAccessStateCopyWith<$Res>  {
$ListAccessStateCopyWith(ListAccessState _, $Res Function(ListAccessState) __);
}


/// Adds pattern-matching-related methods to [ListAccessState].
extension ListAccessStatePatterns on ListAccessState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<AccessResponseModel> aksesList)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.aksesList);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<AccessResponseModel> aksesList)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.aksesList);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<AccessResponseModel> aksesList)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.aksesList);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ListAccessState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListAccessState.initial()';
}


}




/// @nodoc


class _Loading implements ListAccessState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListAccessState.loading()';
}


}




/// @nodoc


class _Loaded implements ListAccessState {
  const _Loaded(final  List<AccessResponseModel> aksesList): _aksesList = aksesList;
  

 final  List<AccessResponseModel> _aksesList;
 List<AccessResponseModel> get aksesList {
  if (_aksesList is EqualUnmodifiableListView) return _aksesList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aksesList);
}


/// Create a copy of ListAccessState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._aksesList, _aksesList));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_aksesList));

@override
String toString() {
  return 'ListAccessState.loaded(aksesList: $aksesList)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ListAccessStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<AccessResponseModel> aksesList
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ListAccessState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? aksesList = null,}) {
  return _then(_Loaded(
null == aksesList ? _self._aksesList : aksesList // ignore: cast_nullable_to_non_nullable
as List<AccessResponseModel>,
  ));
}


}

/// @nodoc


class _Error implements ListAccessState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ListAccessState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ListAccessState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ListAccessStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ListAccessState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
