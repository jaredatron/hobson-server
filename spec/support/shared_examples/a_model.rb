shared_examples_for "a model" do

  describe "#as_json" do
    it "should return its attributes plus id" do
      subject.as_json.should == subject.attributes.merge('id' => subject.instance_variable_get(:@id))
    end
  end

  describe "#to_json" do
    it "should return json" do
    end
  end


end
