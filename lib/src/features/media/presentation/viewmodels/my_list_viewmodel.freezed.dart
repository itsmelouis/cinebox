// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_list_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyListState {
  List<UserMedia> get mediaList => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isDeleting => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  WatchStatus? get selectedFilter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyListStateCopyWith<MyListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyListStateCopyWith<$Res> {
  factory $MyListStateCopyWith(
          MyListState value, $Res Function(MyListState) then) =
      _$MyListStateCopyWithImpl<$Res, MyListState>;
  @useResult
  $Res call(
      {List<UserMedia> mediaList,
      bool isLoading,
      bool isDeleting,
      String? errorMessage,
      WatchStatus? selectedFilter});
}

/// @nodoc
class _$MyListStateCopyWithImpl<$Res, $Val extends MyListState>
    implements $MyListStateCopyWith<$Res> {
  _$MyListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaList = null,
    Object? isLoading = null,
    Object? isDeleting = null,
    Object? errorMessage = freezed,
    Object? selectedFilter = freezed,
  }) {
    return _then(_value.copyWith(
      mediaList: null == mediaList
          ? _value.mediaList
          : mediaList // ignore: cast_nullable_to_non_nullable
              as List<UserMedia>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleting: null == isDeleting
          ? _value.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedFilter: freezed == selectedFilter
          ? _value.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as WatchStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyListStateImplCopyWith<$Res>
    implements $MyListStateCopyWith<$Res> {
  factory _$$MyListStateImplCopyWith(
          _$MyListStateImpl value, $Res Function(_$MyListStateImpl) then) =
      __$$MyListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<UserMedia> mediaList,
      bool isLoading,
      bool isDeleting,
      String? errorMessage,
      WatchStatus? selectedFilter});
}

/// @nodoc
class __$$MyListStateImplCopyWithImpl<$Res>
    extends _$MyListStateCopyWithImpl<$Res, _$MyListStateImpl>
    implements _$$MyListStateImplCopyWith<$Res> {
  __$$MyListStateImplCopyWithImpl(
      _$MyListStateImpl _value, $Res Function(_$MyListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaList = null,
    Object? isLoading = null,
    Object? isDeleting = null,
    Object? errorMessage = freezed,
    Object? selectedFilter = freezed,
  }) {
    return _then(_$MyListStateImpl(
      mediaList: null == mediaList
          ? _value._mediaList
          : mediaList // ignore: cast_nullable_to_non_nullable
              as List<UserMedia>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleting: null == isDeleting
          ? _value.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedFilter: freezed == selectedFilter
          ? _value.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as WatchStatus?,
    ));
  }
}

/// @nodoc

class _$MyListStateImpl implements _MyListState {
  const _$MyListStateImpl(
      {final List<UserMedia> mediaList = const [],
      this.isLoading = false,
      this.isDeleting = false,
      this.errorMessage,
      this.selectedFilter})
      : _mediaList = mediaList;

  final List<UserMedia> _mediaList;
  @override
  @JsonKey()
  List<UserMedia> get mediaList {
    if (_mediaList is EqualUnmodifiableListView) return _mediaList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaList);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isDeleting;
  @override
  final String? errorMessage;
  @override
  final WatchStatus? selectedFilter;

  @override
  String toString() {
    return 'MyListState(mediaList: $mediaList, isLoading: $isLoading, isDeleting: $isDeleting, errorMessage: $errorMessage, selectedFilter: $selectedFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyListStateImpl &&
            const DeepCollectionEquality()
                .equals(other._mediaList, _mediaList) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mediaList),
      isLoading,
      isDeleting,
      errorMessage,
      selectedFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyListStateImplCopyWith<_$MyListStateImpl> get copyWith =>
      __$$MyListStateImplCopyWithImpl<_$MyListStateImpl>(this, _$identity);
}

abstract class _MyListState implements MyListState {
  const factory _MyListState(
      {final List<UserMedia> mediaList,
      final bool isLoading,
      final bool isDeleting,
      final String? errorMessage,
      final WatchStatus? selectedFilter}) = _$MyListStateImpl;

  @override
  List<UserMedia> get mediaList;
  @override
  bool get isLoading;
  @override
  bool get isDeleting;
  @override
  String? get errorMessage;
  @override
  WatchStatus? get selectedFilter;
  @override
  @JsonKey(ignore: true)
  _$$MyListStateImplCopyWith<_$MyListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
