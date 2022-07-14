# Johnson

[![hex.pm version](https://img.shields.io/hexpm/v/johnson.svg)](https://hex.pm/packages/johnson)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Decode and encode JSON without altering the key order. 

## Installation

The package can be installed by adding `johnson` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:johnson, "~> 1.0.0"}
  ]
end
```

## Basic Usage

``` elixir
iex(1)> Johnson.decode!(~s({"a":"a","b":"b"}))
%Johnson{data: [{"a", "a"}, {"b", "b"}]}

iex(2)> Johnson.encode!(%Johnson{data: [{"a", "a"}, {"b", "b"}]})
~s({"a":"a","b":"b"})

iex(3)> Johnson.get(%Johnson{data: [{"a", "a"}, {"b", "b"}]}, "a")
"a"
```

## Documentation

The docs can be found at [https://hexdocs.pm/johnson](https://hexdocs.pm/johnson).

## License

This library is released under the MIT License.

See the [COPYING](COPYING) file for full license information.
