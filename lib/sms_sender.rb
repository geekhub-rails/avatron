class SmsSender
  XML_TEMPLATE = <<~XML
  <?xml version="1.0" encoding="utf-8"?>
  <request>
    <operation>SENDSMS</operation>
    <message start_time="AUTO" end_time="AUTO" lifetime="4" rate="120" desc="My first campaign " source="SMS">
      <body>%s</body>
      <recipient>%s</recipient>
    </message>
  </request>
  XML
  def initialize(recipient, text)
    @recipient = recipient
    @text = text
  end

  def send_sms
    return unless Rails.env.production?
    uri = URI.parse('http://svitsms.com/api/api.php')
    phone = @recipient
    text = @text

    header = {
      'Content-Type': 'text/xml'
    }
    xml = format(XML_TEMPLATE, text, phone)
    puts xml
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = false
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri, header)
    login = Rails.application.credentials.svitsms[:login]
    password = Rails.application.credentials.svitsms[:password]
    request.body = xml
    request.basic_auth login, password

    #request.use_ssl = false

    # Send the request
    response = http.request(request)


    puts response.code
    puts response.body

  end
end
