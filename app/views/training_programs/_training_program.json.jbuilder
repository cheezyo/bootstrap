json.extract! training_program, :id, :prog_number, :prog_url, :prog_name, :created_at, :updated_at
json.url training_program_url(training_program, format: :json)
