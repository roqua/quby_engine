# frozen_string_literal: true

require 'spec_helper'

describe 'wait_for' do
  it 'fails if the wait_max time is exceeded' do
    expect { wait_for(wait_max: 0.1, step: 0.05) { false } }.to raise_error("Timeout of 0.1 seconds exceeded!")
  end

  it 'waits until the block returns true' do
    @test = 0
    time = Time.now
    wait_for(step: 0.05) { @test += 1; @test == 5 }
    expect(@test).to eq(5)
    expect(time).to be < 0.20.seconds.ago
  end
end
