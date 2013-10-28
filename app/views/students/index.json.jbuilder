json.array!(@students) do |student|
  json.extract! student, :name, :email, :school, :city, :country, :year
  json.url student_url(student, format: :json)
end