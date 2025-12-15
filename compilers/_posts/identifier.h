#include <array>
#include <cstddef>

using TypePointer = void *;
using Value = std::array<std::byte, 8>;

// NOLINTBEGIN
enum class Kind { type, constant, variable };

// @brief: AccessType determines whether actual value changes when the
// variable's value changes inside the function.
enum class AccessType { direct, indirect };

class IdentifierBase {
    TypePointer typeptr;
    Kind kind;
};

class Type : public IdentifierBase {};

class Constant : public IdentifierBase {
    Value value;
};

class Variable : public IdentifierBase {
    AccessType access;
    std::size_t level;
    std::size_t off;
};

class Enum : public IdentifierBase {
    // ...
};

// ...
// NOLINTEND
