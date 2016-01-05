require "wikicloth"
require "redcarpet"

# documentation
docs = ["server", "client"]
docs.each do |doc|
  media = File.read("../doc/#{doc}.mediawiki")

  wiki = WikiCloth::Parser.new({
    :data => media,
    :params => {}
  })

  html = wiki.to_html
  html = "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><link rel=\"stylesheet\" href=\"doc.css\" type=\"text/css\" /><title=\"Geometry Tiling Specification: #{doc.capitalize}\" /></head><body>#{html}</body></html>"

  File.write("../doc/#{doc}.html", html)
end

# readme
readme = File.read("../README.md").gsub("mediawiki", "html")
renderer = Redcarpet::Render::HTML.new()
markdown = Redcarpet::Markdown.new(renderer)
index = markdown.render(readme)
index = "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><link rel=\"stylesheet\" href=\"doc/doc.css\" type=\"text/css\" /><title=\"Geometry Tiling Specification\" /></head><body>#{index}</body></html>"
File.write("../index.html", index)
