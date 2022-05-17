class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def update?
    user.id == record.id
  end

  def create?
    true
  end

  def destroy?
    user.id == record.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end