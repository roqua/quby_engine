# frozen_string_literal: true

require 'spec_helper'

feature 'Load normscore csv file', benchmark: true do
  it 'loads a csv file' do
    10.times do
      Quby.csv_repo.retrieve('test')
    end
  end

  it 'builds a tree' do
    data = Quby.csv_repo.retrieve('test')
    10.times do
      Quby::TableBackend::DiskTree.new(data).send :tree
    end
  end
end
