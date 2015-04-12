require 'spec_helper'

RSpec.describe Ec2Meta do
  describe '#client' do
    subject { Ec2Meta.client }
    it { expect(subject).to be_instance_of(Ec2Meta::Client) }
  end
end
