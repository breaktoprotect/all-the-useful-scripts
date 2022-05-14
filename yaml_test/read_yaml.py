"""
Author  : Jeremy Soh @breaktoprotect
Date    : 14 May 2022
What    : Test yaml in python. Run the code to see what your YAML is like in Python dict
"""
import yaml

#* Read YAML file
with open("example.yaml", 'r') as yaml_file:
    example = yaml.load(yaml_file, Loader=yaml.FullLoader)

    print("'Example' object type:", type(example))
    print("Print 'example' yaml object as is: ", example)

#separator
print("---")
print("")

# Opening single file with multiple YAML defined
with open("two_yaml_in_one.yaml", 'r') as yaml_file:
    example = yaml.load_all(yaml_file) # This will create a gen since multiple YAML documents

    print("two_yaml_in_one.yml:")
    for index,obj in enumerate(example):
        print("Object",index)
        print("obj type:", type(obj))
        print("Content:", obj)
        print("")

