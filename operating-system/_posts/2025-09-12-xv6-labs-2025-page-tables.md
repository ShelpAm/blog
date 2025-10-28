Permissions:
* `PTE_R` allows page to be read.
* `PTE_W` allows page to be written.
* `PTE_U` allows page to be accessed by user.
* `PTE_V` left clear in unused PTEs, which seems to be VALID flag.

Things to remember:
* Set correct and as small as possible permission for memory pages.

I don't know whether should I add a function to detect which level I had walked to.
