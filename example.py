import cobol

with open("example.cbl",'r') as f:
    for row in cobol.process_cobol(f.readlines()):
    	print row['name']
