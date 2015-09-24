import ctypes
lib = ctypes.CDLL("/gopath/libhellogopher.so")

lib.helloGopher()

print(lib.returnInt())

# set return types
lib.returnStrWithArgs.restype = ctypes.c_char_p
print(lib.returnStrWithArgs("pythonista"))
