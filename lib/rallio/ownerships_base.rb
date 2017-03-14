module Rallio
  class OwnershipsBase < Base
    def self.for(access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get("/#{url_segment}", headers: headers)
      response.parsed_response["#{url_segment}"].map { |a| new(a) }
    end

    def self.create(user_id:, payload:)
      response = self.post("/users/#{user_id}/#{url_segment}", headers: app_credentials, body: payload)
      new response.parsed_response["#{response_key}"]
    end

    def self.destroy(user_id:, object_id:)
      self.delete("/users/#{user_id}/#{url_segment}/#{object_id}", headers: app_credentials)
    end
  end
end
