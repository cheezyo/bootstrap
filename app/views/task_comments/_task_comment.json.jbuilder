json.extract! task_comment, :id, :comment, :user_id, :created_at, :updated_at
json.url task_comment_url(task_comment, format: :json)
