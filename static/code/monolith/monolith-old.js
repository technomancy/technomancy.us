var selectedCell;
var player1 = 'red';
var player2 = 'black';
var currentTurn = player1;

function setupBoard() {
    // all cells have value of 0 initially
    $A($$('td')).each(function(td) { td.value = 0; });

    // Dragging shouldn't select text on the board    
    disableSelection($('board'));

    // set the initial pieces in place
    for(x = 1; x < 9; x++)
    {
	own($('cell-3-' + x), player1);
	own($('cell-4-' + x), player1);
	own($('cell-5-' + x), player2);
	own($('cell-6-' + x), player2);
    }
}

function mouseDown(event)
{  
    if(!event) { event = window.event; } // for IE compatibility
    selectedCell = Event.element(event);
    if(owner(selectedCell) != currentTurn)
	{
	    selectedCell = null;
	    alert("Not your turn!");
	    return;
	}
    selectedCell.className = "selected";
}

function mouseUp(event)
{  
    if(!event) { event = window.event; } // for IE compatibility
    move(selectedCell, Event.element(event));
}

function move(from, to)
{
    if(allowedMove(from, to))
	{
	    own(to, currentTurn, from.value + to.value);
	    clear(from);
	    nextTurn();
	}
    else
	{
	    alert("Illegal move!");
	    selectedCell.className = "";
	}
}

function allowedMove(from, to) 
{
    // must move from a cell and to a cell
    if(!from || !to) return false;
    // can't move a cell to itself
    if(from == to) return false;
    // can't move a blank piece
    if(owner(from) != player1 && owner(from) != player2) return false;
    // can't be more than 1 square away
    if(!adjacent(from, to)) return false;
    // must have high enough value if capturing opponent's piece
    if(to.value > 1 && from.value - to.value < 2 && owner(to) != owner(from)) return false;
    return true;
}

function nextTurn()
{
    checkForWinner();
    player = (currentTurn == player1 ? player2 : player1);
    $('turn').innerHTML = player;
    $('turn').style.color = player;
    currentTurn = player;
}

function checkForWinner()
{
    remaining = { red: 0, black: 0};
    $A($$('td')).each(function(cell) {
	    remaining[owner(cell)] += 1; });

    if(remaining.red == 0) win('black');
    if(remaining.black == 0) win('red');
}

function win(player) 
{
    alert(player + ' wins the game!');
}

function own(cell, player, number) 
{
    cell.style.backgroundColor = player;
    if(!number) number = 1;
    cell.innerHTML = number;
    cell.value = number;
}

function clear(cell) 
{
    cell.className = "";
    cell.style.backgroundColor = 'grey';
    cell.innerHTML = "&nbsp";
    cell.value = 0;
}

function owner(cell) 
{
    return cell.style.backgroundColor;
}

function coords(cell)
{
    // gives you [x, y]
    return [cell.id.match("cell-(.)-(.)")[2], cell.id.match("cell-(.)-(.)")[1]];
}

function adjacent(cell1, cell2)
{
    if(Math.abs(coords(cell1)[0] - coords(cell2)[0]) > 1) return false;
    if(Math.abs(coords(cell1)[1] - coords(cell2)[1]) > 1) return false;
    return true;
}

function disableSelection(element) {
    element.onselectstart = function() {
        return false;
    };
    element.unselectable = "on";
    element.style.MozUserSelect = "none";
    element.style.cursor = "default";
}

