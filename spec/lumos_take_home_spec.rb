require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "LumosTakeHome" do
  let(:sample) do
    [
     [1, 4.00, "ham_sandwich"],
     [1, 8.00, "burrito"],
     [2, 5.00, "ham_sandwich"],
     [2, 6.50, "burrito"]
    ]
  end
  let(:subject) {LumosTakeHome.new}

  before {subject.menu = sample}

  it "takes a csv file and parses it into the menus" do
    s = LumosTakeHome.new(File.expand_path(File.dirname(__FILE__) + '/menu1.csv'))
    s.menu.should == [[[4.00, "ham_sandwich"],[8.00, "burrito"]], [[5.00, "ham_sandwich"], [6.50, "burrito"]]]
  end

  it "translates menus into an internal state" do
    subject.menu.should == [[[4.00, "ham_sandwich"],[8.00, "burrito"]], [[5.00, "ham_sandwich"], [6.50, "burrito"]]]
  end

  describe "optimizer" do
    it "returns 2,11.5 for sample data" do
      subject.optimize("ham_sandwich","burrito").
        should == [2,11.5]
    end

    it "returns 2,11.5 even if there are more expensive items that match" do
      sample << [2, 8.00, "ham_sandwich"]
      subject.menu = sample
      subject.optimize("ham_sandwich","burrito").
        should == [2,11.5]      
    end

    context "combo meals" do
      
      it "returns 3,10 for the combo meal" do
        sample << [3, 10.0, "ham_sandwich", "burrito"]
        subject.menu = sample
        subject.optimize("ham_sandwich","burrito").
          should == [3,10.0]
      end

      it "returns the combo meal instead of less efficient options" do
        sample = [[1,6.0,'ham_sandwich'], 
                      [1,6.0,'burrito'], 
                      [1, 10.0, "ham_sandwich", "burrito"]]
        subject.menu = sample
        subject.optimize("ham_sandwich","burrito").
          should == [1,10.0]
      end

      it "returns the combo meal instead of less efficient options" do
        sample = [[1,6.0,'ham_sandwich'], 
                      [1,6.0,'burrito'], 
                      [1, 10.0, "ham_sandwich", "burrito"]]
        subject.menu = sample
        subject.optimize("ham_sandwich","burrito").
          should == [1,10.0]
      end

    end
  end

  context "given examples" do
    it "returns nil" do
      sample = [
                [3, 4.00, "blt_sandwich"],
                [3, 8.00, "chicken_wings"],
                [4, 5.00, "chicken_wings"],
                [4, 2.50, "coffee"]
               ]
      subject.menu = sample
      subject.optimize("blt_sandwich","coffee").
        should == nil
    end

    it "returns 6,11" do
      sample = [
                [5, 4.00, 'fish_sandwich'],
                [5, 8.00, 'milkshake'],
                [6, 5.00, 'milkshake'],
                [6, 6.00, 'fish_sandwich', "blue_berry_muffin", "chocolate_milk"]
               ]
      subject.menu = sample
      subject.optimize("milkshake","fish_sandwich").
        should == [6,11.0]
    end
  end
end

describe "wrapper" do

  it "should return the simple case" do
    executable = File.expand_path(File.dirname(__FILE__) + '/../bin/program')
    csv        = File.expand_path(File.dirname(__FILE__) + '/menu1.csv')
    `#{executable} #{csv} ham_sandwich burrito`.should == "2,11.5"
  end

end
