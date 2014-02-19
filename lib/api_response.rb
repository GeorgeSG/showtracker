# Provides an abstraction for API responses
class APIResponse
  STATUSES = {
    '200' => 'OK',
    '201' => 'Created',
    '400' => 'Bad request',
    '401' => 'Unauthorized'
  }.freeze

  attr_accessor :data, :status

  def initialize(status = 200, data = {})
    @data, @status = data, status
  end

  def response
    response = { status: status, message: STATUSES[status.to_s] }
    response.merge(data: data) unless data.empty?
    response.to_json
  end
end
