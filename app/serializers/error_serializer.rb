class ErrorSerializer
  def self.serializer(error, status)
    {
      errors: [
        {
          status: status,
          message: error
        }
      ]
    }
  end
end