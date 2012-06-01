module OctoFeed
  class PublicEvent < OctoFeed::Event

    def initialize(json)
      super json
    end

    def print
      super({
        :title => "#{gh_link @actor[:username]} open sourced #{gh_link @repo[:name]}"
      })
    end

  end
end