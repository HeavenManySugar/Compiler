Debugging with GDB/LLDB
gdb and lldb can't attach directly to emulated x86 processes, but you can run x86 programs under QEMU with the debug server enabled, and connect to the debug server using gdb/lldb. For example:


sudo apt install qemu-user-static
qemu-x86_64-static -g 1234 ./hello

# in another terminal
gdb ./hello
target remote :1234
continue# Compiler
