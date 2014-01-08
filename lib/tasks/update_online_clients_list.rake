namespace :clients do
  task :update_online => :environment do

    loop do
      clients = $redis.get("online_clients") || []
      message = {id: "client_list", message: clients}
      p "=== update online task client_list: #{clients}"
      PrivatePub.publish_to("/chats/talk", :message => message.to_json)
      sleep 2
    end

  end
end
