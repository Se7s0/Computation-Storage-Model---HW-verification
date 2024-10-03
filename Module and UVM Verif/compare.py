import numpy as np

def compare_memory_files(mod_mem_file, dump_file):

    with open(dump_file, 'r') as f:
        dump_mem = np.array(f.read().splitlines())


    with open(mod_mem_file, 'r') as f:
        mod_mem = np.array(f.read().splitlines()[3:])


    if len(mod_mem) != len(dump_mem):
        raise ValueError("Files have different lengths. Ensure both memory files contain the same number of entries.")

    mod_mem_normalized = np.char.zfill(mod_mem, 4)  
    dump_mem_normalized = np.char.zfill(dump_mem, 4)  


    mismatches = np.sum(mod_mem_normalized != dump_mem_normalized)
    
    return mismatches

if __name__ == "__main__":
    mod_mem_file = 'mod_mem.txt'
    dump_file = 'memory_dump.txt'
    
    error_count = compare_memory_files(mod_mem_file, dump_file)
    print(f"Number of entries with errors: {error_count}")
