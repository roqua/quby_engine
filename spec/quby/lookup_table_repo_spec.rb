require 'spec_helper'

describe Quby::LookupTableRepo::Disk do
  subject {Quby.lookup_table_repo}

  it 'Quby.lookup_table_repo is a disk repo by default' do
    expect(subject).to be_an_instance_of(described_class)
  end

  describe '#retrieve' do
    it 'reads the csv file' do
      expect(CSV).to receive(:read).and_call_original
      subject.retrieve 'test'
    end

    it 'fails when csv file is not found' do
      expect { subject.retrieve 'not_there' }.to raise_error(Errno::ENOENT)
    end
  end
end
