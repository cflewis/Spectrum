class Spectrum
    module ArrayExpansion
        extend self
    
        def expand_line(prism_line)
            prism_line = expand_array_declaration(prism_line)
            prism_line = expand_array_usage(prism_line)
            return prism_line
        end
    
        def expand_array_declaration(prism_line, separator = "__")
            # cflewis | 2010-03-27 | eg. x[3] : [0..2] init blank
            array_declaration = /(\s*)(\w+)\[(\d+)\](\[(\d+)\])?\s+:\s+(\[.*\]\s+init\s+(\w+)\;)/
        
            # cflewis | 2010-03-27 | For each line, check for array declarations
            # and substitute with individual variables
            if (prism_line =~ array_declaration) 
                leading_whitespace = $1
                array_name = $2
                array_length = $3
                array_length_2d = $5
                tailing_data = $6
                             
                # cflewis | 2010-03-27 | The array is implicitly one row
                if array_length_2d.nil? then array_length_2d = 1 end
                                
                array_substitution = ""

                for i in (0..Integer(array_length) - 1)
                    for j in (0..Integer(array_length_2d) -1)
                        array_substitution = array_substitution + 
                            "#{leading_whitespace}#{array_name}#{separator}#{i}#{separator}#{j} " +
                            ": #{tailing_data} //Substitution by Spectrum\n"
                    end
                end

                return prism_line.gsub(array_declaration, array_substitution)
            end
        
            return prism_line
        end
    
        def expand_array_usage(prism_line, separator = "__")
            # cflewis | 2010-03-27 | eg. x[1]
            array_usage = /(\w+)\[(\d+)\](\[(\d+)\])?/
        
            # cflewis | 2010-03-27 | Replace all array usages with their
            # corresponding expanded variables
            return prism_line.gsub(array_usage) do |match|
                array_name = $1
                array_position = $2
                array_position_2d = $4
        
                if array_position_2d.nil? then array_position_2d = 0 end
            
                "#{array_name}#{separator}#{array_position}#{separator}#{array_position_2d}"
            end
        
            return prism_line
        end
    end
    
    
    def parse(input)
        input.each_line do |line|
            puts ArrayExpansion.expand_line(line)
        end
    end
end

begin
    if $stdin.tty?
        if ARGV.empty?
            puts "Need to pass file or STDIN"
            exit
        end

        if File.exists?(file = ARGV[0])
            input = File.open(file)
        else
            abort "Can't find #{file}"
        end
    else
        input = $stdin
    end
    
    
    parser = Spectrum.new
    parser.parse(input)
end