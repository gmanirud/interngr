json.array!(@recruiters) do |recruiter|
  json.extract! recruiter, :name, :email, :company, :city, :country
  json.url recruiter_url(recruiter, format: :json)
end