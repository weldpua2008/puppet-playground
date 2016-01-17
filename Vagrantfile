Vagrant.configure("2") do |config|
  config.cache.auto_detect = true
  {
    :Centos72_64 => {
      :box     => 'bento/centos-7.2',
    },
    :Centos67_64 => {
      :box     => 'bento/centos-6.7',
    },
    :Ubuntu1404_64 => {
      :box     => 'bento/ubuntu-14.04',
    },
  }.each do |name,cfg|
    config.vm.define name do |local|
      local.vm.box = cfg[:box]
      local.vm.box_url = cfg[:box_url]
#      local.vm.boot_mode = :gui
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.downcase.gsub(/_/, '-').concat(".weldpua2008")
      local.vm.provision :puppet do |puppet|
        puppet.hiera_config_path = 'data/hiera.yaml'
        puppet.working_directory = '/vagrant'
        puppet.manifests_path = "manifests"
        puppet.module_path = "modules"
        puppet.manifest_file = "init.pp"
        puppet.options = [
         '--verbose',
         '--report',
         '--show_diff',
         '--pluginsync',
         '--summarize',
#        '--evaltrace',
#        '--debug',
#        '--parser future',
        ]
      end
    end
  end
end
