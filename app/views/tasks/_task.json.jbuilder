json.extract! task, :id, :task, :task_category_id, :player_id, :done, :done_date, :progress, :created_at, :updated_at
json.url task_url(task, format: :json)
