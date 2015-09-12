import ctypes
lib = ctypes.CDLL("../../libhellogopher.so")
lib.helloGopher()