## Apex - Awesome Print for Elixir ##
Awesome Print is an Elixir library that pretty prints Elixir data structures in full color
exposing their internal structure with proper indentation. It's a port of part of the functionality
of Ruby's awesome [awesome_print gem](https://github.com/michaeldv/awesome_print).

### Installation ###
In order to install it via hex, add the reference to this package into the `deps` area of your `mix.exs`.

```elixir
  defp deps do
    [
      {:apex, "~>0.3.2"}
    ]
  end
```

### Examples ###

```elixir
data = [false, 42, ~w(forty two), [time: "now"], %{foo: :bar}]

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
* Reference
* Elixir Records
* Elixir Structs

`Apex` uses a protocol internally to format a given value. If there's something not yet in the box, you can extend the protocol `Apex.Format`.

### Awesome def aka adef
Inspired by [@sasajuric](https://github.com/sasa1977)'s [awesome blog post series about macros](http://www.theerlangelist.com/search/label/metaprogramming), Apex also contains an Apex flavored version of his `deftracable` macro. By using `adef` instead of `def` 

```elixir
import Apex.AwesomeDef
adef test(data, options \\ []) do
  data
end
```

all function invocations print trace outputs in the following format to the group leader (console):

```bash
iex(1)> Apex.test "foo"
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Function Elixir.Apex.test was called
defined in /Users/bjoernrochel/Coding/Laboratory/apex/lib/apex.ex:12
----------------------------------------------------------------------------------------------------
Parameters:
----------------------------------------------------------------------------------------------------
[
  [0] "foo"
  [1] [
  ]
]

----------------------------------------------------------------------------------------------------
Result:
----------------------------------------------------------------------------------------------------
"foo"
```

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

Copyright (c) 2014-2015 Björn Rochel

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
