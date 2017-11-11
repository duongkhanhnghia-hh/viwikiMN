class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def admin?
      user.has_role? :admin
    end
    def edit1?
      user.has_role? :editor1
    end
    def edit2?
      user.has_role? :editor2
    end
    def edit3?
      user.has_role? :editor3
    end
    def edit4?
      user.has_role? :editor4
    end
    def edit5?
      user.has_role? :editor5
    end
    def edit6?
      user.has_role? :editor6
    end
    def edit7?
      user.has_role? :editor7
    end
    def resolve
      if user.has_role? :admin  or edit1? or edit2? or edit3?
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
  def edit1?
    user.has_role? :editor1 or user.has_role? :admin
  end
  def edit2?
    user.has_role? :editor2 or user.has_role? :admin
  end
  def edit3?
    user.has_role? :editor3 or user.has_role? :admin
  end
  def edit4?
    user.has_role? :editor4 or user.has_role? :admin
  end
  def edit5?
    user.has_role? :editor5 or user.has_role? :admin
  end
  def edit6?
    user.has_role? :editor6 or user.has_role? :admin
  end
  def edit7?
    user.has_role? :editor7 or user.has_role? :admin
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
