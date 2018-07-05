# -*- coding: utf-8 -*-
require "anemone"

URL = "https://www.amazon.co.jp/gp/top-sellers/"

Anemone.crawl(URL, depth_limit:1, skip_query_strings: true) do |anemone|

    anemone.focus_crawl do |page|
  
      page.links.keep_if { |link|
        link.to_s.match(URL)
      } 
    end

    PATTERN = %r[computers|food-beverage]

    anemone.on_pages_like(PATTERN) do |page|

        puts page.url
  
    end

end

