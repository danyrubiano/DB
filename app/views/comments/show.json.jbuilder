json.id @comment.id
json.user_id @comment.user_id
json.post_id @comment.post_id
json.body @comment.body
json.anonimo @comment.anonimo
json.created_at @comment.created_at
json.updated_at @comment.updated_at


json.user  do
  json.email @comment.user.email
end

