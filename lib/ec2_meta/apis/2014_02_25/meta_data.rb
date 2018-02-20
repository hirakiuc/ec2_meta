# frozen_string_literal: true

module Ec2Meta
  module Api20140225
    module MetaData
      def meta_data
        MetaData.new(fetcher, 'meta-data')
      end

      class BlockDeviceMapping < Ec2Meta::Api::Path
        # Fetch 'block-device-mapping/ami'
        def ami
          fetch('ami')
        end

        # Fetch 'block-device-mapping/ebs#{no}'
        def ebs(no)
          fetch("ebs#{no}")
        end

        # Fetch 'block-device-mapping/ephemeral#{no}'
        def ephemeral(no)
          fetch("ephemeral#{no}")
        end

        # Fetch 'block-device-mapping/root'
        def root
          fetch('root')
        end

        # Fetch 'block-device-mapping/swap'
        def swap
          fetch('swap')
        end
      end

      class Iam < Ec2Meta::Api::Path
        # Fetch 'iam/info'
        def info
          fetch('info')
        end

        # Fetch 'iam/security-credentials/#{role_name}'
        def security_credentials(role_name)
          fetch("security-credentials/#{role_name}")
        end
      end

      class Network < Ec2Meta::Api::Path
        def interfaces
          Interfaces.new(fetcher, new_prefix('interfaces'))
        end
      end

      class Interfaces < Ec2Meta::Api::Path
        def macs(mac = nil)
          case mac
          when ::String
            mac_address_for(mac)
          when ::Integer
            mac_address_at(mac)
          when nil
            fetch_macs
          else
            ::Kernel.raise ::ArgumentError, 'require String or Integer, or nil.'
          end
        end

        private

        def fetch_macs
          result = fetch('macs/')
          (result.nil? ? [] : result.split("\n").map { |v| v.chomp('/') })
        end

        def mac_address_for(address)
          MacAddress.new(fetcher, new_prefix("macs/#{address}"), address)
        end

        def mac_address_at(position)
          addr = fetch_macs.at(position)
          return nil if addr.nil?

          mac_address_for(addr)
        end
      end

      class MacAddress < Ec2Meta::Api::Path
        def initialize(fetcher, prefix, mac_addr)
          super(fetcher, prefix)
          @mac_addr = mac_addr
        end

        # Fetch network/interfaces/macs/#{mac}/device-number
        def device_number
          fetch('device-number')
        end

        # Fetch network/interfaces/macs/#{mac}/ipv4-associations/#{public-ip}
        def ipv4_associations(public_ip)
          fetch("ipv4-associations/#{public_ip}")
        end

        # Fetch network/interfaces/macs/#{mac}/local-hostname
        def local_hostname
          fetch('local-hostname')
        end

        def local_ipv4s
          fetch('local-ipv4s')
        end

        def mac
          fetch('mac')
        end

        def owner_id
          fetch('owner-id')
        end

        def public_hostname
          fetch('public-hostname')
        end

        def public_ipv4s
          fetch('public-ipv4s')
        end

        def security_groups
          fetch('security-groups')
        end

        def security_group_ids
          fetch('security-group-ids')
        end

        def subnet_id
          fetch('subnet-id')
        end

        def subnet_ipv4_cidr_block
          fetch('subnet-ipv4-cidr-block')
        end

        def vpc_id
          fetch('vpc-id')
        end

        def vpc_ipv4_cidr_block
          fetch('vpc-ipv4-cidr-block')
        end
      end

      class Placement < Ec2Meta::Api::Path
        def availability_zone
          fetch('availability-zone')
        end
      end

      class PublicKeys < Ec2Meta::Api::Path
        def initialize(fetcher, prefix, no)
          super(fetcher, prefix)
          @key_no = no
        end

        def openssh_key
          fetch('openssh-key')
        end
      end

      class Services < Ec2Meta::Api::Path
        def domain
          fetch('domain')
        end
      end

      class Spot < Ec2Meta::Api::Path
        def termination_time
          fetch('termination-time')
        end
      end

      class MetaData < Ec2Meta::Api::Path
        %w[
          ami-id
          ami-launch-index
          ami-manifest-path
          ancestor-ami-ids
          hostname
          instance-action
          instance-id
          instance-type
          kernel-id
          local-hostname
          local-ipv4
          mac
          product-codes
          public-hostname
          public-ipv4
          ramdisk-id
          reservation-id
          reservation-id
          security-groups
        ].each do |attr|
          define_method(attr.tr('-', '_')) do
            fetch(attr)
          end
        end

        def block_device_mapping
          BlockDeviceMapping.new(fetcher, new_prefix('block-device-mapping'))
        end

        def iam
          Iam.new(fetcher, new_prefix('iam'))
        end

        def network
          Network.new(fetcher, new_prefix('network'))
        end

        def placement
          Placement.new(fetcher, new_prefix('placement'))
        end

        def public_keys(no)
          PublicKeys.new(fetcher, new_prefix("public-keys/#{no}"), no)
        end

        def services
          Services.new(fetcher, new_prefix('services'))
        end

        def spot
          Spot.new(fetcher, new_prefix('spot'))
        end
      end
    end
  end
end
