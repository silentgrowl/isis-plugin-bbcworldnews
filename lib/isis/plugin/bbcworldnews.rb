require "rss"

module Isis
  module Plugin
    class BBCWorldNews < Isis::Plugin::Base
      def respond_to_msg?(msg, speaker)
        msg.downcase == '!bbc'
      end

      private

      def response_html
        output = %Q[<img src='http://i.imgur.com/jxh78YE.png'> ISIS World News Report] +
                %Q[- #{timestamp} #{zone} (powered by BBC World News)<br>]
        feed_items.each do |item|
          output += %Q[<a href="#{item.link}">#{item.title}</a><br>]
        end
        output
      end

      def response_md
        output = %Q[ISIS World News Report] +
                %Q[- #{timestamp} #{zone} (powered by BBC World News)\n]
        feed_items.each do |item|
          output += "<#{item.link}|#{item.title}>\n"
        end
        output
      end

      def response_text
        output = []
        output.push %Q(ISIS World News Report - #{timestamp} #{zone}) +
                    %Q{ (powered by BBC World News)}
        feed_items.each do |a|
          output.push %Q(#{item.title} - #{item.link})
        end
        output
      end

      def feed_items
        feed = RSS::Parser.parse(open('http://feeds.bbci.co.uk/news/rss.xml'))
        feed.items.take(5)
      end
    end
  end
end
