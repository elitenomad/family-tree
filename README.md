# Family::Tree

 In this directory, you'll find the files required to solve Family tree problem which was provided as a code challenge.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Usage

  Copy the zip file to a directory. Unzip the file and move repository to a directory

  ```
    cd family-tree
    bundle install
  ```

  For e.g on my machine i ran the rake task with absolute path of the test file in two ways.

  ```
    rake default /Users/pranava/interviews/family-tree/data/input/usecase-1.txt
  ```
  
  OR

  ```
    rake run['/Users/pranava/interviews/family-tree/data/input/usecase-1.txt']
  ```

  Note: Ensure ruby is installed on the system. Look into family.json for the structure of the input.

## Test

`simplecov` gem helps to create test coverage information for all the files. 
Coverage details will be automatically generated onto `coverage` folder when the below command is executed. 

```
  rspec spec/
```

## Main files

```
├── data
│   ├── family.json - Input data structure.
│   └── input [Geektrust github inputs]([https://link](https://github.com/geektrust/coding-problem-artefacts/blob/master/sample-io/Family/BD-IO-PS1/))
├── lib
│   └── family
│       ├── tree
│       │   ├── **builder.rb** - This class turns family.json object to nested tree like structure of `Family::Tree::Person` and `Family::Tree::Cohort` objects.
│       │   ├── **cli.rb** - This class is to read the input file (commands file) and run the commands in sequential order.
│       │   ├── **cohort.rb** - This class is to represent the family.json in a tree like structure.
│       │   ├── **command.rb** -This class exposes a class method which helps to parse the commands from the input file.
│       │   ├── **executor.rb** - This class is to act like a controller to all type of commands from the input file.
│       │   ├── **person.rb** - Person object with required attributes
│       │   ├── **relations.rb** - Service class with all the methods to execute the commands. Added documentation to all the methods in class.
│       └── **tree.rb** - Goal of this file is to require all the source code under `lib/` folder

```
## Design decisions

- As there was no mention of adding a other relationships (e.g. spouse, husband) in the program, i made a technical choice to create a family tree data structure pre - filled with the data provided in the image (For image reference, please look into problem statement).
- If the commands sent are invalid, they will be ignored
- Cohorts generation attribute will have husband and wife detail. Assumption here is that they are always of opposite sex.
- Child names must be Unique. As the search is based on a name will create problems if the names are not unique.
- If the names are more than two words, they must be enclosed in single Quotes (Double quotes are not handled). (e.g 'Queen Margret' not "Queen Margret" )
- Always single space between the commands in the input files.
- Relationship values are static and works only for below values
  - Paternal-Uncle
  - Maternal-Uncle
  - Paternal-Aunt
  - Maternal-Aunt
  - Sister-In-Law
  - Brother-In-Law
  - Son
  - Daughter
  - Siblings
  - COMMAND_NOT_SUPPORTED (If the command is not any one of the above)
- Added Integration tests only for happy path.
- I had two train of thoughts for `Family::Tree::Cohort` generation attribute. Chose the first one to solve the problem as mental model of generation object as two people found to be more meaningful than a nested structure.
  - One approach is to represent generation attribute as array of couple (sub family)
    ```
      Array value represent `Family::Tree:Person` values

      [
        {
          name: 'Bill',
          gender: 'Male',
          is_child: true,
          parent: 'King Arthur'
        },
        {
          name: 'Flora',
          gender: 'Female',
          is_child: false,
          parent: nil
        },
      ]
    ```
  - Another approach is to represent generation attribute as an nested object of p1 and p2. 
    ```
      Object value represent `Family::Tree:Person` 
        {
          name: 'Bill',
          gender: 'Male',
          is_child: true,
          parent: 'King Arthur'
          spouse: {
            name: 'Flora',
            gender: 'Female',
            is_child: false,
            parent: nil
          }
        }
    ```
### Extension Problem (Generation GAP)

Statement:

Assuming each layer belongs to one generation. Given two names from different generation , return the name of a person who belongs to older 
generation. If two people presented belong to same layer , we return a text called "SAME_GENERATION"

Error:
If either of the person who were given as inputs are not present, Raise a PersonNotFound error (To keep things simple).

Solution:

a) Add a usercase-4.txt file with the output.(Based on the PDF test cases)
b) Update cli spec to test the new command in the input file. CLI file itself needs no change.
c) Update Command Parser to have case statement for FIND_OLDER method in the input file.
d) Update Executor file to have the method delegated to the Relations class.
e) Update Person file to add new attribute called level
f) Update Builder class to add level to each layer. Add spec.
  1. Might require attributes check as well
e) Update Relations Class to add a new method find_older with two names
  1. Find person for two people
  2. Raise error if either one of them donot exists
  3. Check for the level of each person
  4. If equal return 'SAME_GENERATION'
  5. if not return the older generation person name
f) Add an integration spec for the usecase-4.txt
g) Validate all the specs are passing
h) Test two or three scenarios and repeat e) untill all the specs pass.

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
