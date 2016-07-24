module Kountagios
	module Errors
		class KountagiousError < StandardError; end
		class MissingOauthDetails < KountagiousError; end
		class UnknownResourceAttribute < KountagiousError; end
		class APIError < KountagiousError; end
		class RequestError < KountagiousError; end
	end
end
