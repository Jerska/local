# asdf

# Notes

## Python

Python is super annoying.
For Python@3 to complete, I've needed to tell it I was using `openssl@3`, using `PYTHON_BUILD_HOMEBREW_OPENSSL_FORMULA="openssl@3"`.
For Python@2 to complete, I've needed to do the opposite, and pass `CFLAGS` & `LDFLAGS` pointing to the `openssl@1.1` folders.
