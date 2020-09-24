# Family::Tree

 In this directory, you'll find the files required to solve Family tree problem which was provided as a code challenge.

 ## Debug

To experiment with that code, run `bin/console` for an interactive prompt.

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

```
  rspec spec/
```

## Main files

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

## Design decisions

- As there was no mention of adding a other relationships (e.g. spouse, husband) in the program, i made a technical choice to create a family tree data structure filled with the information provided in the image (For image reference, please look into problem statement).
- If the commands sent are invalid, they will be ignored
- Cohorts generation attribute will have husband and wife detail. Assumption here is that they are always of opposite sex.
- Child names must be Unique. As the search is based on a name will create problems if the names are not unique.
- If the names are more than two words, they must be enclosed in single Quotes (Not Double quotes as code handles only single quotes). (e.g 'Queen Margret' )
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
- Added Integration tests only for happy path.
- I had two train of thoughts for `Family::Tree::Cohort` generation attribute. Chose the first one to solve the problem.
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).