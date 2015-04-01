clang -emit-llvm -Wall -c funcptr.c -o - | llc -march=cpp
