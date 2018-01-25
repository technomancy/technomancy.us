// monolith.js

// (c) 2007 Phil Hagelberg
// Game concept by Loren Broach

// Players

player1 = { color: 'red' }
player2 = { color: 'black' }

// Board

var board = $('board');

board.setup = function() {
    // Dragging shouldn't select text on the board
    board.onselectstart = function() { return false; } // for IE compatibility
    board.unselectable = "on";
    board.style.MozUserSelect = "none";
    board.style.cursor = "default";

    // Create cells from <td> DOM objects
    this.tds = $A($$('td'));
    this.cells = this.tds.map(function(td) { return new Cell(td); });
    this.render();

    this.whoseTurn = player1;
};

// Toggle whose turn it is and update the readout
board.turn = function() {
    board.checkForWinner();
    board.whoseTurn = (board.whoseTurn == player1 ? player2 : player1);
    $('turn').innerHTML = board.whoseTurn.color;
    $('turn').style.color = board.whoseTurn.color;
};

board.checkForWinner = function () {
    if(!board.cells.find(function(cell) { return cell.player == player1} )) board.win(player2);
    if(!board.cells.find(function(cell) { return cell.player == player2} )) board.win(player1);
};

// Alert the user and disable any more action when the game ends.
board.win = function (player) {
    alert(player.color + " wins the game!\n\nRefresh page to play again.");
    board.onmousedown = null;
    board.onmouseup = null;
};

// Rendering the board consists of rendering each cell
board.render = function() { board.cells.each(function(cell) { cell.render(); }) };

board.onmousedown = function(event) {
    if(!event) { event = window.event; } // for IE compatibility
    board.selectedCell = Event.element(event).cell;
    if(board.selectedCell.player != board.whoseTurn)
	alert("Not your turn!");
    else board.selectedCell.td.className = "selected";
};

board.onmouseup = function(event) {
    if(!event) { event = window.event; } // for IE compatibility
    if(board.selectedCell.move(Event.element(event).cell))
	board.turn();
    board.selectedCell.td.className = '';
    board.render();
};

// Cells

function Cell(td) {
    // x and y values are retrieved from the <td>'s id attribute
    [dummy, this.y, this.x] = td.id.match("cell-(.)-(.)");

    // middle four rows have value
    this.value = this.y < 7 && this.y > 2 ? 1 : 0;

    // set up relationships between DOM object and Cell object
    this.td = td;
    this.td.cell = this;

    // rows 3 and 4 belong to player1; rows 5 and 6 belong to player2
    if(this.y == 3 || this.y == 4) this.player = player1;
    if(this.y == 5 || this.y == 6) this.player = player2;
}

Cell.prototype.move = function(to) {
    if(!this.allowed(to)) {
	alert("Illegal move!");
	return false;
    }
    to.player = this.player;
    to.value = to.value + this.value;
    this.player = null;
    this.value = 0;
    return true;
};

Cell.prototype.allowed = function(to) {
    // must move to a cell
    if(!to) return false;
    // can't move a cell to itself
    if(this == to) return false;
    // can't move a blank piece
    if(this.player != player1 && this.player != player2) return false;
    // can't be more than 1 square away
    if(!this.adjacent(to)) return false;
    // must have high enough value if capturing opponent's piece
    if(to.value > 1 && this.value - to.value < 2 && to.player != this.player) return false;
    return true;
};

Cell.prototype.render = function () {
    if(this.value > 0) this.td.innerHTML = this.value;
    if(this.player) {
	this.td.style.backgroundColor = this.player.color;
    }
    else {
	this.td.style.backgroundColor = 'grey';
	this.td.innerHTML = '&nbsp;';
    }
};

Cell.prototype.adjacent = function(to) {
    return Math.abs(this.x - to.x) < 2 && Math.abs(this.y - to.y) < 2;
};
