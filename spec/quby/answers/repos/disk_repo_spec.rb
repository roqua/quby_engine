require 'spec_helper'
require 'tmpdir'

module Quby::Answers::Repos
  describe DiskRepo do
    let(:tmpdir) { Dir.mktmpdir }

    after do
      FileUtils.remove_entry tmpdir
    end

    it_behaves_like "an answer repository" do
      let(:repo) { described_class.new(tmpdir) }
    end

    it_behaves_like 'a valid backend for the answers api' do
      let(:repo) { described_class.new(tmpdir) }
    end
  end
end
