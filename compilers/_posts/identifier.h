#include <array>
#include <cstddef>
#include <cstdint>
#include <string>

using TypePointer = void *;
using Value = std::array<std::byte, 8>;

// NOLINTBEGIN
enum class IdentifierKind { type, constant, variable };

// @brief: AccessType determines whether actual value changes when the
// variable's value changes inside the function.
enum class AccessType { direct, indirect };

// Symbol Table
struct IdentifierBase {
    TypePointer typeptr;
    IdentifierKind kind;
};

struct Type : public IdentifierBase {};

struct Constant : public IdentifierBase {
    Value value;
};

struct Variable : public IdentifierBase {
    AccessType access;
    std::size_t level;
    std::size_t off;
};

enum class TypeKind { recordTy, arrayTy, pointerTy, unionTy };

// Type Table
struct TypeBase {
    std::size_t size;
    TypeKind kind;
};

struct Enum {
    // ...
};

struct Record {
    struct RecordField {
        std::string fieldname;
        TypeBase fieldtype;
        std::size_t off;
        RecordField *next;
    };

    RecordField *next;
};

struct Array {
    std::int_least64_t low;
    std::int_least64_t up;
    TypeBase *elemtype;
};

struct Pointer {
    TypeBase *basetype;
};

// ...
// NOLINTEND
