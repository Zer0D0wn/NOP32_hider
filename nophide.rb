#!/usr/bin/ruby

if ARGV.length < 1 || ARGV.include?("-h") || ARGV.include?("--help")
  puts "This script change all NOP instruction (0x90) by 'inc' or 'dec' instruction of 'eax','ebx', 'ecx' and 'edx' registers to mask the NOP SLED (Work only with 32 bits architecture).
  Before use make sure that your shellcode :
  - correctly initializes the 'ax', 'bx', 'cx' and 'dx' registers if they are used
  - he is in hexadecimal
  - all opcode are separated by '\\x' or '\\0x'
  - our shellcode is designed for 32 bits architecture
  NOTE : this script deliver a non-working shellcode if the shellcode is already encoded (polymorphic encoding for exemple)
  Usage :
  #{$0} \"<shellcode>\"
  or
  #{$0} -f <file_of_shellcode>

  -h or --help show this message"
  exit(0)
end

shellcode = ARGV[0].split(/(\\[0]?x[0-9a-z]{2})/) # The \x character class seem not working
opcode = ['40', '43', '41', '42', '48', '4b', '49', '4a'] #The opcode will replace 90

for i in 0..shellcode.length
  if shellcode[i] == "\\x90"
    shellcode[i] = "\\x"+opcode[rand(7)].to_s
  end
  if shellcode[i] == "\\0x90"
    shellcode[i] = "\\0x"+opcode[rand(7)].to_s
  end
end

puts "
-------SHELLCODE-------
#{shellcode.join}
-----------------------
"
