
node[:deploy].each do |application, deploy|
  default[:deploy][application][:symlinks] = { 'config/redis.yml' => 'config/redis.yml' }
end


