module ApiMacros
  def api_stub(api_version, path, body)
    stub_request(:get, request_url(api_version, path))
      .to_return(
        body:   response_body(body),
        status: [200, 'OK']
      )
  end

  def api_stub_not_found(api_version, path, body)
    stub_request(:get, request_url(api_version, path))
      .to_return(
        body:   response_body(body),
        status: [404, 'Not Found']
      )
  end

  def api_stub_timeout(api_version, path)
    stub_request(:get, request_url(api_version, path)).to_timeout
  end

  private

  def request_url(api_version, path)
    [
      Ec2Meta::Fetcher::API_HOST,
      api_version,
      path
    ].join('/')
  end

  def response_body(value)
    value.is_a?(Array) ? value.join("\n") : value
  end
end
