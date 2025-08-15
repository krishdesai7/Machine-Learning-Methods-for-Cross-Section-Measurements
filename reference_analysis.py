#!/usr/bin/env python3
"""
Script to analyze \ref, \cref, \Cref commands and check for broken references.
"""

import re
import glob
import os

def extract_references_from_file(filepath):
    """Extract all reference commands from a .tex file."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except:
        return [], []
    
    # Find all reference commands
    ref_pattern = r'\\(?:ref|cref|Cref|eqref|pageref)\{([^}]+)\}'
    references = re.findall(ref_pattern, content)
    
    # Find all label commands
    label_pattern = r'\\label\{([^}]+)\}'
    labels = re.findall(label_pattern, content)
    
    return references, labels

def main():
    # Find all .tex files
    tex_files = []
    for pattern in ['*.tex', 'chapters/*.tex', 'appendices/*.tex', 'tables/*.tex']:
        tex_files.extend(glob.glob(pattern))
    
    all_references = set()
    all_labels = set()
    file_references = {}
    file_labels = {}
    
    print("Analyzing .tex files for references and labels...\n")
    
    for filepath in tex_files:
        references, labels = extract_references_from_file(filepath)
        if references or labels:
            file_references[filepath] = references
            file_labels[filepath] = labels
            all_references.update(references)
            all_labels.update(labels)
    
    print(f"Found {len(all_references)} unique references")
    print(f"Found {len(all_labels)} unique labels\n")
    
    # Check for broken references
    broken_refs = all_references - all_labels
    unused_labels = all_labels - all_references
    
    if broken_refs:
        print("=== BROKEN REFERENCES ===")
        print("These references don't have corresponding labels:")
        for ref in sorted(broken_refs):
            print(f"  {ref}")
            # Find which files use this broken reference
            for filepath, refs in file_references.items():
                if ref in refs:
                    print(f"    Referenced in: {filepath}")
        print()
    
    if unused_labels:
        print("=== UNUSED LABELS ===")
        print("These labels are defined but never referenced:")
        for label in sorted(unused_labels):
            print(f"  {label}")
            # Find which files define this unused label
            for filepath, labels in file_labels.items():
                if label in labels:
                    print(f"    Defined in: {filepath}")
        print()
    
    if not broken_refs and not unused_labels:
        print("✓ All references have corresponding labels!")
        print("✓ All labels are used!")
    
    # Summary by category
    print("=== SUMMARY BY TYPE ===")
    ref_types = {}
    for ref in all_references:
        if ref.startswith('eq:'):
            ref_types.setdefault('equations', set()).add(ref)
        elif ref.startswith('fig:'):
            ref_types.setdefault('figures', set()).add(ref)
        elif ref.startswith('tab:'):
            ref_types.setdefault('tables', set()).add(ref)
        elif ref.startswith('sec:') or ref.startswith('subsec:') or ref.startswith('subsubsec:'):
            ref_types.setdefault('sections', set()).add(ref)
        elif ref.startswith('chap:'):
            ref_types.setdefault('chapters', set()).add(ref)
        elif ref.startswith('alg:'):
            ref_types.setdefault('algorithms', set()).add(ref)
        elif ref.startswith('thm:') or ref.startswith('lem:') or ref.startswith('def:'):
            ref_types.setdefault('theorems/definitions', set()).add(ref)
        else:
            ref_types.setdefault('other', set()).add(ref)
    
    for category, refs in ref_types.items():
        print(f"{category}: {len(refs)} references")

if __name__ == "__main__":
    main()