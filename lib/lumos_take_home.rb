class LumosTakeHome


  attr_reader :menu
  def menu=(arr)
    @menu = arr.inject([[]]) do |m,x| 
      m[x[0]] ||= []
      m[x[0]] << x[1..x.length]
      m
    end
    @menu.shift
  end


  def optimize(*args)
    costs = menu.map do |x|
      x.sort! {|a,b| a[0] <=> b[0]}
      collector = []
      args.each do |z|
        unless collector.inject([]) {|m,x| m << x[1..-1] ; m}.flatten.include?(z)
          collector << x.select {|y| y[1..-1].include? z}.first
        end
      end
      collector
    end.map {|z| z.inject(0.0) {|m,x| m + x[0]}}
    smallest = costs.sort.first
    [costs.index(smallest) + 1,smallest]
  end

  

end
