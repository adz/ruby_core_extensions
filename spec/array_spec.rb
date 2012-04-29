require 'spec_helper'

describe Array do
  
  it "should allow converting to a hash" do
    [[:a,1],[:b,2]].to_hash.should == {:a => 1, :b => 2}
  end
  
  it "should allow converting all values to strings recursively" do
    @now = Time.now
    [1, 2, @now, [3, 4]].stringify_values_recursively.should eql ['1', '2', @now.to_s, ['3', '4']]
  end
  
  it "should allow removing all blank values" do
    a = [1, nil, 3, '']
    a.compact_blank!
    a.should == [1, 3]
  end
  
  it "should allow removing all blank values recursively" do
    a = [1, 2, [" Kan", {}], nil, {:a => "", :b => {}}, ["garoos", "  "]]
    a.recursive_compact_blank!
    a.join.should == "12 Kangaroos"
  end
  
  it "should allow verifying if all elements are blank recursively" do
    ['',nil,[nil,['']]].should be_recursive_blank
    ['',nil,[nil,['',1]]].should_not be_recursive_blank
  end
  
  it "should allow converting to hash given a key" do
    [1,2,3].hash_by(:ordinalize).should == {'1st' => 1, "2nd" => 2, "3rd" => 3}
    [1,2,3].hash_by(:ordinalize, :to_s).should == {'1st' => '1', "2nd" => '2', "3rd" => '3'}
    [1,2,3].hash_by(:ordinalize){ |v| v + 1 }.should == {'1st' => 2, "2nd" => 3, "3rd" => 4}
  end
  
end
