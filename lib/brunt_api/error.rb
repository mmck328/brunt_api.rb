module BruntAPI
  class ClientError < StandardError
  end

  class UnauthorizedError < ClientError
    def initialize
      super('Unauthorized or authorization expired. Login and retry.')
    end
  end

  class ForbiddenError < ClientError
    def initialize
      super('Access forbidden.')
    end
  end

  class NotFoundError < ClientError
    def initialize
      super('Resource not found.')
    end
  end

  class ServiceUnavailableError < ClientError
    def initialize
      super('API is currently unavailable.')
    end
  end
end