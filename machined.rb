require 'bundler'
Bundler.require :default, config.environment.to_sym

if config.environment == 'production'
  # Compress javascripts and stylesheets
  config.compress = true

  # Generate digests for assets URLs
  # config.digest_assets = true

  # Create gzipped versions of javascripts and stylesheets
  # config.gzip_assets = true
end

helpers do
  def project_path
    File.expand_path('../', __FILE__)
  end

  def images_path
    File.join(project_path, 'assets', 'images')
  end

  def me
    'Axis Imagery Design'
  end

  def page_name
    {
      :page1 => 'Photo Galleries',
      :page2 => 'Architectural Photography',
      :page3 => 'Interior Photography',
      :page5 => 'Buttons',
      :page4 => '360 virtual tour',
      :page6 => 'About Axis Imagery',
      :page7 => 'Contact Axis Imagery',
    }
  end

  def carousel_items(path)
    # ensure path exists
    collection_path = File.join(images_path, path)
    raise "Path not found: #{collection_path}" unless File.directory?(collection_path)

    # find all the images at images/path
    images = Dir[File.join(collection_path, '*.jpg')]

    # create a hash with each image name
    images.map do |image|
      basename = File.basename(image)
      image_asset_path = image_path "#{path}/#{basename}"
      ActiveSupport::HashWithIndifferentAccess.new({ :path => image_asset_path })
    end
  end

#  def thumbnail(href='#', img_src="http://placehold.it/260x180",
#                title='Title', caption='Caption')
#    li = %(
#      li.span3
#        a.thumbnail href='#{href}': img src='#{img_src}'
#        h5 #{title}
#        p #{caption}
#    )
#  end
end
