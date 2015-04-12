require 'spec_helper'

RSpec.describe 'api 2014-02-25 specs' do
  include ApiMacros

  def stub(path, body)
    api_stub('2014-02-25', path, body)
  end

  def stub_notfound(path)
    api_stub_not_found('2014-02-25', path, '')
  end

  let(:client) { Ec2Meta.client(api_version: '2014-02-25') }
  let(:api_module) { Ec2Meta::Api20140225::MetaData }

  describe '#meta_data' do
    subject { client.meta_data }
    it { expect(subject).not_to eq(nil) }
  end

  describe 'meta-data space' do
    let(:meta_data) { client.meta_data }

    describe '#ami_id' do
      before { stub('meta-data/ami-id', 'ami-id') }
      it { expect(meta_data.ami_id).to eq('ami-id') }
    end

    describe '#ami_launch_index' do
      before { stub('meta-data/ami-launch-index', 'index') }
      it { expect(meta_data.ami_launch_index).to eq('index') }
    end

    describe '#ami_manifest_path' do

    end

    describe '#ancestor_ami_ids' do

    end

    describe '#hostname' do

    end

    describe '#instance_action' do

    end

    describe '#instance_id' do

    end
  end
end
