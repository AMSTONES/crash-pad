class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def index?
      return true
    end

    def show?
      return true
    end

    def create?
      return true
    end
  end
end
