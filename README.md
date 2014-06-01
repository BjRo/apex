## Apex - Awesome Print for Elixir ##
Awesome Print is an Elixir library that pretty prints Elixir data structures in full color
exposing their internal structure with proper indentation. It's a port of part of the functionality
of Ruby's awesome [awesome_print gem](https://github.com/michaeldv/awesome_print).

### Installation ###
In oder to install it via hex, add the reference to this package into the `deps` area of your `mix.exs`.

```elixir
  defp deps do
    [
      {:apex, "~>0.1.0" }
    ]
  end
```

### Examples ###

```elixir
data = [ false, 42, ~w(forty two), [time: "now"], %{foo: :bar}]

Apex.ap data

# Will output the following:
#[
#   [0] false,
#   [1] 42,
#   [2] [
#     [0] "forty",
#     [1] "two"
#   ],
#   [3] [
#     [0] time: "now"
#   ]
#   [4] %{
#      foo: bar
#   }
#]
#
#:ok
```

### Supported types

* BitString
* Integer
* Float
* Atom
* List
* Range
* PID
* Function
* HashDict
* HashSet
* Map
* Tuple
* Elixir Records
* Elixir Structs

`Apex` uses a protocol internally to format a given value. If there's something not yet in the box, you can extend the protocol `Apex.Format`.

### Note on Patches/Pull Requests ###
* Fork the project on Github.
* Make your feature addition or bug fix.
* Add tests for it, making sure $ mix test is all green.
* Do not rebase other commits than your own
* Do not change the version in the mix file
* Commit 
* Send me a pull request

### License ###
(The MIT License)

Copyright (c) 2014 Björn Rochel

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
