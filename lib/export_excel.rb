require 'axlsx'

module ExportExcel
  @sheet
  @category_style
  @article_style

  def self.export_data()
    p = Axlsx::Package.new
    wb = p.workbook
    wb.styles do |s|
      @category_style = s.add_style :b => true,
                                         :sz => 11,
                                         :alignment => {
                                             :horizontal => :center,
                                             :vertical => :center ,
                                               :wrap_text => true
                                         }
      @article_style = s.add_style :b => false,
                                        :sz => 11,
                                        :alignment => {
                                            :horizontal => :center,
                                            :vertical => :center ,
                                            :wrap_text => true
                                        }
    end
    @sheet = wb.add_worksheet(:name => "Worksheet")

    data = get_data()
    data.each do |cat|
      crt_row = @sheet.add_row [cat["name"]], :style => @category_style
      if cat["children"]["cats"].length != 0
        add_children_to_sheet(crt_row, cat, cat["children"]["cats"][0])
      end
    end

    time = Time.new
    filename = "export-" + time.strftime("%H%M%S-%d%m%Y") + ".xlsx"
    p.serialize "export/#{filename}"

    return filename
  end

  private
    def self.add_children_to_sheet(current_row, node, first_child = nil)
      if first_child != nil
        if first_child["children"] == nil
          current_row.add_cell first_child["name"], :style => @article_style
        else
          current_row.add_cell first_child["name"], :style => @category_style
          if first_child["children"]["cats"].length != 0
            add_children_to_sheet(current_row, first_child, first_child["children"]["cats"][0])
          elsif first_child["children"]["arts"].length != 0
            add_children_to_sheet(current_row, first_child, first_child["children"]["arts"][0])
          end
        end

        add_children_to_sheet(current_row, node)
      else
        i = 0
        children = node["children"]
        blank_cells = Array.new
        level = Integer(children["level"])

        while i < level do
          blank_cells.push("")
          i += 1
        end

        drop_at_cat = children["cats"].length != 0 ? true : false
        add_data_rows(blank_cells, children["cats"], children["arts"], drop_at_cat)
      end
    end

    def self.add_data_rows(blank_cells, cats_list, arts_list, drop_at_cat)
      if drop_at_cat
        cats_list.drop(1).each do |cat|
          data_row = create_new_row(blank_cells, cat["name"])
          children = cat["children"]

          if children["cats"].length == 0 && children["arts"] == 0
            @sheet.add_row data_row, :style => @category_style
          else
            crt_row = @sheet.add_row data_row, :style => @category_style
            first_child = children["cats"].length != 0 ? children["cats"][0] : children["arts"][0]
            add_children_to_sheet(crt_row, cat, first_child)
          end
        end

        arts_list.each do |article|
          @sheet.add_row create_new_row(blank_cells, article["name"]), :style => @article_style
        end
      elsif !drop_at_cat && arts_list.length != 0
        arts_list.drop(1).each do |article|
          @sheet.add_row create_new_row(blank_cells, article["name"]), :style => @article_style
        end
      end
    end

    def self.create_new_row(blank_cells, value)
      data_row = Array.new
      return (data_row += blank_cells) << value
    end

    def self.get_data
      root_cats = Array.new
      cats = Category.where(parent_id: nil).as_json
      cats.each do |cat|
        level = 0
        cat_hash = {
            "level" => level,
            "id" => cat["id"],
            "name" => cat["name"],
            "children" => get_children_list(cat["id"], level)
        }

        root_cats.push(cat_hash)
      end

      return root_cats
    end

    def self.get_children_list(cat_id, crt_level)
      # Increase value of children level
      crt_level += 1

      # Get children cats first
      children_cats = Array.new
      children_arts = Array.new

      children_cats_json = Category.where(parent_id: cat_id).as_json
      children_arts_json = Article.where(category_id: cat_id).as_json

      children_cats_json.each do |cat|
        cat_hash = {
            "id" => cat["id"],
            "name" => cat["name"],
            "children" => get_children_list(cat["id"], crt_level)
        }

        children_cats.push(cat_hash)
      end

      children_arts_json.each do |article|
        article_hash = {
            "id" => article["id"],
            "name" => article["name"]
        }

        children_arts.push(article_hash)
      end

      return {
          "level" => crt_level,
          "cats" => children_cats,
          "arts" => children_arts
      }
    end
end
