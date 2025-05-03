import os
import re

# Script to scan to ts files for finding unused exported symbols


def analyze_ts_files():
    ts_files = [f for f in os.listdir() if f.endswith(".ts") or f.endswith(".tsx")]
    
    results = {}
    file_imports = {}
    file_exports = {}
    
    import_pattern = re.compile(r"""
        import\s+
        (?:
            (?:(\w+)\s*,\s*)? 
            {([^}]+)}         
            |
            (\w+)              
        )
        \s+from\s+['"](.+?)['"]
    """, re.VERBOSE)
    
    export_pattern = re.compile(r"""
        export\s+
        (?:
            default\s+(?:const|let|var|function|class|interface|type|enum)?\s*(\w+)
            |
            (?:const|let|var|function|class|interface|type|enum)?\s*(\w+)      
        )
    """, re.VERBOSE)
    
    for file in ts_files:
        with open(file, "r", encoding="utf-8") as f:
            try:
                content = f.read()
                
                imports_found = import_pattern.findall(content)
                imported_symbols = set()
                imported_files = {}
                
                for match in imports_found:
                    if match[1]:  
                        symbols = [imp.strip().split(' as ')[0] for imp in match[1].split(',') if imp.strip()]
                        imported_symbols.update(symbols)
                        
                        source_file = match[3]
                        for symbol in symbols:
                            imported_files[symbol] = source_file
                    
                    if match[0]:  
                        imported_symbols.add(match[0])
                        imported_files[match[0]] = match[3]
                    
                    if match[2]:  
                        imported_symbols.add(match[2])
                        imported_files[match[2]] = match[3]
                
                exports_found = export_pattern.findall(content)
                exported_symbols = set()
                
                for match in exports_found:
                    if match[0]: 
                        exported_symbols.add(match[0])
                    if match[1]: 
                        exported_symbols.add(match[1])
                
                reexport_pattern = re.compile(r'export\s+\*\s+from\s+[\'"](.+?)[\'"]')
                reexports = reexport_pattern.findall(content)
                
                file_imports[file] = {
                    "symbols": imported_symbols,
                    "sources": imported_files
                }
                file_exports[file] = exported_symbols
                results[file] = {
                    "imports": list(imported_symbols), 
                    "exports": list(exported_symbols),
                    "reexports": reexports
                }
            except UnicodeDecodeError:
                print(f"Warning: Could not read {file} - encoding issue")
            except Exception as e:
                print(f"Error processing {file}: {str(e)}")
    
    return results, file_imports, file_exports

def resolve_file_path(importing_file, imported_path):
    """Resolve the actual file path from an import statement"""
    base_dir = os.path.dirname(importing_file)
    
    if imported_path.startswith('.'):
        path_without_ext = imported_path.split('.')[0]
        
        possible_paths = [
            os.path.normpath(os.path.join(base_dir, f"{path_without_ext}.ts")),
            os.path.normpath(os.path.join(base_dir, f"{path_without_ext}.tsx")),
            os.path.normpath(os.path.join(base_dir, path_without_ext, "index.ts")),
            os.path.normpath(os.path.join(base_dir, path_without_ext, "index.tsx"))
        ]
        
        for path in possible_paths:
            if os.path.exists(path):
                return path
    
    return None

def save_results_to_file(results, file_imports, file_exports, filename):
    with open(filename, "w") as f:
        all_imports = set()
        for imports_data in file_imports.values():
            all_imports.update(imports_data["symbols"])
        
        symbol_importers = {}
        for file, imports_data in file_imports.items():
            for symbol in imports_data["symbols"]:
                if symbol not in symbol_importers:
                    symbol_importers[symbol] = []
                symbol_importers[symbol].append(file)
        
        for file, data in results.items():
            f.write(f"\nFile: {file}\n")
            f.write(f"  Imports ({len(data['imports'])}):\n")
            if data['imports']:
                for symbol in sorted(data['imports']):
                    source = file_imports[file]["sources"].get(symbol, "unknown")
                    f.write(f"    - {symbol} from '{source}'\n")
            else:
                f.write("    None\n")
            
            f.write(f"  Exports ({len(data['exports'])}):\n")
            if data['exports']:
                for symbol in sorted(data['exports']):
                    importers = symbol_importers.get(symbol, [])
                    status = "UNUSED" if not importers else f"Used in {len(importers)} file(s)"
                    f.write(f"    - {symbol} [{status}]\n")
            else:
                f.write("    None\n")
            
            if data['reexports']:
                f.write(f"  Re-exports from:\n")
                for reexport in data['reexports']:
                    f.write(f"    - {reexport}\n")
            
            f.write("-" * 50 + "\n")
        
        f.write("\nOrphaned Exports Summary:\n")
        orphaned_count = 0
        for file, data in results.items():
            unused_exports = [symbol for symbol in data['exports'] if symbol not in all_imports]
            if unused_exports:
                orphaned_count += len(unused_exports)
                f.write(f"  {file}: {', '.join(unused_exports)}\n")
        
        if orphaned_count == 0:
            f.write("  No orphaned exports found.\n")
        else:
            f.write(f"\nTotal orphaned exports: {orphaned_count}\n")

if __name__ == "__main__":
    results, file_imports, file_exports = analyze_ts_files()
    save_results_to_file(results, file_imports, file_exports, "file.txt")