require 'spec_helper'

RSpec.describe Ec2Meta::NullLogger do
  subject { Ec2Meta::NullLogger.new }

  describe '#debug' do
    it { expect(subject).to respond_to(:debug).with(1).arguments }
  end

  describe '#debug?' do
    it { expect(subject.debug?).to be_falsey }
  end

  describe '#error' do
    it { expect(subject).to respond_to(:error).with(1).arguments }
  end

  describe '#error?' do
    it { expect(subject.error?).to be_falsey }
  end

  describe '#fatal' do
    it { expect(subject).to respond_to(:fatal).with(1).arguments }
  end

  describe '#fatal?' do
    it { expect(subject.fatal?).to be_falsey }
  end

  describe '#info' do
    it { expect(subject).to respond_to(:info).with(1).arguments }
  end

  describe '#info?' do
    it { expect(subject.info?).to be_falsey }
  end
end
