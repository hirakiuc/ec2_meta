require 'pry'
require 'rubygems'
require 'bundler/setup'

require 'ec2_meta'
require 'pry'

client = Ec2Meta.client

m = client.meta_data

puts '#ami-id'
p m.ami_id

puts '#ami-launch-index'
p m.ami_launch_index

puts '#ami-manifest-path'
p m.ami_manifest_path

puts '#ancestor-ami-ids'
p m.ancestor_ami_ids

puts '#block-device-mapping/ami'
p m.block_device_mapping.ami

# TODO: change no
puts '#block-device-mapping/ebs0'
p m.block_device_mapping.ebs(0)

# TODO: change no
puts '#block-device-mapping/ephemeral0'
p m.block_device_mapping.ephemeral(0)

puts '#block-device-mapping/root'
p m.block_device_mapping.root

puts '#block-device-mapping/swap'
p m.block_device_mapping.swap

puts '#hostname'
p m.hostname

puts '#iam/info'
p m.iam.info

# TODO: change role-name
puts '#iam/security-credentials/#{role-name}'
p m.iam.security_credentials('role-name')

puts '#instance-action'
p m.instance_action

puts '#instance-id'
p m.instance_id

puts '#instance-type'
p m.instance_type

puts '#kernel-id'
p m.kernel_id

puts '#local-hostname'
p m.local_hostname

puts '#local-ipv4'
p m.local_ipv4

puts '#mac'
p m.mac

puts '#network/interfaces/macs/0'
#p m.network.interfaces.macs(0)

puts '#network/interfaces/macs/0/device-number'
p m.network.interfaces.macs(0).device_number

p m.network.interfaces.macs(m.mac).device_number

### network/interfaces/macs/#{mac}
puts '-------------'
mac = m.network.interfaces.macs('mac')

puts '#network/interfaces/macs/#{mac}/device-number'
p mac.device_number

puts '#network/interfaces/macs/#{mac}/ipv4-associations/#{public-ip}'
p mac.ipv4_associations('public-ip')

puts '#network/interfaces/macs/#{mac}/local-hostname'
p mac.local_hostname

puts '#network/interfaces/macs/#{mac}/local-ipv4s'
p mac.local_ipv4s

puts '#network/interfaces/macs/#{mac}/mac'
p mac.mac

puts '#network/interfaces/macs/#{mac}/owner-id'
p mac.owner_id

puts '#network/interfaces/macs/#{mac}/public-hostname'
p mac.public_hostname

puts '#network/interfaces/macs/#{mac}/public-ipv4s'
p mac.public_ipv4s

puts '#network/interfaces/macs/#{mac}/security-groups'
p mac.security_groups

puts '#network/interfaces/macs/#{mac}/security-group-ids'
p mac.security_group_ids

puts '#network/interfaces/macs/#{mac}/subnet-id'
p mac.subnet_id

puts '#network/interfaces/macs/#{mac}/subnet-ipv4-cidr-block'
p mac.subnet_ipv4_cidr_block

puts '#network/interfaces/macs/#{mac}/vpc-id'
p mac.vpc_id

puts '#network/interfaces/macs/#{mac}/vpc-ipv4-cidr-block'
p mac.vpc_ipv4_cidr_block

puts '-------------'

puts '#placement/availability-zone'
p m.placement.availability_zone

puts '#product-codes'
p m.product_codes

puts '#public-hostname'
p m.public_hostname

puts '#public-keys/0/openssh-key'
p m.public_keys(0).openssh_key

puts '#ramdisk-id'
p m.ramdisk_id

puts '#security-groups'
p m.security_groups

puts '#reservation_id'
p m.reservation_id

puts '#security-groups'
p m.security_groups

puts '#services/domain'
p m.services.domain

puts '#spot/termination-time'
p m.spot.termination_time
