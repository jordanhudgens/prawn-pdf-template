require 'prawn/table'
require 'prawn'
require 'date'

pdf = Prawn::Document.new

pdf.font "Helvetica"

# Defining the grid 
# See http://prawn.majesticseacreature.com/manual.pdf
pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10)

pdf.grid([0,0], [1,1]).bounding_box do
  # Setting up image
  logo = "images/logo.png"
  pdf.image logo, :at => [170,160], :width => 200

  # pdf.text  "INVOICE", :size => 18
  pdf.text "Invoice No: 0001", :align => :left
  pdf.text "Customer No: 0001", :align => :left
  pdf.text "Name: Taylor Swift", :align => :left
  pdf.text "Location: Somewhere, TX", :align => :left
  
  pdf.text "Work Description:", :align => :left
  pdf.move_down 10
  pdf.bounding_box([0,100], :width => 380, :height => 90) do
     pdf.stroke_bounds
  end
end

pdf.grid([0,3.6], [1,4]).bounding_box do 
  # Displays the image in your PDF. Dimensions are optional.
  pdf.move_down 10
  pdf.text "Job No: 2342342342", :align => :left
  pdf.text "Date: 1/1/14", :align => :left
  pdf.text "No:", :align => :left
  pdf.text "No:", :align => :left
  pdf.text "Start:", :align => :left
  pdf.text "Stop:", :align => :left
  pdf.text "Start:", :align => :left
  pdf.text "Stop:", :align => :left
end

# pdf.text "Details of Invoice", :style => :bold_italic
# pdf.stroke_horizontal_rule


temp_arr = [{:stock_number => '1SE', :hours => "10", :description => "Some cool description stuff", :rate => "15.00", :sub_total => "1500.00"},
            {:stock_number => '2SE', :hours => "15", :description => "Some 2SE description stuff", :rate => "11.00", :sub_total => "1100.00"},
            {:stock_number => '3MA', :hours => "12", :description => "Some 3MA description stuff", :rate => "19.00", :sub_total => "500.00"},
            {:stock_number => '84JD3', :hours => "11", :description => "Some 84JD3 description stuff", :rate => "20.00", :sub_total => "900.00"},
            {:stock_number => '83MEA', :hours => "11", :description => "83MEA cool description stuff", :rate => "110.00", :sub_total => "1250.00"}]

pdf.move_down 10
items = [["Stock No.","Hours", "Description", "Rate", "Subtotal"]]
items += temp_arr.each_with_index.map do |item, i|
  [
    item[:stock_number],
    item[:hours],
    item[:description],
    item[:rate],
    item[:sub_total]
  ]
end
items += [["", "59", "", "", "5250.00"]]


pdf.table items, :header => true, 
  :column_widths => { 0 => 60, 1 => 42, 2 => 300, 3 => 60, 4 => 60, 5 => 60}, :row_colors => ["d2e3ed", "FFFFFF"] do
    style(columns(3)) {|x| x.align = :right }
end


# pdf.move_down 40
# pdf.text "Terms & Conditions of Sales"
# pdf.text "1.  All cheques should be crossed and made payable to Awesomeness Ptd Ltd"

# pdf.move_down 40
# pdf.text "Received in good condition", :style => :italic

pdf.move_down 20
pdf.text "Ordered by:     ___________________________________          Incomplete         Complete"

# pdf.move_down 10
# pdf.stroke_horizontal_rule

# pdf.bounding_box([pdf.bounds.right - 50, pdf.bounds.bottom], :width => 60, :height => 20) do
#   pagecount = pdf.page_count
#   pdf.text "Page #{pagecount}"
# end

pdf.render_file "invoice.pdf"