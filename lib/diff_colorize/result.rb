
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

    def superimpose
      cursor = { t1: 0, t2: 0 }
      diff.inject('') do |c_text, d|
        case d.action
        when '-'
          s = t1[cursor[:t1]..d.position-1]
          c_s = colorized_string(d)
          cursor[:t1] += d.element.length
        when '+'
          s = t2[cursor[:t2]..d.position-1]
          c_s = colorized_string(d)
          cursor[:t2] += d.element.length
        end
        cursor[:t1] += s.length
        cursor[:t2] += s.length
        c_text << s + c_s
      end
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
