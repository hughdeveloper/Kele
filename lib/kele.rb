require 'httparty'
require 'json'


class Kele
  include HTTParty
  base_uri = 'https://www.bloc.io/api/v1'
  attr_accessor :url, :authtoken

  def initialize(email, password)
    @authtoken = self.class.post(api_url("sessions"), {:query => {email: email, password: password}})
    raise "Incorrect email or password" if @authtoken == nil
    @authtoken
  end






  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
