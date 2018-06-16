module Roadmap

    def get_roadmap(roadmap_id)
      response = self.class.get(api_url("roadmaps/#{roadmap_id}"), headers: { "authorization" => @auth_token })
      @roadmap = JSON.parse(response.body)
      p @roadmap
    end

    def get_checkpoint(checkpoints_id)
      response = self.class.get(api_url("checkpoints/#{checkpoints_id}"), headers: { "authorization" => @auth_token })
      @checkpoint = JSON.parse(response.body)
      p @checkpoint
    end

end
