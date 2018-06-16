require 'httparty'
require 'json'


class Kele
  include HTTParty
  base_uri = 'https://www.bloc.io/api/v1'
  attr_accessor :url, :auth_token

  def new(email, password)
    initialize(email, password)
  end

  def initialize(email, password)
    response = self.class.post(api_url("sessions"), { body: {email: email, password: password}})
    @auth_token = response["auth_token"]
    raise "Incorrect Credentials" if @auth_token == nil
  end

  def get_me
    response = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
    @user = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end


  private
  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
