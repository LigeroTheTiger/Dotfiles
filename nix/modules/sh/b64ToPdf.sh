 b64topdf() {                                                                                                                             
      local input="$1"                                                                                                                     
      local output="${2:-${input}.pdf}"                                                                                                    
                                                                                                                                           
      if [[ -z "$input" ]]; then                                                                                                           
          echo "Usage: b64topdf <input_file> [output_file.pdf]"                                                                            
          return 1                                                                                                                         
      fi                                                                                                                                   
                                                                                                                                           
      if [[ ! -f "$input" ]]; then                                                                                                         
          echo "Error: File '$input' not found"                                                                                            
          return 1                                                                                                                         
      fi                                                                                                                                   
                                                                                                                                           
      base64 -D -i "$input" -o "$output" && echo "Created: $output"                                                                        
  }
