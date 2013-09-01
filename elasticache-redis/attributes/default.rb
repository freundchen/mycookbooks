node[:deploy].each do |application, deploy|
  default[:deploy][application][:symlink_before_migrate] = { 'config/redis.yml' => 'config/redis.yml' }
end
