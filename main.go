package main

/*
#include <stdlib.h>
*/
import "C"
import (
	"fmt"
	_"unsafe"
)

// void関数は簡単。何も意識する必要なし
//export helloGopher
func helloGopher() {
	fmt.Println("Hello Gopher!")
}

// int関数は素直にintを返せばOK
// int32 or int64はアーキテクチャ依存 (goでのintの扱いと同じ)
//export returnInt
func returnInt() int {
	return 1
}

// stringは *C.charで扱える
// 引数も同様
//export returnStrWithArgs
func returnStrWithArgs(args *C.char)  *C.char {
	gostr := C.GoString(args)

	// 呼び出し元でfreeする必要あり
	return C.CString(fmt.Sprintf("Hello %s!", gostr))
	//defer C.free(unsafe.Pointer(cstr))
}

func main() {
}
