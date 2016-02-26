class TeamMembersController < InheritedResources::Base

  # def index
  #   @team_members = TeamMember.all
  # end

  private

    def team_member_params
      params.require(:team_member).permit(:name, :image, :designation, :twitter_link, :facebook_link, :linkedin_link)
    end
end

