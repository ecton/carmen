Carmen Language
==============

Goals: 

* Simple, lightweight, general-purpose, object-oriented language that still runs fast enough to avoid switching to C/C++
* Compile or JIT to native code via [LLVM](http://llvm.org/)
* Bootstrap early and don't look back
* Eventually incorporate great language features that fit in the goals of the language
* Concurrency built in -- make it easier and as fool-proof as possible

Development Goals:

* Start with simple low-level scripting language: floats, ints, booleans, pointers, etc.
* Add preprocessor for a good macro system
* Add ability to link native libraries and call native functions in them -- no need to use C to interact with a C library
* Bootstrap early by making all library functions be written in native Carmen with external methods
* Build object model in native Carmen

# Random Scribblings that I haven't promoted to Markdown

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

