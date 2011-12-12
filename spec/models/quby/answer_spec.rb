require 'spec_helper'

module Quby
  describe Answer do
    let(:questionnaire) do
      stub(:key => "foo",
          :name => "Foo", 
          :questions => [stub(:key => "q1", 
                              :type => :open, 
                              :text_var => "a",
                              :question_group => nil,
                              :hidden? => false,
                              :parent => nil,
                              :depends_on => [],
                              :validations => [{:type => :requires_answer}],
                              :extra_data => {})], 
          :scores => [])
    end

    before do
      Answer.any_instance.stub(:questionnaire) { questionnaire }
    end

    describe "#completed_at" do
      let(:answer) { Answer.create! }
      let(:time)   { Time.gm(2011, 11, 5, 11, 24, 00) }

      it "should record the time when answer is completed" do
        Timecop.freeze(time) { answer.update_attributes!(:q1 => "Foo") }
        answer.completed_at.should == time
      end

      it "should record the time when answer is aborted" do
        Timecop.freeze(time) { answer.update_attributes!(:aborted => true) }
        answer.completed_at.should == time
      end

      it "should not be set upon creation" do
        answer.completed_at.should_not be
      end

      it "should not change when answer was previously completed" do
        Timecop.freeze(time) { answer.update_attributes!(:q1 => "Foo") }
        answer.update_attributes!(:q1 => "Bar")
        answer.completed_at.should == time
      end
    end
  end
end