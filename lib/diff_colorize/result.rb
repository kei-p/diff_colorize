
module DiffColorize
  class Result
    attr_reader :t1, :t2
    attr_accessor :color1, :color2

    def initialize(t1, t2)
      @t1 = t1
      @t2 = t2
      @color1, @color2 = "\e[31m", "\e[32m"
    end

    def diff
      t1.diff(t2).flatten
    end

    def t1_diff
      diff.select { |d| d.action == '-' }
    end

    def t2_diff
      diff.select { |d| d.action == '+' }
    end

    def color_t1
      colorize_diff_text(t1, t1_diff)
    end

    def color_t2
      colorize_diff_text(t2, t2_diff)
    end

    private

    def color_by_diff(d)
      case d.action
      when '-'
        color1
      when '+'
        color2
      end
    end

    def colorized_string(d)
      color_by_diff(d) + d.element + "\e[0m"
    end

    def colorize_diff_text(text, diffs)
      diffs.sort_by(&:position).reverse.inject(text.to_s.dup) do |c_text, d|
        c_text[d.position] = colorized_string(d)
        c_text
      end
    end
  end
end
