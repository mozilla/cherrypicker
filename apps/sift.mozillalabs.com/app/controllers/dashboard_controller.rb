class DashboardController < ApplicationController
  
  before_filter :authenticate
  
  def index
    dir_prefix_size = "#{Rails.root}/public".size
    #TODO: The javascript that will be included here, will be sandboxed, as will the CSS.
    @css_files = Dir["#{Rails.root}/public/renderers/*/**/*.css"].map{|p| p[dir_prefix_size..-1]}
    @js_files = Dir["#{Rails.root}/public/renderers/*/**/*.js"].map{|p| p[dir_prefix_size..-1]}
    
    
    #TODO: This should probably be pulled up into a model.
    @renderers = Dir["#{Rails.root}/public/renderers/*"].map do |renderer_path|
      source = renderer_path[(dir_prefix_size + 11)..-1]
      
      template_path = "#{renderer_path}/template.html"
      
      template = nil
      template = Sanitize.clean(File.read(template_path), Sanitize::Config::RELAXED) if File.exist?(template_path)
      
      
      {:template => template, :source => source}
    end
    
  end
end
