node[:deploy].each do |app_name, deploy_config|

  # use template ‘redis.yml.erb’ to generate configuration file
  template "#{deploy_config[:deploy_to]}/current/config/redis.yml" do
    source "redis.yml.erb"
    cookbook "redis-config"

    # set mode, group and owner of generated file
    mode "0660"
    group deploy_config[:group]
    owner deploy_config[:user]

    # define variable “@redis” to be used in the ERB template
    variables(
      :redis => deploy_config[:redis] || {}
    )

    # generate the file only if there actually is a config folder
    only_if do
      File.exists?("#{deploy_config[:deploy_to]}/current/config/")
    end
  end
end


