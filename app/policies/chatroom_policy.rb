class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where('creator_id = :user_id OR participant_id = :user_id', user_id: user.id)
    end
  end

  def show?
    true
  end

  def create?
    true
  end
end
