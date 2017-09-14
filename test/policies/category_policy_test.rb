require 'test_helper'

class CategoryPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = build(:user)
    @admin.add_role :admin

    @user = build(:user)

    @category = create(:category)
    @sub_category = create(:category)
    @sub_category.move_to_child_of @category

    @sub_sub_category = create(:category)
    @sub_sub_category.move_to_child_of @sub_category

    @other_category = create(:category)
  end

  test "admin should be able to create category" do
    category_policy = CategoryPolicy.new(@admin, @category)
    assert category_policy.new?

    category_policy = CategoryPolicy.new(@admin, @sub_sub_category)
    assert category_policy.new?
  end

  test "editor should be able to create sub-category they manage" do
    editor = build(:user)
    editor.add_role :editor, @category

    category_policy = CategoryPolicy.new(editor, @sub_sub_category)

    assert category_policy.new?
  end

  test "editor should not be able to create top level category" do
    editor = build(:user)
    editor.add_role :editor, @category

    category_policy = CategoryPolicy.new(editor, @other_category)

    assert_not category_policy.new?
  end

  test "editor should not be able to create sub-category they doesn't manage" do
    editor = build(:user)
    editor.add_role :editor, @other_category

    category_policy = CategoryPolicy.new(editor, @sub_sub_category)

    assert_not category_policy.new?
  end

  test "normal user should not be able to create category" do
    category_policy = CategoryPolicy.new(@user, @category)

    assert_not category_policy.new?
  end

  test "editor cannot see category they doesn't manage" do
    editor = build(:user)
    editor.skip_confirmation!
    editor.save!
    editor.add_role :editor, @category

    category_policy = CategoryPolicy.new(editor, @category)

    assert category_policy.scope.include? @sub_category
    assert_not category_policy.scope.include? @other_category
  end
end
