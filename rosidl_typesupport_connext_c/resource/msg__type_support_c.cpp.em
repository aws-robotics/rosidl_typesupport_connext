// generated from rosidl_typesupport_connext_c/resource/msg__type_support_c.cpp.em
// generated code does not contain a copyright notice

@##########################################################################
@# EmPy template for generating <msg>__type_support_c.cpp files for Connext
@#
@# Context:
@#  - spec (rosidl_parser.MessageSpecification)
@#    Parsed specification of the .msg file
@#  - pkg (string)
@#    name of the containing package; equivalent to spec.base_type.pkg_name
@#  - msg (string)
@#    name of the message; equivalent to spec.msg_name
@#  - type (string)
@#    full type of the message; equivalent to spec.base_type.type
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Could be 'msg', 'srv' or 'action'
@#  - get_header_filename_from_msg_name (function)
@##########################################################################
@
#include "@(spec.base_type.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.base_type.type))__rosidl_typesupport_connext_c.h"

#include <cassert>
#include <limits>

#include "rcutils/types/uint8_array.h"

#include "rmw/types.h"
#include "rmw/impl/cpp/macros.hpp"

// Provides the rosidl_typesupport_connext_c__identifier symbol declaration.
#include "rosidl_typesupport_connext_c/identifier.h"
// Provides the definition of the message_type_support_callbacks_t struct.
#include "rosidl_typesupport_connext_cpp/message_type_support.h"

#include "@(pkg)/msg/rosidl_typesupport_connext_c__visibility_control.h"
@{header_file_name = get_header_filename_from_msg_name(type)}@
#include "@(pkg)/@(subfolder)/@(header_file_name)__struct.h"
#include "@(pkg)/@(subfolder)/@(header_file_name)__functions.h"
#include "@(pkg)/@(subfolder)/@(header_file_name)__bounds.h"

#ifndef _WIN32
# pragma GCC diagnostic push
# pragma GCC diagnostic ignored "-Wunused-parameter"
# ifdef __clang__
#  pragma clang diagnostic ignored "-Wdeprecated-register"
#  pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
# endif
#endif
#include "@(spec.base_type.pkg_name)/@(subfolder)/dds_connext/@(spec.base_type.type)_Support.h"
#include "@(spec.base_type.pkg_name)/@(subfolder)/dds_connext/@(spec.base_type.type)_Plugin.h"
#ifndef _WIN32
# pragma GCC diagnostic pop
#endif

// includes and forward declarations of message dependencies and their conversion functions

@# // Include the message header for each non-primitive field.
#if defined(__cplusplus)
extern "C"
{
#endif

@{
includes = {}
for field in spec.fields:
    keys = set([])
    if field.type.is_primitive_type():
        if field.type.is_array:
            keys.add('rosidl_generator_c/primitives_sequence.h')
            keys.add('rosidl_generator_c/primitives_sequence_functions.h')
        if field.type.type == 'string':
            keys.add('rosidl_generator_c/string.h')
            keys.add('rosidl_generator_c/string_functions.h')
    else:
        header_file_name = get_header_filename_from_msg_name(field.type.type)
        keys.add('%s/msg/%s__functions.h' % (field.type.pkg_name, header_file_name))
    for key in keys:
        if key not in includes:
            includes[key] = set([])
        includes[key].add(field.name)
}@
@[for key in sorted(includes.keys())]@
#include "@(key)"  // @(', '.join(includes[key]))
@[end for]@

// forward declare type support functions
@{
forward_declares = {}
for field in spec.fields:
    if not field.type.is_primitive_type():
        key = (field.type.pkg_name, field.type.type)
        if key not in includes:
            forward_declares[key] = set([])
        forward_declares[key].add(field.name)
}@
@[for key in sorted(forward_declares.keys())]@
@[  if key[0] != pkg]@
ROSIDL_TYPESUPPORT_CONNEXT_C_IMPORT_@(pkg)
@[  end if]@
const rosidl_message_type_support_t *
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_connext_c, @(key[0]), msg, @(key[1]))();
@[end for]@

@# // Make callback functions specific to this message type.

@{
__dds_msg_type_prefix = "{0}::{1}::dds_::{2}_".format(
  spec.base_type.pkg_name, subfolder, spec.base_type.type)
}@
using __dds_msg_type = @(__dds_msg_type_prefix);
using __ros_msg_type = @(pkg)__@(subfolder)__@(type);

static DDS_TypeCode *
get_type_code()
{
  return @(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_TypeSupport::get_typecode();
}

static bool
convert_ros_to_dds(const void * untyped_ros_message, void * untyped_dds_message)
{
  if (!untyped_ros_message) {
    fprintf(stderr, "ros message handle is null\n");
    return false;
  }
  if (!untyped_dds_message) {
    fprintf(stderr, "dds message handle is null\n");
    return false;
  }
  const __ros_msg_type * ros_message = static_cast<const __ros_msg_type *>(untyped_ros_message);
  __dds_msg_type * dds_message = static_cast<__dds_msg_type *>(untyped_dds_message);
@[if not spec.fields]@
  // No fields is a no-op.
  (void)dds_message;
  (void)ros_message;
@[end if]@
@[for field in spec.fields]@
  // Field name: @(field.name)
  {
@[  if not field.type.is_primitive_type()]@
    const message_type_support_callbacks_t * @(field.type.pkg_name)__msg__@(field.type.type)__callbacks =
      static_cast<const message_type_support_callbacks_t *>(
      ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_connext_c, @(field.type.pkg_name), msg, @(field.type.type)
      )()->data);
@[  end if]@
@[  if field.type.is_array]@
@[    if field.type.array_size and not field.type.is_upper_bound]@
    size_t size = @(field.type.array_size);
@[    else]@
    size_t size = ros_message->@(field.name).size;
    if (size > (std::numeric_limits<DDS_Long>::max)()) {
      fprintf(stderr, "array size exceeds maximum DDS sequence size\n");
      return false;
    }
@[      if field.type.is_upper_bound]@
    if (size > @(field.type.array_size)) {
      fprintf(stderr, "array size exceeds upper bound\n");
      return false;
    }
@[      end if]@
    DDS_Long length = static_cast<DDS_Long>(size);
    if (length > dds_message->@(field.name)_.maximum()) {
      if (!dds_message->@(field.name)_.maximum(length)) {
        fprintf(stderr, "failed to set maximum of sequence\n");
        return false;
      }
    }
    if (!dds_message->@(field.name)_.length(length)) {
      fprintf(stderr, "failed to set length of sequence\n");
      return false;
    }
@[    end if]@
    for (DDS_Long i = 0; i < static_cast<DDS_Long>(size); ++i) {
@[    if field.type.array_size and not field.type.is_upper_bound]@
      auto & ros_i = ros_message->@(field.name)[i];
@[    else]@
      auto & ros_i = ros_message->@(field.name).data[i];
@[    end if]@
@[    if field.type.type == 'string']@
      const rosidl_generator_c__String * str = &ros_i;
      if (str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if (str->data[str->size] != '\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }
      dds_message->@(field.name)_[static_cast<DDS_Long>(i)] = DDS_String_dup(str->data);
@[    elif field.type.type == 'bool']@
      dds_message->@(field.name)_[i] = 1 ? ros_i : 0;
@[    elif field.type.is_primitive_type()]@
      dds_message->@(field.name)_[i] = ros_i;
@[    else]@
      if (!@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->convert_ros_to_dds(
          &ros_i, &dds_message->@(field.name)_[i]))
      {
        return false;
      }
@[    end if]@
    }
@[  elif field.type.type == 'string']@
    const rosidl_generator_c__String * str = &ros_message->@(field.name);
    if (str->capacity == 0 || str->capacity <= str->size) {
      fprintf(stderr, "string capacity not greater than size\n");
      return false;
    }
    if (str->data[str->size] != '\0') {
      fprintf(stderr, "string not null-terminated\n");
      return false;
    }
    dds_message->@(field.name)_ = DDS_String_dup(str->data);
@[  elif field.type.is_primitive_type()]@
    dds_message->@(field.name)_ = ros_message->@(field.name);
@[  else]@
    if (!@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->convert_ros_to_dds(
        &ros_message->@(field.name), &dds_message->@(field.name)_))
    {
      return false;
    }
@[  end if]@
  }

@[end for]@
  return true;
}

static bool
convert_dds_to_ros(const void * untyped_dds_message, void * untyped_ros_message)
{
  if (!untyped_ros_message) {
    fprintf(stderr, "ros message handle is null\n");
    return false;
  }
  if (!untyped_dds_message) {
    fprintf(stderr, "dds message handle is null\n");
    return false;
  }
  const __dds_msg_type * dds_message = static_cast<const __dds_msg_type *>(untyped_dds_message);
  __ros_msg_type * ros_message = static_cast<__ros_msg_type *>(untyped_ros_message);
@[if not spec.fields]@
  // No fields is a no-op.
  (void)dds_message;
  (void)ros_message;
@[end if]@
@[for field in spec.fields]@
  // Field name: @(field.name)
  {
@[  if field.type.is_array]@
@[    if field.type.array_size and not field.type.is_upper_bound]@
    DDS_Long size = @(field.type.array_size);
@[    else]@
@{
if field.type.type == 'string':
    array_init = 'rosidl_generator_c__String__Sequence__init'
    array_fini = 'rosidl_generator_c__String__Sequence__fini'
elif field.type.is_primitive_type():
    array_init = 'rosidl_generator_c__{field.type.type}__Sequence__init'.format(**locals())
    array_fini = 'rosidl_generator_c__{field.type.type}__Sequence__fini'.format(**locals())
else:
    array_init = '{field.type.pkg_name}__msg__{field.type.type}__Sequence__init'.format(**locals())
    array_fini = '{field.type.pkg_name}__msg__{field.type.type}__Sequence__fini'.format(**locals())
}@
    DDS_Long size = dds_message->@(field.name)_.length();
    if (ros_message->@(field.name).data) {
      @(array_fini)(&ros_message->@(field.name));
    }
    if (!@(array_init)(&ros_message->@(field.name), size)) {
      return "failed to create array for field '@(field.name)'";
    }
@[    end if]@
    for (DDS_Long i = 0; i < size; i++) {
@[    if field.type.array_size and not field.type.is_upper_bound]@
      auto & ros_i = ros_message->@(field.name)[i];
@[    else]@
      auto & ros_i = ros_message->@(field.name).data[i];
@[    end if]@
@[    if field.type.type == 'bool']@
      ros_i = (dds_message->@(field.name)_[i] != 0);
@[    elif field.type.type == 'string']@
      if (!ros_i.data) {
        rosidl_generator_c__String__init(&ros_i);
      }
      bool succeeded = rosidl_generator_c__String__assign(
        &ros_i,
        dds_message->@(field.name)_[i]);
      if (!succeeded) {
        fprintf(stderr, "failed to assign string into field '@(field.name)'\n");
        return false;
      }
@[    elif field.type.is_primitive_type()]@
      ros_i = dds_message->@(field.name)_[i];
@[    else]@
      const rosidl_message_type_support_t * ts =
        ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_connext_c, @(field.type.pkg_name), msg, @(field.type.type))();
      const message_type_support_callbacks_t * callbacks =
        static_cast<const message_type_support_callbacks_t *>(ts->data);
      callbacks->convert_dds_to_ros(&dds_message->@(field.name)_[i], &ros_i);
@[    end if]@
    }
@[  elif field.type.type == 'string']@
    if (!ros_message->@(field.name).data) {
      rosidl_generator_c__String__init(&ros_message->@(field.name));
    }
    bool succeeded = rosidl_generator_c__String__assign(
      &ros_message->@(field.name),
      dds_message->@(field.name)_);
    if (!succeeded) {
      fprintf(stderr, "failed to assign string into field '@(field.name)'\n");
      return false;
    }
@[  elif field.type.is_primitive_type()]@
    ros_message->@(field.name) = dds_message->@(field.name)_@(' == static_cast<DDS_Boolean>(true)' if field.type.type == 'bool' else '');
@[  else]@
    const rosidl_message_type_support_t * ts =
      ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_connext_c, @(field.type.pkg_name), msg, @(field.type.type))();
    const message_type_support_callbacks_t * callbacks =
      static_cast<const message_type_support_callbacks_t *>(ts->data);
    callbacks->convert_dds_to_ros(&dds_message->@(field.name)_, &ros_message->@(field.name));
@[  end if]@
  }

@[end for]@
  return true;
}

static rmw_ret_t get_serialized_length(void * dds_msg, unsigned int * expected_length)
{

 __dds_msg_type * dds_message = static_cast<__dds_msg_type * >(dds_msg);

@[for field in spec.fields]@
// Field name: @(field.name)
// Field name: @(msg)
// Field name: @(field.type.type)
// Field name: @(field.type.is_array)
@[  if msg=='UnboundedInt32Array' and field.name == 'int32_values' and field.type.is_array and field.type.type == "int32" ]@
printf("Length   : %d  \n", DDS_LongSeq_get_length(&dds_message->int32_values_));
printf("Maximum   : %d  \n", DDS_LongSeq_get_maximum(&dds_message->int32_values_));
 bool has_own = DDS_LongSeq_has_ownership(&dds_message->int32_values_);
 printf("HAS OWN    !!   : %d  \n", has_own);
  printf("Length   : %d  \n", DDS_LongSeq_get_length(&dds_message->int32_values_));
 printf("Maximum   : %d  \n", DDS_LongSeq_get_maximum(&dds_message->int32_values_));
@[end if ]@
@[end for]@

  // call the serialize function for the first time to get the expected length of the message
  if (@(spec.base_type.type)_Plugin_serialize_to_cdr_buffer(
     NULL, expected_length, dds_message) != RTI_TRUE)
  {
    RMW_SET_ERROR_MSG("failed to call @(spec.base_type.type)_Plugin_serialize_to_cdr_buffer()");
    return RMW_RET_ERROR;
  }

 return RMW_RET_OK;
}

static bool
to_cdr_stream(
  const void * untyped_ros_message,
  rcutils_uint8_array_t * cdr_stream)
{
  if (!untyped_ros_message) {
    return false;
  }
  if (!cdr_stream) {
    return false;
  }
  const __ros_msg_type * ros_message = static_cast<const __ros_msg_type *>(untyped_ros_message);
  __dds_msg_type dds_message;
  if (!convert_ros_to_dds(ros_message, &dds_message)) {
    return false;
  }

  // call the serialize function for the first time to get the expected length of the message
  unsigned int expected_length;
  if (@(spec.base_type.type)_Plugin_serialize_to_cdr_buffer(
      NULL, &expected_length, &dds_message) != RTI_TRUE)
  {
    fprintf(stderr, "failed to call @(spec.base_type.type)_Plugin_serialize_to_cdr_buffer()\n");
    return false;
  }

  cdr_stream->buffer_length = expected_length;
  if (cdr_stream->buffer_length > (std::numeric_limits<unsigned int>::max)()) {
    fprintf(stderr, "cdr_stream->buffer_length, unexpectedly larger than max unsigned int\n");
    return false;
  }
  if (cdr_stream->buffer_capacity < cdr_stream->buffer_length) {
    cdr_stream->allocator.deallocate(cdr_stream->buffer, cdr_stream->allocator.state);
    cdr_stream->buffer = static_cast<uint8_t *>(cdr_stream->allocator.allocate(cdr_stream->buffer_length, cdr_stream->allocator.state));
  }
  // call the function again and fill the buffer this time
  unsigned int buffer_length_uint = static_cast<unsigned int>(cdr_stream->buffer_length);
  if (@(spec.base_type.type)_Plugin_serialize_to_cdr_buffer(
      reinterpret_cast<char *>(cdr_stream->buffer),
      &buffer_length_uint,
      &dds_message) != RTI_TRUE)
  {
    return false;
  }

  return true;
}

static rmw_ret_t create_message(void ** msg, const void * bounds)
{

  @(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_ * dds_message = @(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_TypeSupport::create_data();

@{
unbounded_fields = []
for field in spec.fields:
    field.is_string_array = False
    field.is_primitive_array = False
    if field.type.is_array and not field.type.array_size and not field.type.is_upper_bound:
      if field.type.type == 'string':
          field.is_string_array = True
      elif field.type.is_primitive_type():
          field.is_primitive_array = True
      else:
          field.is_compound_array = True
      unbounded_fields.append(field)
}@
@[if unbounded_fields]@
const @(spec.base_type.pkg_name)__@(subfolder)__@(spec.base_type.type)__bounds  * bound;
 if(bounds){
  bound = static_cast<const @(spec.base_type.pkg_name)__@(subfolder)__@(spec.base_type.type)__bounds  *>(bounds);
 } else {
  RMW_SET_ERROR_MSG("Null bounds when using and unbounded field");
  return RMW_RET_ERROR;
 }
@[end if]@
@[for field in unbounded_fields]@
@[  if field.is_string_array]@
  DDS_StringSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
    bound->@(field.name)__length);
   for(size_t i = 0; i < bound->@(field.name)__length; i++){
    dds_message->@(field.name)_[i] = DDS_String_alloc(bound->@(field.name)__bounds.bounds);
   }
@[  elif field.is_primitive_array]@
  @[   if field.type.type == "bool"]@
   DDS_BooleanSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
    bound->@(field.name)__length);
  @[ elif field.type.type == "byte"]@
  DDS_OctetSeq_ensure_length(&dds_message->@(field.name)_,
   bound->@(field.name)__length,
   bound->@(field.name)__length );
  @[ elif field.type.type == "char"]@
  DDS_CharSeq_ensure_length(&dds_message->@(field.name)_,
   bound->@(field.name)__length,
   bound->@(field.name)__length );
  @[ elif field.type.type == "float32"]@
  DDS_FloatSeq_ensure_length(&dds_message->@(field.name)_,
  bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "float64"]@
  DDS_DoubleSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "int8"]@
  DDS_OctetSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "uint8"]@
  DDS_OctetSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "int16"]@
  DDS_ShortSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "uint16"]@
  DDS_UnsignedShortSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "int32"]@
   DDS_LongSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "uint32"]@
   DDS_UnsignedLongSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "int64"]@
   DDS_LongLongSeq_ensure_length(&dds_message->@(field.name)_,
    bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ elif field.type.type == "uint64"]@
   DDS_UnsignedLongLongSeq_ensure_length(&dds_message->@(field.name)_,
     bound->@(field.name)__length,
     bound->@(field.name)__length );
  @[ end if]@
@[ elif field.is_compound_array]@

@[ end if]@
@[end for]@

*msg = (void *) dds_message;

  return RMW_RET_OK;
}

static rmw_ret_t delete_message(void * msg)
{

  if(!msg){
    RMW_SET_ERROR_MSG("msg cannot be null");
    return RMW_RET_ERROR;
  }

  @(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_ * dds_message = static_cast<@(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_ * >(msg);
  if (@(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_TypeSupport::delete_data( dds_message) != DDS_RETCODE_OK) {
    RMW_SET_ERROR_MSG("msg cannot be null");
    return RMW_RET_ERROR;
  }
  return RMW_RET_OK;
}

static bool
to_message(
  const rcutils_uint8_array_t * cdr_stream,
  void * untyped_ros_message,
  void * untyped_dds_message)
{
  if (!cdr_stream) {
    return false;
  }
  if (!untyped_ros_message) {
    return false;
  }

  @(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_ * dds_message;
  if (untyped_dds_message) {
    dds_message = static_cast<@(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_ * >(untyped_dds_message);
  } else {
    dds_message =
    @(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_TypeSupport::create_data();
  }

  if (cdr_stream->buffer_length > (std::numeric_limits<unsigned int>::max)()) {
    fprintf(stderr, "cdr_stream->buffer_length, unexpectedly larger than max unsigned int\n");
    return false;
  }
  if (@(spec.base_type.type)_Plugin_deserialize_from_cdr_buffer(
      dds_message,
      reinterpret_cast<char *>(cdr_stream->buffer),
      static_cast<unsigned int>(cdr_stream->buffer_length)) != RTI_TRUE)
  {
    fprintf(stderr, "deserialize from cdr buffer failed\n");
    return false;
  }
  bool success = convert_dds_to_ros(dds_message, untyped_ros_message);

  if(!untyped_dds_message){
    if (@(spec.base_type.pkg_name)::@(subfolder)::dds_::@(spec.base_type.type)_TypeSupport::delete_data(dds_message) != DDS_RETCODE_OK) {
      return false;
      }
  }
  return success;
}

@
@# // Collect the callback functions and provide a function to get the type support struct.

static message_type_support_callbacks_t __callbacks = {
  "@(pkg)",  // package_name
  "@(msg)",  // message_name
  get_type_code,  // get_type_code
  convert_ros_to_dds,  // convert_ros_to_dds
  convert_dds_to_ros,  // convert_dds_to_ros
  to_cdr_stream,  // to_cdr_stream
  get_serialized_length, //get_serialized_length
  create_message, //create_message
  delete_message, // delete_message
  to_message  // to_message
};

static rosidl_message_type_support_t __type_support = {
  rosidl_typesupport_connext_c__identifier,
  &__callbacks,
  get_message_typesupport_handle_function,
};

const rosidl_message_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_connext_c, @(pkg), @(subfolder), @(msg))() {
  return &__type_support;
}

#if defined(__cplusplus)
}
#endif
