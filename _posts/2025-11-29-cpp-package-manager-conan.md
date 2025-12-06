---
title: C++ - The Package Manager Conan
tags:
- cpp
---

Conan is one of the most popular cross-platform package managers in cpp world. But it's also HARD to
use since it have a really bad documentation.

In this article, I'll give some notes on how to use `conan2`.

## Conan profile

As far as I know, conan profile (at least) defines the way how your machine builds the dependencies.

I just came across a problem related to language standard:

The package needs cstd=gnu17 to build, but I'm currently using gcc-15 which have cstd default to 23,
and the installation fails due to that version-incompatibility. We need to tweak cstd to lower (such
as gnu17 under which the package behaves normally). In [conan docs][conan-docs], it's very hard to
find something you want because they all resides in [conan reference][conan-reference].

Final solution was adding the following in your profile:
```text
[conf]
tools.build:cflags=["-std=gnu17"]
```

[conan-docs]: https://docs.conan.io/2/introduction.html
[conan-reference]: https://docs.conan.io/2/introduction.html

## Conanfile

There are two variants for defining a package:
- conanfile.txt
- conanfile.py

A basic `conanfile.py` file looks like this:
```py
from conan import ConanFile

class YourRecipe(ConanFile):
    name = "project-name"
    version = "0.1"
    settings = "os", "compiler", "build_type", "arch" # Stay as not changed

    default_options = {
        "package/ver:opt": True, # Or False
    }

    requires = (
        "package1/ver",
    )

    generators = (
        "CMakeDeps",
        "CMakeToolchain",
    )
```

With the example above, you can install your dependencies by:
```bash
conan install . -of build -b missing -pr default # and other -pr you want to use
```

After that, use the following to configure cmake:
```bash
cmake --preset conan-release # or conan-debug and so and so forth
# you can provide other settings like -G "Ninja Multi-Config"
```
