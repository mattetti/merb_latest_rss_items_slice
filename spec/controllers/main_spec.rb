require File.dirname(__FILE__) + '/../spec_helper'

describe "MerbLatestRssItemsSlice::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { add_slice(:MerbLatestRssItemsSlice) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(MerbLatestRssItemsSlice::Main, :index)
    controller.slice.should == MerbLatestRssItemsSlice
    controller.slice.should == MerbLatestRssItemsSlice::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(MerbLatestRssItemsSlice::Main, :index)
    controller.status.should == 200
    controller.body.should contain('MerbLatestRssItemsSlice')
  end
  
  it "should work with the default route" do
    controller = get("/merb_latest_rss_items_slice/main/index")
    controller.should be_kind_of(MerbLatestRssItemsSlice::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/merb_latest_rss_items_slice/index.html")
    controller.should be_kind_of(MerbLatestRssItemsSlice::Main)
    controller.action_name.should == 'index'
  end
    
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(MerbLatestRssItemsSlice::Main, 'index')
    
    url = controller.url(:merb_latest_rss_items_slice_default, :controller => 'main', :action => 'show', :format => 'html')
    url.should == "/merb_latest_rss_items_slice/main/show.html"
    controller.slice_url(:controller => 'main', :action => 'show', :format => 'html').should == url
    
    url = controller.url(:merb_latest_rss_items_slice_index, :format => 'html')
    url.should == "/merb_latest_rss_items_slice/index.html"
    controller.slice_url(:index, :format => 'html').should == url
    
    url = controller.url(:merb_latest_rss_items_slice_home)
    url.should == "/merb_latest_rss_items_slice/"
    controller.slice_url(:home).should == url
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(MerbLatestRssItemsSlice::Main, :index)
    controller.public_path_for(:image).should == "/slices/merb_latest_rss_items_slice/images"
    controller.public_path_for(:javascript).should == "/slices/merb_latest_rss_items_slice/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/merb_latest_rss_items_slice/stylesheets"
    
    controller.image_path.should == "/slices/merb_latest_rss_items_slice/images"
    controller.javascript_path.should == "/slices/merb_latest_rss_items_slice/javascripts"
    controller.stylesheet_path.should == "/slices/merb_latest_rss_items_slice/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    MerbLatestRssItemsSlice::Main._template_root.should == MerbLatestRssItemsSlice.dir_for(:view)
    MerbLatestRssItemsSlice::Main._template_root.should == MerbLatestRssItemsSlice::Application._template_root
  end

end