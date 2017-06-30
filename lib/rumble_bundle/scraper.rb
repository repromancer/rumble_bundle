# The Scraper class will be responsible for finding the URLs to all available bundles, and parsing them into Bundle instances with Products.

class RumbleBundle::Scraper

  def initialize
    @base_url = 'https://www.humblebundle.com'
    @main_pages = [
      'https://www.humblebundle.com/',
      'https://www.humblebundle.com/books/',
      'https://www.humblebundle.com/mobile/']
  end



  def scrape_bundle(page)
    doc = Nokogiri::HTML(open(page))

    bundle = {
      'name' => '',
      'tiers' => [],
      'products' => [],
      'charities' => [],
      'total_msrp' => ''
    }

    bundle['name'] = doc.css("title").text.chomp("(pay what you want and help charity)").strip

    bundle['charities'] = doc.css(".charity-image-wrapper img").collect{|img| img.attr("alt")}

    #for each tier in bundle
    doc.css(".main-content-row")[0..-3].each do |tier|

      #add tier to Bundle @tiers array
      tier_name = tier.css(".dd-header-headline").text.strip
      bundle['tiers'] << tier_name

      #instantiate products from tier
      tier.css(".game-boxes").each do |box|
        scrape_product(box, tier_name).tap do |product|
          bundle['products'] << product
        end
      end

    end

    bundle['total_msrp'] = doc.css('.hr-tagline-text').detect{|e| /worth/}.text.strip

    RumbleBundle::Bundle.new(bundle)

  end



  def scrape_product(box, tier)

    product = {
      'name' => '',
      'subtitle' => '',
      'bundle' => '',
      'tier' => '',
      'platforms' => [],
      'drm_free' => nil,
      'steam_key' => nil
    }

    product['name'] = box.css(".dd-image-box-caption").text.strip
    product['tier'] = tier
    product['subtitle'] = if box.at_css(".subtitle")
      box.css(".subtitle .callout-msrp").remove
      if box.css(".subtitle").text.strip != ""
        box.css(".subtitle").text.strip
      else
        nil
      end
    end

    product['platforms'] = Array.new.tap do |platforms|
      if box.at_css(".dd-availability-icon > i.hb-android")
        platforms << 'Android'
      end

      if box.at_css(".dd-availability-icon > i.hb-linux")
        platforms << 'Linux'
      end

      if box.at_css(".dd-availability-icon > i.hb-windows")
        platforms << 'Windows'
      end

      if box.at_css(".dd-availability-icon > i.hb-osx")
        platforms << 'Mac'
      end

    end

    product['drm_free'] = box.at_css(".dd-availability-icon > i.hb-drmfree") ?
      true : false

    product['steam_key'] = box.at_css(".dd-availability-icon > i.hb-steam") ?
      true : false

    RumbleBundle::Product.new(product)

  end

end