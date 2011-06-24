module Mozilla
  class BrowserId
    
    include HTTParty
    
    base_uri 'https://browserid.org'
    
    def verify(assertion, audience)
      response = BrowserId.get('/verify', :query => {:assertion => assertion, :audience => audience})
      response.symbolize_keys!
      response[:success] = response[:status] == 'okay'
      return response
    end
  end
end
