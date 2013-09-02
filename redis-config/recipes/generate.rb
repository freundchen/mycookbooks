include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  # use template ‘redis.yml.erb’ to generate configuration file
  template "#{deploy[:deploy_to]}/current/config/redis.yml" do
    source "redis.yml.erb"
    cookbook "redis-config"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    # define variable “@redis” to be used in the ERB template
    variables(
      :redis => deploy[:redis] || {}
    )

    # ensure the application is restarted after the configuration
    # is generated
    notifies :run, "execute[restart Rails app #{application}]"

    # generate the file only if there actually is a config folder
    only_if do
      File.exists?("#{deploy[:deploy_to]}/current/config/")
    end
  end
end


