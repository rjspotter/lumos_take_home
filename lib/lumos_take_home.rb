require 'csv'
class LumosTakeHome

  def initialize(file_string = "")
    unless file_string == ""
      self.menu = CSV.read(file_string).map {|x| [x[0].to_i, x[1].to_f] + x[2..-1].map(&:strip)}
    end
  end

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
    args.flatten!
    costs  = algo(args) {|x| x.sort! {|a,b| a[0] <=> b[0]} }
    rcosts = algo(args) {|x| x.sort! {|a,b| a[0] <=> b[0]}.reverse! }
    smallest = (costs + rcosts).sort.first
    [(costs.index(smallest) || rcosts.index(smallest)) + 1,smallest]
  end

  def algo(args, &block)
    menu.map do |x|
      block.call(x)
      collector = []
      args.inject([]) do |collector,z|
        unless collector.inject([]) {|m,x| m << x[1..-1] ; m}.flatten.include?(z)
          collector << x.select {|y| y[1..-1].include? z}.
            sort do |a,b| 
            ((b[1..-1] + args).uniq <=> (a[1..-1] + args).uniq)
            end.first
        end
        collector
      end
    end.map {|z| z.inject(0.0) {|m,x| m + x[0]}}
  end

end
