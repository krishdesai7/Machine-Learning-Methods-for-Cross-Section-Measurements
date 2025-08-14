#!/usr/bin/env python3
import re
from pathlib import Path

def extract_theorems_and_proofs(tex_file_path):
    """Extract all theorem and proof environments from a tex file in order."""
    items = []
    
    with open(tex_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Combined regex to match both theorems and proofs while preserving order
    pattern = r'(\\begin\{(theorem|proof)\}.*?\\end\{\2\})'
    matches = re.findall(pattern, content, re.DOTALL)
    
    for match, env_type in matches:
        items.append(match.strip())
    
    return items

def main():
    # Set up paths
    base_dir = Path("/Users/desai/Desktop/Machine_Learning_Methods_for_Cross_Section_Measurements")
    chapters_dir = base_dir / "chapters"
    implementation_file = base_dir / "appendices" / "B-implementation.tex"
    
    # Collect all items (theorems and proofs in order)
    all_items = []
    total_theorems = 0
    total_proofs = 0
    
    # Process each .tex file in chapters directory
    for tex_file in sorted(chapters_dir.glob("*.tex")):
        print(f"Processing {tex_file.name}...")
        items = extract_theorems_and_proofs(tex_file)
        
        if items:
            # Add a comment to indicate source chapter
            all_items.append(f"\n% Theorems and Proofs from {tex_file.name}\n")
            all_items.extend(items)
            
            # Count theorems and proofs
            theorem_count = len([item for item in items if '\\begin{theorem}' in item])
            proof_count = len([item for item in items if '\\begin{proof}' in item])
            total_theorems += theorem_count
            total_proofs += proof_count
            
            print(f"  Found {theorem_count} theorem(s) and {proof_count} proof(s)")
        else:
            print(f"  No theorems or proofs found")
    
    # Append all items to implementation appendix
    if all_items:
        with open(implementation_file, 'a', encoding='utf-8') as f:
            f.write("\n\n% === Automatically extracted theorems and proofs ===\n")
            f.write("\n\\section{Theorems and Proofs}\n")
            for item in all_items:
                f.write(f"\n{item}\n")
        
        print(f"\nSuccessfully appended {total_theorems} theorem(s) and {total_proofs} proof(s) to {implementation_file}")
    else:
        print("\nNo theorems or proofs found in any chapter files.")

if __name__ == "__main__":
    main()