json.contents @contents do |content|
  json.partial! 'api/v1/contents/content', content: content
end