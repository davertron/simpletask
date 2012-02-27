# Zero pad function for underscore
_.mixin
    zeroFill: (number, width) ->
        width -= number.toString().length
        if (width > 0)
            return new Array( width + ( if /\./.test( number ) then 2 else 1) ).join( '0' ) + number
        return number

$ ->
    $('.dropdown-toggle').dropdown()
    $('.alert').alert()
    $('.sortable').sortable({
        update: (event, ui) ->
            AppView.updateSort()
        handle: '.sort-handle'
    }).disableSelection()

