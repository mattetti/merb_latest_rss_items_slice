if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  require 'feed_tools'
  
  Merb::Plugins.add_rakefiles "merb_latest_rss_items_slice/merbtasks", "merb_latest_rss_items_slice/slicetasks", "merb_latest_rss_items_slice/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :merb_latest_rss_items_slice
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:merb_latest_rss_items_slice][:layout] ||= :merb_latest_rss_items_slice
  Merb::Slices::config[:merb_latest_rss_items_slice][:feed] ||= "http://merbist.com/feed"
  Merb::Slices::config[:merb_latest_rss_items_slice][:item_structure] ||= {:title => 'title', :link => 'link', :date => 'pubDate', :author => 'dc:creator', :description => 'description', :body => 'content:encoded'}
  
  # All Slice code is expected to be namespaced inside a module
  module MerbLatestRssItemsSlice
    
    # Slice metadata
    self.description = "MerbLatestRssItemsSlice is a chunky Merb slice!"
    self.version = "0.0.1"
    self.author = "Matt Aimonetti"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(MerbLatestRssItemsSlice)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :merb_latest_rss_items_slice_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.match('/latest-news(.:format)').to(:controller => 'main', :action => 'index').name(:index)
      # the slice is mounted at /merb_latest_rss_items_slice - note that it comes before default_routes
      # scope.match('/').to(:controller => 'main', :action => 'index').name(:home)
      # enable slice-level default routes by default
      scope.default_routes
    end
    
  end
  
  # Setup the slice layout for MerbLatestRssItemsSlice
  #
  # Use MerbLatestRssItemsSlice.push_path and MerbLatestRssItemsSlice.push_app_path
  # to set paths to merb_latest_rss_items_slice-level and app-level paths. Example:
  #
  # MerbLatestRssItemsSlice.push_path(:application, MerbLatestRssItemsSlice.root)
  # MerbLatestRssItemsSlice.push_app_path(:application, Merb.root / 'slices' / 'merb_latest_rss_items_slice')
  # MerbLatestRssItemsSlice.push_app_path(:stylesheet, MerbLatestRssItemsSlice.root / 'public' / 'stylesheets')
  # ...
  #
  # Any component path that hasn't been set will default to MerbLatestRssItemsSlice.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  MerbLatestRssItemsSlice.setup_default_structure!
  
  # Add dependencies for other MerbLatestRssItemsSlice classes below. Example:
  # dependency "merb_latest_rss_items_slice/other"
  
end