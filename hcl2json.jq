# Syntax stuff
def unwrap_hcl(x): if type=="array" and all(type=="object") then map(to_entries[]) | from_entries | x else . end ;
def unwrap_hcl_value: unwrap_hcl(.)                                                                              ;
def unwrap_hcl_map_entry_syntax(x): with_entries(.value|=(unwrap_hcl_value|x))                                   ;
def unwrap_hcl_map_syntax(x): unwrap_hcl(unwrap_hcl_map_entry_syntax(x))                                         ;
def unwrap_hcl_map_value: unwrap_hcl_map_syntax(.)                                                               ;
def unwrap_hcl_vars_syntax: unwrap_hcl_map_syntax(.default | unwrap_hcl_map_value)                               ;
# Process by file type
def tf_file: (.variable |= unwrap_hcl_vars_syntax) | (.locals |= unwrap_hcl_map_value) ;
def tfvars_file: (unwrap_hcl_map_entry_syntax(.))                                      ;
