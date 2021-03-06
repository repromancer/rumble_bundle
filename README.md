# RumbleBundle

This is a rudimentary info scraper and command line "browser" for the [Humble Bundle](https://www.humblebundle.com/) website, using plain Ruby and Nokogiri.

Upon firing up, it will scrape the Game Bundles, Book Bundles, and Mobiles Bundles tabs (along with any sub-tabs) for ongoing bundles. Once it's finished, you can query the scraped information via the command prompt.

Available information for each bundle includes: Name, Supported Charities, Donation Tiers and Included Products, Total MSRP, and URL.

Available products can also be filtered by tags like `linux`, or `drm-free`, or multiple at once (`windows linux drm-free`).

## Installation

Install via:
```
$ gem install rumble_bundle
```

## Usage

Run via:
```
$ rumble_bundle
```

Then follow the on-screen prompts. :)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/repromancer/rumble_bundle.

## License

This is free and unencumbered software released into the public domain.

For more information, please refer to the included UNLICENSE.md or <https://unlicense.org>
