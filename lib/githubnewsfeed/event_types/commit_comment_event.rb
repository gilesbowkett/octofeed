module GitHubNewsFeed
  class CommitCommentEvent < GitHubNewsFeed::Event

    def initialize(json)
      super json

      @object = {
        :id => json['payload']['comment']['id'],
        :commit => json['payload']['comment']['commit_id'],
        :body => CGI::escapeHTML(json['payload']['comment']['body']),
        :url => json['payload']['comment']['html_url']
      }
    end

    def print
      message = truncate @object[:body]
      message = md_renderer(message)

      super({
        :title => "#{gh_link @actor[:username]} commented on #{gh_link @repo[:name]}",
        :body => %(<span>Comment in #{gh_commit_comment_link @repo[:name], @object[:id], @object[:commit]}</span> <blockquote title="#{@object[:body]}">#{message}</blockquote>)
      })
    end

    def set_repo_group
      hash = {
        :id => "#{@repo[:name]}-commitcomment-#{@object[:commit]}",
        :title => %(#{@repo[:name]} <a href="https://github.com/#{@repo[:name]}/commit/#{@object[:commit]}">commit #{@object[:commit][0..9]}</a>)
      }
      super hash
    end

  end
end
