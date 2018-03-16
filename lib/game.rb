require_relative 'table'
require_relative 'pieces'

table = Table.new
table.print_table
h = pawn "B4", table.state
table.move "B4", h[0]
table.print_table
