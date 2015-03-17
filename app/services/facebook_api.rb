# Wrapper class for calling
# facebook graph apis with koala.

class FacebookApi

  def initialize(access_token)
    @access_token = access_token
  end


  def get_me(fields = [])
    fields = fields | %w(id, name, email)
    base.get_object('me', {'fields' => fields})
  end

  # likes = graph.graph_call("me/likes", {fields: "id, name"})

  private

  def base
    @base ||= Koala::Facebook::API.new(@access_token, Facebook::SECRET)
  end

end
