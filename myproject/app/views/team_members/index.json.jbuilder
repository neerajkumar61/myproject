json.array!(@team_members) do |team_member|
  json.extract! team_member, :id, :name, :image, :designation
  json.url team_member_url(team_member, format: :json)
end
