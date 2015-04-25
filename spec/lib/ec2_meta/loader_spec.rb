require 'spec_helper'

RSpec.describe Ec2Meta::ApiLoader do
  describe 'self.api_module' do
    subject { Ec2Meta::ApiLoader.api_module(api_version) }

    context 'with supported api_version' do
      let(:api_version) { '2014-02-25' }
      it { expect(subject).to eq(Ec2Meta::Api20140225::Base) }
    end

    context 'with not supported api_version' do
      let(:api_version) { 'unknown_version' }
      it { expect { subject }.to raise_error(Ec2Meta::NotSupported) }
    end
  end
end
