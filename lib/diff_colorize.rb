require 'diff/lcs'
require 'diff/lcs/string'
require File.expand_path('../diff_colorize/version', __FILE__)

module DiffColorize
  autoload :Result, File.expand_path('../diff_colorize/result', __FILE__)

  def self.diff(t1, t2)
    DiffColorize::Result.new(t1, t2)
  end

end
