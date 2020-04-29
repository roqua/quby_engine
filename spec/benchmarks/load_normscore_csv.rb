# frozen_string_literal: true

require 'spec_helper'

feature 'Load normscore csv file', benchmark: true do
  it 'loads a csv file' do
    10.times do
      Quby::TableBackend::DiskTree.from_file('test')
    end
  end

  it 'builds a tree' do
    10.times do
      Quby::TableBackend::DiskTree.from_file('test').send :tree
    end
  end
end
