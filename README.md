# family-tree

# Steps to execute 
- extract the file
- cd family_tree
- bundle install
- ruby src/input_processor.rb input.txt

# To run tests
- cd family_tree
- cd spec
- rspec create_shan_family_tree_spec.rb
- rspec family_tree_spec.rb

# Description about each class 

- input.txt => contains sample input commands as mentioned in the question
- basic_family.txt => contains input commands to create initial family try as given in the question
- CreateInitialFamily => has functions that allows us to create an initial family tree as given in the question
- FamilyTree => has functions that adds a child and gets all members as per the relationship
- InputProcessor => is a main class which takes input validates it and passes it to responsible functions


# Changes made in this submission

- Removed duplication of code 
	- earlier: had seperate methods for getting brother_in_laws and sister_in_laws
	- in this version modified to have a single method siblings_in_law 

	- earlier - had seperate methods for getting daughters and sons
	- in this version- modified to have single method get_children
- Renamed few class names and methods names
- Moved creation of seed data to an input file and a method
- Moved some methods to private scope
- Created constant for Gender in family_tree. This helps us to know the types of genders present and helps in easy modifications/ additions in future. 




