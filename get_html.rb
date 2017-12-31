
require 'fileutils'
FileUtils.mkdir_p 'pages'

entry_ids = [*163..186, 188, *211..235]

entry_ids.map.with_index do |entry, episode|
  url = "http://gundamserifu.blog.fc2.com/blog-entry-#{entry}.html"
  file_name = "pages/ep#{(episode + 1).to_s.rjust(2, '0')}.html"
  File.write file_name, `curl #{url}`
end
