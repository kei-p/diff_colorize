
module DiffColorize
  class Result
    attr_reader :t1, :t2

    def initialize(t1, t2)
      @t1 = t1
      @t2 = t2
    end

    def diff
      d = t1.diff(t2).flatten.group_by { |c| c.action  }
      t1_diff = d["-"] || []
      t2_diff = d["+"] || []

      {
        t1_diff: t1_diff,
        t2_diff: t2_diff
      }
    end

    def color_t1(color = "\e[31m")
      colorize_diff_text(t1, diff[:t1_diff], color)
    end

    def color_t2(color = "\e[31m")
      colorize_diff_text(t2, diff[:t2_diff], color)
    end

    private
    def colorize_diff_text(text, diffs, color)
      return text if text.length < 1
      c_text = text.dup
      buff = 0
      plain = "\e[0m"

      diffs.each do |c|
        pos = c.position + buff
        c_text[pos] = color + c.element + plain
        buff += (color + plain).length
      end
      c_text
    end
  end
end
