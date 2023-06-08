class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.order(created_at: :desc)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def user_trips?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
