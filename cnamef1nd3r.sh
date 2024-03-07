#!/bin/bash

# If a command-line argument is provided, use it as the input file
if [ $# -eq 1 ]; then
    input_file="$1"
else
    # If no command-line argument is provided, use "final.txt" as the default input file
    input_file="final.txt"
fi

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi


# Output file to store nslookup results
output_file="nslookup_results.txt"

# Clear the output file
> "$output_file"

# Loop through each domain in the input file
while IFS= read -r domain; do
    echo -e "\e[1;32m Performing nslookup for:\e[0m  $domain "
    
    # Perform nslookup for the domain and append the result to the output file
    echo -e "\e[1;33m Domain: $domain \e[0m" >> "$output_file"
    nslookup -type=cname "$domain" >> "$output_file"
    echo "" >> "$output_file"  # Add an empty line for readability
done < "$input_file"

echo "nslookup for all domains completed. Results are saved in: $output_file"