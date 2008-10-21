class MerbLatestRssItemsSlice::Main < MerbLatestRssItemsSlice::Application
  
  # In memory cache of the feed
  @@feed_cache ||= {}
  
  require 'feed_tools'
  
  def index
    @feed = fetch_from_cache(Merb::Slices::config[:merb_latest_rss_items_slice][:feed])
    @feed_items = @feed.items[0..5]
    @item_structure = Merb::Slices::config[:merb_latest_rss_items_slice][:item_structure]
    render
  end
  
  protected
  
  # Cache feeds for 2 hours
  def fetch_from_cache(url)
    if @@feed_cache[url] && @@feed_cache[url][:date] < (Time.now + 2.hours)
      Merb.logger.info("Loading cached data")
      @@feed_cache[url][:feed]
    else
      Merb.logger.info("Refreshing the cache")
      @@feed_cache[url] = {}
      @@feed_cache[url][:date] = Time.now
      @@feed_cache[url][:feed] = FeedTools::Feed.open(Merb::Slices::config[:merb_latest_rss_items_slice][:feed])
    end
  end
  
end