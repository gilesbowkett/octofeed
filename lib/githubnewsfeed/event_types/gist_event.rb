module GitHubNewsFeed
  class GistEvent < GitHubNewsFeed::Event

    def initialize(json)
      super json

      @object = {
        :action => json['payload']['action'],
        :id => json['payload']['gist']['id'],
        :url => json['payload']['gist']['html_url'],
        :description => CGI::escapeHTML(json['payload']['gist']['description'])
      }
    end

    def print
      super({
        :title => "#{gh_link @actor[:username]} #{@object[:action]}d #{gh_gist_link @object[:id], @object[:url]}",
        :body => @object[:description]
      })
    end

    def set_user_group
      hash = {
        :id => "#{@actor[:username]}-gist-#{@object[:id]}",
        :title => "#{@actor[:username]} #{gh_gist_link @object[:id], @object[:url]}"
      }
      super hash
    end

  end
end
