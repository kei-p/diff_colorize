# DiffColorize

Compare two text and decorate text differences.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'diff_colorize', github: 'kei-p/diff_colorize'
```

## Examples

```ruby
require 'diff_colorize'

result = DiffColorize.diff("abcde", "aBcDe")

result.color_t1
=> "a\e[31mb\e[0mc\e[31md\e[0me"

result.color_t2
=> "a\e[31mB\e[0mc\e[31mD\e[0me"

```

If you want to change the decorate color,  set [ANSI Escape sequences](http://ascii-table.com/ansi-escape-sequences.php) like this.

```ruby
result.color_t2("\e[36m")
=> "a\e[36mB\e[0mc\e[36mD\e[0me"

```


## Contributing

1. Fork it ( https://github.com/kei-p/diff_colorize/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
