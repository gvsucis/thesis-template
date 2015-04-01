Project Maintenance
===================

Waf
---

[Waf][] is the build system for this project. It should be updated periodically.

A custom Waf was generated for this project for inclusion of the `biber` tool. Here is how it was generated:

    git clone https://code.google.com/p/waf/
    cd waf
    git tag # find the latest tag
    git checkout 1.8.7 # use latest tagged stable release
    python waf-light --tools=biber

[Waf]: https://code.google.com/p/waf/
