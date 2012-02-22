class LumosTakeHome


  attr_reader :menu
  def menu=(arr)
    @menu = arr.inject([[]]) do |m,x| 
      m[x[0]] ||= []
      m[x[0]] << x[1..x.length]
      m
    end
  end


  def optimize(*args)
    costs = menu.map do |x|
      x.select {|y| args.include?(y[1])}.inject(0.0) {|m,x| m + x[0]}
    end
    smallest = costs.sort[1]
    [costs.index(smallest),smallest]
  end

  

end
