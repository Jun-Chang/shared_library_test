require "fiddle/import"

module M
  extend Fiddle::Importer
  dlload "/gopath/libhellogopher.so"
  extern "void helloGopher()"
  extern "int returnInt()"
  extern "char* returnStrWithArgs(char *p0)"
end

M.helloGopher

puts M.returnInt

puts M.returnStrWithArgs("rubyist")

