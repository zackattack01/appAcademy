def super_print(str, options = {})
	 defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
   }
	 options = defaults.merge(options)
   str.upcase! if options[:upcase]
   str.reverse! if options[:reverse]
    ## removed puts for testing
   str * options[:times]
end

p super_print("Hello")                                    == "Hello"
p super_print("Hello", :times => 3)                       == "HelloHelloHello" 
p super_print("Hello", :upcase => true)                   == "HELLO"
p super_print("Hello", :upcase => true, :reverse => true) == "OLLEH"

options = {}
p super_print("hello", options) == "hello"
p options == {}   # options shouldn't change.