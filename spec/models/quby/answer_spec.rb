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
          :scores => [],
          :score_builders => {},
          :actions => [],
          :completion => nil,
          :default_answer_value => {},
          :last_update => Time.now,
          )
    end

    before do
      Answer.any_instance.stub(:questionnaire) { questionnaire }
    end

    describe '#value_by_values' do
      it 'returns an empty hash when value is nil' do
        Answer.new.value_by_values.should eq({})
      end
    end

    describe '#value_by_regular_values' do
      it 'returns an empty hash when value is nil' do
        Answer.new.value_by_regular_values.should eq({})
      end
    end

    describe "#scores" do
      let(:answer) { Answer.create! }

      it "should be initialized as an empty hash" do
        answer.scores.should eq({})
      end

      it 'can be accessed with indifferent access' do
        answer = Answer.create!(scores: {:tot => {label: 'Totaal', value: 4}})
        answer = Answer.find(answer.id)
        answer.scores[:tot][:label].should == 'Totaal'
        answer.scores["tot"]["value"].should == 4
      end
    end

    describe '#actions' do
      it 'is initialized with empty hash' do
        answer = Answer.create!
        answer.actions.should == {}
      end

      it 'can be accessed with indifferent access' do
        answer = Answer.create!(actions: {:alarm => [:v1, :v2]})
        answer = Answer.find(answer.id)
        answer.actions[:alarm].should == [:v1, :v2]
        answer.actions["alarm"].should == [:v1, :v2]
      end
    end

    describe '#patient_id' do
      let(:answer) { Answer.create! }

      it 'returns the patient[:id]' do
        answer[:patient][:id] = 123
        answer.patient_id.should == 123
      end

      it 'returns the patient_id if set in attributes' do
        answer[:patient_id] = 123
        answer.patient_id.should == 123
      end
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