Start with simple low-level scripting language: floats, ints, booleans, pointers
Add preprocessor for good macros -- macro anything
Add ability to call system functions
Build runtime object layer in Haste


Object-oriented
Automatic reference counting with GC
Multiple inheritance 

Build with pointers, can then write entire runtime in itself

Native types:

# External 
external name(Type name, Type name, Type name) returns Type

method name(Type name, Type name, Type name) returns Type[, type]
  Type int (= value)
  if expr
  elseif expr
  else
  end
  
  expr if expr
  
  repeat while expr
  
  loop
  repeat until expr
  
  loop
  repeat for var/decl = expr to x
  
  loop
  repeat for var/decl in expr
  
  end
  repeat for var/decl = expr downto x
  
  loop
  
  #if constant expression
  
  #elseif constant expression
  
  #else
  
  #end
end

Operators:
* / - + or and xor not

