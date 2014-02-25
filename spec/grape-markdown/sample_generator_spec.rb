require 'spec_helper'

describe GrapeMarkdown::SampleGenerator do
  include_context 'configuration'

  before do
    GrapeMarkdown.config do |config|
      config.name               = name
      config.description        = description
      config.include_root       = false
    end
  end

  let(:blueprint) { GrapeMarkdown::Document.new(SampleApi) }
  let(:resource)  { blueprint.resources.first }

  subject { GrapeMarkdown::SampleGenerator.new(resource) }

  it 'creates a sample hash from a resource' do
    expect(subject.sample).to be_a(Hash)
  end

  context '#request' do
    it 'creates a sample request in JSON form' do
      expect { JSON.parse(subject.request) }.to_not raise_error
    end
  end

  context '#response' do
    it 'creates a sample response in JSON form' do
      expect { JSON.parse(subject.response) }.to_not raise_error
    end

    it 'includes a sample id' do
      expect(JSON.parse(subject.response)['id']).to_not be(nil)
    end
  end
end
