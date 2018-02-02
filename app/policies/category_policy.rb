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
  def admin?
      user.has_role? :admin
    end
  def editor?
      for i in 1..Category.all.length
        if user.has_role? :editor, Category.all.find(i) then
          break
        end
      end
      user.has_role? :admin or user.has_role? :editor, Category.all.find(i)
  end
  def create?
    #user.has_role? :admin or @record.ancestors.any? { |cat| user.has_role? :editor, cat }
    user.has_role? :admin or Category.find(@record.parent_id).self_and_ancestors.any? { |cat| user.has_role? :editor, cat }

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
