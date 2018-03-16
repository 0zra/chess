require_relative 'table'
require_relative 'pieces'

table = Table.new
table.print_table
h = pawn "B4", table.state
print h
