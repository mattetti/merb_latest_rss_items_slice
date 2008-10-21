module Merb
  module MerbLatestRssItemsSlice
    module ApplicationHelper
      
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def image_path(*segments)
        public_path_for(:image, *segments)
      end
      
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def javascript_path(*segments)
        public_path_for(:javascript, *segments)
      end
      
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def stylesheet_path(*segments)
        public_path_for(:stylesheet, *segments)
      end
      
      # Construct a path relative to the public directory
      # 
      # @param <Symbol> The type of component.
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def public_path_for(type, *segments)
        ::MerbLatestRssItemsSlice.public_path_for(type, *segments)
      end
      
      # Construct an app-level path.
      # 
      # @param <Symbol> The type of component.
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path within the host application, with added segments.
      def app_path_for(type, *segments)
        ::MerbLatestRssItemsSlice.app_path_for(type, *segments)
      end
      
      # Construct a slice-level path.
      # 
      # @param <Symbol> The type of component.
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path within the slice source (Gem), with added segments.
      def slice_path_for(type, *segments)
        ::MerbLatestRssItemsSlice.slice_path_for(type, *segments)
      end
      
      def item_link(item)
        item.find_node("#{@item_structure[:link]}/text()")
      end
      
      def item_title(item)
        item.find_node("#{@item_structure[:title]}/text()")
      end
      
      def item_author(item)
        item.find_node("#{@item_structure[:author]}/text()")
      end
      
      def item_body(item)
        item.find_node("#{@item_structure[:body]}/text()")
      end
      
      def item_description(item)
        item.find_node("#{@item_structure[:description]}/text()")
      end
      
      def item_date(item)
        Time.rfc2822(item.find_node("#{@item_structure[:date]}/text()").to_s).strftime("%Y-%m-%d")
      end
      
    end
  end
end