require 'fakefs/spec_helpers'
require 'spec_helper'

module Quby::Questionnaires::Repos
  describe MemoryRepo do
    it_behaves_like 'a valid backend for the questionnaires api'

    it_behaves_like 'a questionnaire repository' do
      let(:repo) { CachingRepo.new(MemoryRepo.new) }
    end

    it 'reloads a questionnaire if the sourcecode updated' do
      time         = Time.now
      memory_repo  = MemoryRepo.new
      caching_repo = CachingRepo.new(memory_repo)

      Timecop.freeze(time) { memory_repo.create!('foo', 'title "foo"') }

      found_questionnaire = caching_repo.find('foo')
      found_questionnaire.sourcecode.should eq 'title "foo"'

      Timecop.freeze(time + 1.second) { memory_repo.update!('foo', 'title "bar"') }
      found_questionnaire = caching_repo.find('foo')
      found_questionnaire.sourcecode.should eq 'title "bar"'
    end

    it 'uses the cache if a questionnaire sourcecode on disk has not changed' do
      memory_repo  = MemoryRepo.new('foo' => 'title "foo"')
      caching_repo = CachingRepo.new(memory_repo)

      # Preload cache
      caching_repo.find('foo')

      # Second find should hit cache
      expect(memory_repo).not_to receive(:find)
      caching_repo.find('foo')
    end

    it 'can preload all questionnaires' do
      memory_repo  = MemoryRepo.new('foo' => 'title "foo"')
      caching_repo = CachingRepo.new(memory_repo, preload: true)

      # Cache should be warm, so first call to #find should hit the cache
      expect(memory_repo).not_to receive(:find)
      caching_repo.find('foo')
    end
  end
end
