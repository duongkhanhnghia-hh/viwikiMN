class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role? :admin
        scope.all
      else
        roles = scope.find_roles(:editor, user)
        cats = roles.collect {|r| r.resource.self_and_descendants}
        cats.reduce {|result, c| result.or(c)}
      end
    end
  end

  def create?
    user.has_role? :admin or record.self_and_ancestors.any? { |cat| user.has_role? :editor, cat }
  end

  def update?
    create?
  end

  def destroy?
    update?
  end

  def reparent?
    record.parent and update? # cannot move top level cat
  end

end
