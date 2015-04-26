require 'spec_helper'

RSpec.describe Ec2Meta::Fetcher do
  include HelperMacros
  include ApiMacros

  describe '#initialize' do
    context 'without options' do
      subject { Ec2Meta::Fetcher.new }

      it 'create fetcher instance' do
        expect(subject).to be_an_instance_of(Ec2Meta::Fetcher)
        expect(instance_variable(subject, :@options)).to eq({})
        expect(instance_variable(subject, :@cache)).to be_an_instance_of(Ec2Meta::Cache)
      end
    end

    context 'with options' do
      let(:options) { { logger: Ec2Meta::NullLogger.new } }
      subject { Ec2Meta::Fetcher.new(options) }

      it 'create fetcher instance' do
        expect(subject).to be_an_instance_of(Ec2Meta::Fetcher)
        expect(instance_variable(subject, :@options)).to eq(options)
        expect(instance_variable(subject, :@cache)).to be_an_instance_of(Ec2Meta::Cache)
      end
    end
  end

  describe '#fetch' do
    let(:api_version) { Ec2Meta::Fetcher::API_VERSION }
    let(:body) { 'Wow! Some Meta' }
    let(:path) { 'path/to/some/meta' }
    let(:fetcher) do
      Ec2Meta::Fetcher.new(
        logger: Ec2Meta::NullLogger.new
      )
    end

    subject { fetcher.fetch('/' + path) }

    context 'when fetch successfully' do
      before { api_stub(api_version, path, body) }
      it { expect(subject).to eq(body) }
    end

    context 'when timeout occurred' do
      before { api_stub_timeout(api_version, path) }
      it { expect { subject }.to raise_error(Timeout::Error) }
    end

    context 'when server respond \'404\'' do
      before { api_stub_not_found(api_version, path, '') }

      context 'with fail_on_not_found is not true' do
        it { expect(subject).to be_nil }
      end

      context 'with fail_on_not_found is true' do
        let(:fetcher) do
          Ec2Meta::Fetcher.new(
            logger:            Ec2Meta::NullLogger.new,
            fail_on_not_found: true
          )
        end
        it { expect { subject }.to raise_error(Ec2Meta::MetaNotFound) }
      end
    end

    context 'when unexpected eror raised' do
      before do
        expect_any_instance_of(Net::HTTP).to \
          receive(:get).and_raise(ArgumentError)
      end
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
