# -*- coding:utf-8 -*-

require 'stringio'
require 'oga'
require 'csv'

def extract_text(doc)
  doc.map { |line|
    line.children.select { |elem| elem.instance_of? Oga::XML::Text }
  }
  .compact
  .flatten
  .map { |text| text.text }
end

(1..50).each do |episode|
  html = File.read "pages/ep#{episode.to_s.rjust(2, '0')}.html"
  doc = Oga.parse_html(html).xpath '/html/body//div[@class="mainEntryBlock"]//div[@class="mainEntryBody"]/span'
  texts = extract_text(doc)
  data = texts.map.with_index { |text, i|
    line_set = text.gsub(/「|」/, '')
      .gsub(/・{2,}/, '…')
      .split('：')
      .reject { |t| t.empty? }
    line_set.unshift texts[i - 1][0] if line_set.size == 1
    line_set.to_csv
  }
  .join
  File.write "pages/ep#{episode.to_s.rjust(2, '0')}.csv", data
end


