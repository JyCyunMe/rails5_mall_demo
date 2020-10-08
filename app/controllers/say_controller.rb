class SayController < ApplicationController
  def hello
    @time = Time.now.strftime("%Y/%m/%d %H:%M:%S.%U %a")
    @files = Dir.glob('up');
  end

  def goodbye
  end
end
