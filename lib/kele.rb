require 'httparty'
require 'json'
require './lib/roadmap.rb'


class Kele
  include HTTParty
  include Roadmap
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
    p @user
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
    p @mentor_availability
  end

  def get_messages(number)
    if number = nil
      response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token })
    else
      response = self.class.get(api_url("message_threads/#{number}"), headers: { "authorization" => @auth_token })
    end
    @message = JSON.parse(response.body)
    p @message
  end

  def create_message(email, recipent_id, subject)
    response = self.class.get(api_url("messages"), { body: {sender: email, recipient_id: recipient_id, subject: subject}}, headers: { "authorization" => @auth_token })
  end


  private
  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
