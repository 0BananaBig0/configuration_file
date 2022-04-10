set print pretty on
set print object on
set print static-members on
set print demangle on
set print sevenbit-strings off
set print array-indexes on
set print vtbl on
set confirm off


python
import sys
sys.path.insert(0, '/usr/share/gcc/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end


# // Add function to change string pointer to char pointer
# // so that we can print map[xxx] elements by gdb.
# // For example,std::unordered_map<std::string, std::string> map_test = {{"Hello","Mike"}},
# // we can print map_test[spToCp("Hello")]. Add the following content to your C/C++ source codes.
# std::string spToCp(const char *x) { return x; };
