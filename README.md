## Apex - Awesome Print for Elixir ##
Awesome Print is an Elixir library that pretty prints Elixir data structures in full color
exposing their internal structure with proper indentation. It's a port of part of the functionality
of Ruby's awesome [awesome_print gem](https://github.com/michaeldv/awesome_print).

### Installation ###
In order to install it via hex, add the reference to this package into the `deps` area of your `mix.exs`.

```elixir
  defp deps do
    [
      {:apex, "~>1.2.1"}
    ]
  end
```

### Examples ###

```elixir
data = [false, 42, ~w(forty two), [time: "now"], %{foo: :bar}]

Apex.ap data

# Will output the following:
#[
#   [0] false
#   [1] 42
#   [2] [
#     [0] "forty"
#     [1] "two"
#   ]
#   [3] [
#     [0] time: "now"
#   ]
#   [4] %{
#      foo: bar
#   }
#]
#
#[false, 42, ~w(forty two), [time: "now"], %{foo: :bar}]
```

If the numbering is not for you, you can turn it off via `Apex.ap(data, numbers: false)`.

### Supported types

* BitString
* Integer
* Float
* Atom
* List
* Range
* PID
* Port
* Function
* MapSet
* Map
* Tuple
* Reference
* Elixir Records
* Elixir Structs

`Apex` uses a protocol internally to format a given value. If there's something not yet in the box, you can extend the protocol `Apex.Format`.

### Color customizations
You can customize the `Apex` colors on a per project or global basis. For project
specific color configuration, you can specify the color table in your `config/config.ex`

```elixir
use Mix.Config

config :apex, :colors, %{
  binary: :red
}
```

This can alternatively also be done at runtime by using the `Application.put_env/3` function.

Please note, that you only have to specify the colors you actively want to change here. For
the rest `Apex` will fallback to the defaults.

If you want to apply the same settings across multiple elixir projects, you can drop a `.apexrc`
file into your home directory in order do the same thing. The configuration is an `Elixir` Map.

```elixir
%{
  colors: %{
    binary: :yellow,
    true:   [:green, :bright]
  }
}
```

__IMPORTANT:__ the global configuration will get compiled into your `Apex` version when
you compile your app. You need to recompile `Apex` via `mix deps.compile apex` when
you want to apply changes to the `.apexrc` file.

__PRECEDENCE:__ When both project specific and global configuration
are present, project specific configuration will take precedence.

For a full list of all available customizations, please take a look at the result of `Apex.Format.Color.default_colors/0)`.

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
  [1] []
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

Copyright (c) 2014-2018 Björn Rochel

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
