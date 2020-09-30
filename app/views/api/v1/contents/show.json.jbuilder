json.content do
  json.partial! 'api/v1/contents/content', content: @content

  json.tags @content.tags do |tag|
    json.partial! 'api/v1/tags/tag', tag: tag
  end

  json.answers @content.answers do |answer|
    json.partial! 'api/v1/answers/answer', answer: answer
  end
end
