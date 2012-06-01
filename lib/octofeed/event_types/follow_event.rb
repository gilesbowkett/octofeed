module OctoFeed
  class FollowEvent < OctoFeed::Event

    def initialize(json, session=nil)
      super json
      @session = session

      @object = {
        :id => json['payload']['target']['id'],
        :username => json['payload']['target']['login'],
        :avatar => json['payload']['target']['avatar_url'],
        :repos => json['payload']['target']['public_repos'],
        :followers => json['payload']['target']['followers']
      }
    end

    def print
      super({
        :title => "#{gh_link @actor[:username]} started following #{gh_link @object[:username]}"
      })
    end

    def set_user_group
      if @session && @session[:user][:username] == @object[:username]
        opts = {
          :id => "being-followed",
          :title => "#{@object[:username]} new followers",
          :icon => @object[:avatar]
        }
      end

      super opts || {}
    end

  end
end