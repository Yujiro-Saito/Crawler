# -*- coding: utf-8 -*-
require 'robotex'
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'anemone'

urls = []

urls.push("https://www.amazon.co.jp/gp/top-sellers/food-beverage/ref=crw_ratp_ts_food-beverage")
urls.push("https://www.amazon.co.jp/gp/top-sellers/computers/ref=crw_ratp_ts_computers")

Anemone.crawl(urls,depth_limit:0) do |anemone|
  anemone.on_every_page do |page|
    doc = Nokogiri::HTML.parse(page.body.toutf8)
    category = doc.xpath("//*[@id='zg_listTitle']").text

    puts "カテゴリ名: #{category}"
    #1-3位
    for critical in 1..3 do
      cpath = "//*[@id='zg_critical']/div[#{critical}]/div[1]/div/div[2]/a/div"
      criticalItem = doc.xpath(cpath).text
      puts "商品ランク: #{critical}, 商品名: #{criticalItem}"
    end
    #4位-20位
    for nonCritical in 1..17 do
      npath = "//*[@id='zg_nonCritical']/div[#{nonCritical}]/div[1]/div/div[2]/a/div"
      nonCriticalItem = doc.xpath(npath).text
      puts "商品ランク: #{nonCritical+3}, 商品名: #{nonCriticalItem}"
    end
  end
end