# family-tree

# Steps to execute 
- extract the file
- cd family_tree
- bundle install
- ruby src/logic.rb input.txt

# To run tests
- cd family_tree
- cd spec
- rspec create_shan_family_tree_spec.rb
- rspec family_tree_spec.rb

# Description about each class 

- input.txt => contains sample input commands as mentioned in the question
- CreateShanFamilyTree => has functions that allows us to create an initial family tree as given in the question
- FamilyTree => has functions that adds a child and gets all members as per the relationship
- Logic => is a main class which takes input validates it and passes it to responsible functions


