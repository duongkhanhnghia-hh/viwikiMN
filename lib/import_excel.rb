require 'roo'

module ImportExcel
  @EDIT_SIGN = "=>"
  @sheet
  @last_row
  @last_col

  def self.import_data(file_name)
    # Get path's file
    file_path = get_relative_path(file_name)
    @sheet = Roo::Excelx.new(file_path)

    first_row = @sheet.first_row
    @last_row = @sheet.last_row

    first_col = @sheet.first_column
    @last_col = @sheet.last_column

    roots = get_roots(first_row, first_col)
    roots.each do |root_node|
      if root_node[:type] == "cat"
        cat_db = add_category_to_db(root_node)
        add_children_to_cat(cat_db)
      else
        add_article_to_db(root_node[:name])
      end
    end
  end

  private
    def self.get_roots(first_row, first_col)
      root_cats = Array.new
      crt_row = first_row
      crt_col = first_col

      while crt_row <= @last_row do
        crt_cell = get_cell(crt_row, crt_col)
        if crt_cell[:name].length != 0
          root_cats.push(crt_cell)
        end
        crt_row += 1
      end
      return root_cats
    end

    def self.add_children_to_cat(cat_db)
      if cat_db[:record] != nil
        children = get_children_of_cat(cat_db[:tree_node][:pos])
        children[:list].each do |child_node|
          if child_node[:type] == "cat"
            child_db = add_category_to_db(child_node)
            if child_db[:record] != nil
              child_db[:record].move_to_child_of(cat_db[:record])
              add_children_to_cat(child_db)
            end
          else
            add_article_to_db(child_node, cat_db[:record].id)
          end
        end
      end
    end

    def self.get_children_of_cat(cat_pos)
      children = {
          :parent_pos => cat_pos,
          :list => Array.new
      }

      child_row = cat_pos[0]
      child_col = cat_pos[1] + 1

      first_child = get_cell(child_row, child_col)

      if first_child[:name].length == 0
        return children
      else
        children[:list].push(first_child)
        child_row += 1

        left_cell_name = @sheet.cell(child_row, child_col - 1).to_s;
        while left_cell_name.length == 0 && child_row <= @last_row do
          crt_cell = get_cell(child_row, child_col)
          if crt_cell[:name].length != 0
            children[:list].push(crt_cell)
          end

          child_row += 1
          left_cell_name = @sheet.cell(child_row, child_col - 1).to_s;
        end
      end
      return children
    end

    def self.add_category_to_db(cat_node)
      if cat_node[:new_name].length == 0
        cat_record = Category.find_or_create_by(name: cat_node[:name])
      else
        cat_record = Category.find_by(name: cat_node[:name])
        if cat_record != nil
          cat_record.name = cat_node[:new_name]
          cat_record.save
        end
      end

      return {
          :tree_node => cat_node,
          :record => cat_record
      }
    end

    def self.add_article_to_db(article_node, category_id = nil)
      if article_node[:new_name].length == 0
        article_record = Article.find_by(name: article_node[:name])
        if article_record == nil
          article_record = Article.create(name: article_node[:name], category_id: category_id, created_at: Time.now.to_s(:db), updated_at: Time.now.to_s(:db))
        end
      else
        article_record = Article.find_by(name: article_node[:name])
        if article_record != nil
          article_record.name = article_node[:new_name]
          article_record.save
        end
      end
      return article_record
    end

    def self.get_cell(row, col)
      cell_string = @sheet.cell(row, col).to_s
      new_name = ""

      if cell_string.index(@EDIT_SIGN) != nil
        part = cell_string.partition(@EDIT_SIGN)
        old_name = part[0].strip
        new_name = part[2].strip
      else
        old_name = cell_string.strip
      end

      return {
          :type => get_cell_type(row, col),
          :name => old_name,
          :new_name => new_name,
          :pos => [row, col]
      }
    end

    def self.get_cell_type(row, col)
      return @sheet.font(row, col).bold? ? "cat" : "article"
    end

    def self.get_relative_path(file_name)
      return "./uploads/" + file_name
    end
end