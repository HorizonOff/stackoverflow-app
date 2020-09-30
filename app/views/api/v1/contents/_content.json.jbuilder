json.id content.id
json.title content.title
json.views_count content.views_count

json.question do
  json.body content.question.body
  json.vote_score content.question.vote_score
  json.user_id content.question.user.id
  json.created_at content.question.created_at
end
