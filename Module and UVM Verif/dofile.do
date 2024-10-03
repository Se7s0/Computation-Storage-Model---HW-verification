vsim -gui -voptargs=+acc work.uvm_top
run -all
mem save -o mod_mem.txt -f mti -noaddress -data hex -addr hex -startaddress 0 -endaddress 255 -wordsperline 1 /uvm_top/m0/memory