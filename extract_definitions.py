#!/usr/bin/env python3
import re
from pathlib import Path

def extract_definitions(tex_file_path):
    """Extract all definition environments from a tex file."""
    definitions = []
    
    with open(tex_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Regex to match \begin{definition}...\end{definition} including nested braces
    pattern = r'\\begin\{definition\}(.*?)\\end\{definition\}'
    matches = re.findall(pattern, content, re.DOTALL)
    
    for match in matches:
        # Reconstruct the full definition environment
        full_definition = f"\\item {match}"
        definitions.append(full_definition.strip())
    definitions.sort()
    return definitions

def main():
    # Set up paths
    base_dir = Path("/Users/desai/Desktop/Machine_Learning_Methods_for_Cross_Section_Measurements")
    chapters_dir = base_dir / "chapters"
    glossary_file = base_dir / "appendices" / "A-glossary.tex"
    
    # Collect all definitions
    all_definitions = []
    
    # Process each .tex file in chapters directory
    for tex_file in sorted(chapters_dir.glob("*.tex")):
        print(f"Processing {tex_file.name}...")
        definitions = extract_definitions(tex_file)
        
        if definitions:
            all_definitions.extend(definitions)
            print(f"  Found {len(definitions)} definition(s)")
        else:
            print(f"  No definitions found")
    
    # Append all definitions to glossary
    if all_definitions:
        with open(glossary_file, 'w', encoding='utf-8') as f:
            f.write("""\chapter{Glossary}\n\n\\begin{description}\n""")
            for definition in all_definitions:
                f.write(f"\n{definition}\n")
            f.write("""\end{description}\n""")
        
        # Count actual definitions (not comments)
        definition_count = len([d for d in all_definitions])
        print(f"\nSuccessfully appended {definition_count} definitions to {glossary_file}")
    else:
        print("\nNo definitions found in any chapter files.")

if __name__ == "__main__":
    main()