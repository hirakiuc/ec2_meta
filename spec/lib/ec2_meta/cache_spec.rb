require 'spec_helper'

RSpec.describe Ec2Meta::Cache do
  include HelperMacros

  let(:cache) { Ec2Meta::Cache.new }
  subject(:hash) { instance_variable(cache, :@cache) }

  describe '#initialize' do
    subject { cache }
    it 'create cache instance' do
      expect(subject).to be_an_instance_of(Ec2Meta::Cache)
      expect(hash).to eq({})
    end
  end

  describe '#write' do
    let(:key) { '/path/to/meta' }
    let(:value) { 'idxxxx' }
    subject { cache.write(key, value) }

    it 'save to hash' do
      expect(subject).to eq(value)
      expect(hash[key]).to eq(value)
    end
  end

  describe '#read' do
    let(:key) { '/path/to/meta' }
    let(:value) { 'idxxxx' }

    subject { cache.read(key) }

    context 'without cache' do
      it { expect(subject).to be_nil }
    end

    context 'with cache' do
      before { cache.write(key, value) }
      it { expect(subject).to eq(value) }
    end
  end

  describe '#fetch' do
    let(:key) { '/path/to/meta' }
    let(:value) { 'idxxxx' }

    context 'without block' do
      subject { cache.fetch(key) }

      context 'and without cache' do
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'and with cache' do
        before { cache.write(key, value) }
        it { expect(subject).to eq(value) }
      end
    end

    context 'with block' do
      subject { cache.fetch(key, &block) }

      context 'and without cache' do
        let(:block) { proc { value } }
        it { expect(subject).to eq(value) }
      end

      context 'and with cache' do
        let(:block) { proc { fail ArgumentError } }
        before { cache.write(key, value) }
        it 'fetch cached value without calling block' do
          expect { subject }.not_to raise_error
          expect(subject).to eq(value)
        end
      end
    end
  end

  describe '#exist?' do
    let(:key) { '/path/to/meta' }
    let(:value) { 'idxxxx' }
    subject { cache.exist?(key) }

    context 'without cache' do
      it { expect(subject).to be_falsey }
    end

    context 'with cache' do
      before { cache.write(key, value) }
      it { expect(subject).to be_truthy }
    end
  end

  describe '#delete' do
    let(:key) { '/path/to/meta' }
    let(:value) { 'idxxxx' }
    subject { cache.delete(key) }

    context 'without cache' do
      it { expect(subject).to be_nil }
    end

    context 'with cache' do
      before { cache.write(key, value) }
      it { expect(subject).to eq(value) }
    end
  end

  describe '#clear' do
    subject { cache.clear }

    context 'without cache' do
      it 'makes hash empty' do
        expect(subject).to eq({})
        expect(hash).to be_empty
      end
    end

    context 'with some caches' do
      before do
        cache.write('/path/to/meta', 'meta')
        cache.write('/path/to/attr', 'attr')
      end
      it 'makes hash empty' do
        expect(subject).to eq({})
        expect(hash).to be_empty
      end
    end
  end
end
