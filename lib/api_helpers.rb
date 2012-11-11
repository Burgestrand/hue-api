require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'
require 'securerandom'

$root = File.expand_path('../', File.dirname(__FILE__))

module APIHelpers
  STATUSES = {
    200 => '200 OK',
    201 => '201 Created',
    202 => '202 Accepted',
    204 => '204 No Content',
    205 => '205 Reset Content',
    301 => '301 Moved Permanently',
    302 => '302 Found',
    307 => '307 Temporary Redirect',
    304 => '304 Not Modified',
    401 => '401 Unauthorized',
    403 => '403 Forbidden',
    404 => '404 Not Found',
    405 => '405 Method not allowed',
    409 => '409 Conflict',
    422 => '422 Unprocessable Entity',
    500 => '500 Server Error'
  }

  DefaultTimeFormat = "%B %-d, %Y".freeze

  def strftime(time, format = DefaultTimeFormat)
    attribute_to_time(time).strftime(format)
  end

  def headers(status, head = {})
    css_class = (status == 204 || status == 404) ? 'headers no-response' : 'headers'
    lines = ["Status: #{STATUSES[status]}"]
    head.each do |key, value|
      lines << "#{key}: #{value}"
    end

    %(<pre class="#{css_class}"><code>#{lines * "\n"}</code></pre>\n)
  end

  def json(key)
    hash = case key
    when Hash
      h = {}
      key.each { |k, v| h[k.to_s] = v }
      h
    when Array
      key
    else
      path = File.join($root, "examples/#{key}")
      JSON.load File.read(path)
    end

    hash = yield hash if block_given?

    %(<pre class="highlight"><code class="language-javascript">) +
      JSON.pretty_generate(hash) + "</code></pre>"
  end

  def text_html(response, status, head = {})
    hs = headers(status, head.merge('Content-Type' => 'text/html'))
    res = CGI.escapeHTML(response)
    hs + %(<pre class="highlight"><code>) + res + "</code></pre>"
  end
end
