Awesome Language
=========

Awesome programming language is a language developed in the book [How to Create Your Own Freaking Awesome Programming Language] by [Marc-André Cournoyer].

Awesome is:
  - a object-oriented language
  - a mix of Ruby syntax and Python indentation

Language Rules
----
  - As in Python, blocks of code are delimited by their indentation.
  - Classes are declared with the **class** keyword.
  - Methods can be defined anywhere using the **def** keyword.
  - Identifiers starting with a capital letter are constants which are globally
accessible.
  - Lower-case identifiers are local variables or method names.
  - If a method takes no arguments, parenthesis can be skipped, much like in
Ruby.
  - The last value evaluated in a method is its return value.
  - **Everything** is an **object**.


This implementation is a refactored and improved version.

Requirements
----
  - [Ruby] version 1.8.7 and up (early versions might work, but they weren't tested)
  - [racc]: a LALR(1) parser generator to Ruby
  - [rspec]: Behaviour Driven Development(BDD) for Ruby

Version
----

1.0


Installation
--------------

##### Installing requirements...
```sh
$ gem install racc
$ gem install rspec
```

##### Cloning the git repository...
```sh
git clone https://github.com/helton-hcs/awesome-language.git
cd awesome-language
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added my feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Send me a pull request


License
----

Apache v2


Developer
----
  - E-mail: [Helton Carlos de Souza]
  - GitHub: [helton-hcs]


[How to Create Your Own Freaking Awesome Programming Language]:http://createyourproglang.com/
[Marc-André Cournoyer]:https://github.com/macournoyer
[Ruby]:https://www.ruby-lang.org
[racc]:https://github.com/tenderlove/racc
[rSpec]:https://github.com/rspec/rspec
[Helton Carlos de Souza]:mailto:helton.development@gmail.com
[helton-hcs]:https://github.com/helton-hcs
