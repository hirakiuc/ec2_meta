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
      let(:expected) { 'ami-id' }
      before { stub('meta-data/ami-id', expected) }
      it { expect(meta_data.ami_id).to eq(expected) }
    end

    describe '#ami_launch_index' do
      let(:expected) { 'index' }
      before { stub('meta-data/ami-launch-index', expected) }
      it { expect(meta_data.ami_launch_index).to eq(expected) }
    end

    describe '#ami_manifest_path' do
      let(:expected) { 'path' }
      before { stub('meta-data/ami-manifest-path', expected) }
      it { expect(meta_data.ami_manifest_path).to eq(expected) }
    end

    describe '#ancestor_ami_ids' do
      let(:expected) { "idxxx\nidyyyy\n" }
      before { stub('meta-data/ancestor-ami-ids', expected) }
      it { expect(meta_data.ancestor_ami_ids).to eq(expected) }
    end

    describe 'block-device-mapping space' do
      describe '#ami' do
        let(:expected) { 'ami' }
        before { stub('meta-data/block-device-mapping/ami', expected) }
        it { expect(meta_data.block_device_mapping.ami).to eq(expected) }
      end

      describe '#ebs(no)' do
        let(:expected) { 'ebs0000' }
        before { stub('meta-data/block-device-mapping/ebs0', expected) }
        it { expect(meta_data.block_device_mapping.ebs(0)).to eq(expected) }
      end

      describe '#ephemeral(no)' do
        let(:expected) { 'ephemeral000' }
        before { stub('meta-data/block-device-mapping/ephemeral0', expected) }
        it { expect(meta_data.block_device_mapping.ephemeral(0)).to eq(expected) }
      end

      describe '#root' do
        let(:expected) { 'root_device' }
        before { stub('meta-data/block-device-mapping/root', expected) }
        it { expect(meta_data.block_device_mapping.root).to eq(expected) }
      end

      describe '#swap' do
        let(:expected) { 'swap_device' }
        before { stub('meta-data/block-device-mapping/swap', expected) }
        it { expect(meta_data.block_device_mapping.swap).to eq(expected) }
      end
    end

    describe '#hostname' do
      let(:expected) { 'sample.host' }
      before { stub('meta-data/hostname', expected) }
      it { expect(meta_data.hostname).to eq(expected) }
    end

    describe 'iam space' do
      describe '#info' do
        let(:expected) { 'iam_info' }
        before { stub('meta-data/iam/info', expected) }
        it { expect(meta_data.iam.info).to eq(expected) }
      end

      describe '#security-credentials(role_name)' do
        let(:role_name) { 'role' }
        let(:expected) { "credentials0\ncredentials1\n" }
        before { stub("meta-data/iam/security-credentials/#{role_name}", expected) }
        it { expect(meta_data.iam.security_credentials(role_name)).to eq(expected) }
      end
    end

    describe '#instance_action' do
      let(:expected) { 'action' }
      before { stub('meta-data/instance-action', expected) }
      it { expect(meta_data.instance_action).to eq(expected) }
    end

    describe '#instance_id' do
      let(:expected) { 'id-xxxx' }
      before { stub('meta-data/instance-id', expected) }
      it { expect(meta_data.instance_id).to eq(expected) }
    end

    describe '#instance_type' do
      let(:expected) { 'm2.micro' }
      before { stub('meta-data/instance-type', expected) }
      it { expect(meta_data.instance_type).to eq(expected) }
    end

    describe '#kernel_id' do
      let(:expected) { 'kid' }
      before { stub('meta-data/kernel-id', expected) }
      it { expect(meta_data.kernel_id).to eq(expected) }
    end

    describe '#local_hostname' do
      let(:expected) { 'host.local' }
      before { stub('meta-data/local-hostname', expected) }
      it { expect(meta_data.local_hostname).to eq(expected) }
    end

    describe '#local_ipv4' do
      let(:expected) { '192.168.0.12' }
      before { stub('meta-data/local-ipv4', expected) }
      it { expect(meta_data.local_ipv4).to eq(expected) }
    end

    describe '#mac' do
      let(:expected) { 'xx:xx:xx:xx' }
      before { stub('meta-data/mac', expected) }
      it { expect(meta_data.mac).to eq(expected) }
    end

    describe 'network space' do
      let(:network) { meta_data.network }

      describe 'interfaces space' do
        let(:interfaces) { network.interfaces }

        describe '#macs' do
          context 'without args' do
            let(:expected) { "xx:xx:xx:xx/\nyy:yy:yy:yy/\n" }
            before { stub('meta-data/network/interfaces/macs/', expected) }
            it { expect(interfaces.macs).to eq(expected.split("\n").map { |v| v.chomp('/') }) }
          end

          context 'with string' do
            pending 'add spec'
          end

          context 'with exist position' do
            pending 'add spec'
          end

          context 'with non-exist position' do
            pending 'add spec'
          end

          describe 'mac space' do
            # ....
          end
        end
      end
    end

    describe 'placement space' do
      describe '#availability_zone' do
        let(:expected) { 'ap-northeast-1b' }
        before { stub('meta-data/placement/availability-zone', expected) }
        it { expect(meta_data.placement.availability_zone).to eq(expected) }
      end
    end

    describe '#product_codes' do
      let(:expected) { "code1\ncode2\n" }
      before { stub('meta-data/product-codes', expected) }
      it { expect(meta_data.product_codes).to eq(expected) }
    end

    describe '#public_hostname' do
      let(:expected) { 'host_name' }
      before { stub('meta-data/public-hostname', expected) }
      it { expect(meta_data.public_hostname).to eq(expected) }
    end

    describe '#public_ipv4' do
      let(:expected) { '192.168.0.10' }
      before { stub('meta-data/public-ipv4', expected) }
      it { expect(meta_data.public_ipv4).to eq(expected) }
    end

    describe 'public_keys space' do
      pending 'add specs'
    end

    describe '#ramdisk_id' do
      let(:expected) { 'ridxxxx' }
      before { stub('meta-data/ramdisk-id', expected) }
      it { expect(meta_data.ramdisk_id).to eq(expected) }
    end

    describe '#reservation_id' do
      let(:expected) { 'idxxxx' }
      before { stub('meta-data/reservation-id', expected) }
      it { expect(meta_data.reservation_id).to eq(expected) }
    end

    describe '#security_groups' do
      let(:expected) { "groupA\ngroupB\n" }
      before { stub('meta-data/security-groups', expected) }
      it { expect(meta_data.security_groups).to eq(expected) }
    end

    describe 'services space' do
      describe '#domain' do
        let(:expected) { 'service_domain' }
        before { stub('meta-data/services/domain', expected) }
        it { expect(meta_data.services.domain).to eq(expected) }
      end
    end

    describe 'spot space' do
      describe '#termination_time' do
        let(:expected) { '2015-01-05T18:02:00Z' }
        before { stub('meta-data/spot/termination-time', expected) }
        it { expect(meta_data.spot.termination_time).to eq(expected) }
      end
    end
  end
end
