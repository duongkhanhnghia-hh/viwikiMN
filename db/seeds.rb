# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cntt = Category.create!(:name => 'Công nghệ thông tin')
th = Category.create!(:name => 'Toán học')
vl = Category.create!(:name => 'Vật lý')

cnpm = Category.create!(:name => 'Công nghệ phần mềm')
cnpm.move_to_child_of(cntt)

khmt = Category.create!(:name => 'Khoa học máy tính')
khmt.move_to_child_of(cntt)
mmt = Category.create!(:name => "Mạng máy tính")
mmt.move_to_child_of(cntt)


kt = Category.create!(:name => 'Kiểm thử')
ppht = Category.create!(:name => 'Phương pháp hình thức')
kt.move_to_child_of(cnpm)
ppht.move_to_child_of(cnpm)

Article.create(name: 'Kiểm thử hộp đen', category_id: kt.id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db));
Article.create(name: 'Kiểm thử hộp trắng', category_id: kt.id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db));

Article.create(name: 'Alloy', category_id: ppht.id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db));
Article.create(name: 'SMT Solver', category_id: ppht.id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db));

Article.create(name: 'Mô hình OSI', category_id: mmt.id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db));
Article.create(name: 'TCP/IP', category_id: mmt.id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db));
