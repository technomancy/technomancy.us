dnl -*- html -*-
define(__timestamp, 2006-12-29T21:12:56Z)dnl
define(__title, `how i learned to stop worrying and love^H^H^H^H tolerate ecmascript')dnl
define(__id, 66)dnl
include(header.html)
<style>
table {
  border-collapse:  collapse;
  padding:  0;
}
th,  td {
  padding:  .1em .3em;
  white-space:  nowrap;
}

th { 
     font-size:  80%;
     width:  4.5em;
}

td.deselected-time
{ 
  background-color:  #BBCCEE;
  border:  1px #3f8591 solid;
}

td.selected-time
{ 
  border:  1px #3f8591 solid;
  background-color:  #DDEEFF;
}
</style>

<p>I know,  I know,  this has
  been <a href='http://technomancy.us/48'>long
  overdue</a>. But I've finally bit the bullet and dove into enough
  Javascript to get <a href='/sample/concourse'>Concourse</a> all
  shiny and slick. There have been a few other new features,  but the
  big thing that this new version brings is a usable hour selection
  widget: </p>

<table        onmousedown="clickWeek(event);"
       onmousemove="moveWeek(event);"
       onmouseup="releaseWeek(event);"
              id="week1">
  <thead>
    <tr><th>&nbsp;</th>

      	<th>Nov 26</th>
    	<th>Nov 27</th>

    	<th>Nov 28</th>
    	<th>Nov 29</th>
    	<th>Nov 30</th>
    </tr>
  </thead>

  <tbody>
          <tr>

	<td>4: 00 PM</td>
	
		  <td  title=""
	      id="w1d0h16"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-26][16]" name="times[2006-11-26][16]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d1h16"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-27][16]" name="times[2006-11-27][16]" type="checkbox" value="1" />

	  </td>

		  <td  title=""
	      id="w1d2h16"
	      class="deselected-time">
	      <input id="times[2006-11-28][16]" name="times[2006-11-28][16]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d3h16"
	      class="deselected-time">
	      <input id="times[2006-11-29][16]" name="times[2006-11-29][16]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d4h16"
	      class="deselected-time">
	      <input id="times[2006-11-30][16]" name="times[2006-11-30][16]" type="checkbox" value="1" />

	  </td>
	      </tr>
          <tr>
	<td>5: 00 PM</td>
	
		  <td  title=""
	      id="w1d0h17"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-26][17]" name="times[2006-11-26][17]" type="checkbox" value="1" />

	  </td>

		  <td  title=""
	      id="w1d1h17"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-27][17]" name="times[2006-11-27][17]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d2h17"
	      class="deselected-time">
	      <input id="times[2006-11-28][17]" name="times[2006-11-28][17]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d3h17"
	      class="deselected-time">
	      <input id="times[2006-11-29][17]" name="times[2006-11-29][17]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d4h17"
	      class="deselected-time">
	      <input id="times[2006-11-30][17]" name="times[2006-11-30][17]" type="checkbox" value="1" />

	  </td>
	      </tr>
          <tr>
	<td>6: 00 PM</td>

	
		  <td  title=""
	      id="w1d0h18"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-26][18]" name="times[2006-11-26][18]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d1h18"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-27][18]" name="times[2006-11-27][18]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d2h18"
	      class="deselected-time">
	      <input id="times[2006-11-28][18]" name="times[2006-11-28][18]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d3h18"
	      class="deselected-time">
	      <input id="times[2006-11-29][18]" name="times[2006-11-29][18]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d4h18"
	      class="deselected-time">
	      <input id="times[2006-11-30][18]" name="times[2006-11-30][18]" type="checkbox" value="1" />

	  </td>

	      </tr>
          <tr>
	<td>7: 00 PM</td>
	
		  <td  title=""
	      id="w1d0h19"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-26][19]" name="times[2006-11-26][19]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d1h19"
	      class="selected-time">
	      <input checked="checked" id="times[2006-11-27][19]" name="times[2006-11-27][19]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d2h19"
	      class="deselected-time">
	      <input id="times[2006-11-28][19]" name="times[2006-11-28][19]" type="checkbox" value="1" />

	  </td>
		  <td  title=""
	      id="w1d3h19"
	      class="deselected-time">
	      <input id="times[2006-11-29][19]" name="times[2006-11-29][19]" type="checkbox" value="1" />

	  </td>

		  <td  title=""
	      id="w1d4h19"
	      class="deselected-time">
	      <input id="times[2006-11-30][19]" name="times[2006-11-30][19]" type="checkbox" value="1" />

	  </td>
	      </tr>
      </tbody>
</table>

<div id='select-rect' style='position:  absolute; display:  none; background-color:  #feffd2; opacity:  0.5; border:  1px #ffce05 solid;'
     onmousemove="moveWeek(event);" onmouseup="releaseWeek();"></div>

<script
   src="/prototype.js"
   type="text/javascript"></script>

<script
   src="/effects.js"
   type="text/javascript"></script>

<script type="text/javascript">
//<![CDATA[
toggleCheckboxes();
madrobbyDisableSelection();

var selectedColor = '#DDEEFF';
var deselectedColor = '#BBCCEE';
var dragging;
var dragStartPos;
var dragStartElement;
var dragEndElement;
var dragStartState;

function clickWeek(event){
  if(!event) { event = window.event; } // for IE compatibility
  if(isCell(Event.element(event))){
    dragging = true;
    dragStartPos = adjustedCoords(event);
    dragStartElement = Event.element(event);
    dragStartState = cellCheckbox(dragStartElement).checked;
    drawRegion(dragStartPos,  dragStartPos,  event);
  }
  else {releaseWeek();}
}

function moveWeek(event){
  if(!event) { event = window.event; } // for IE compatibility
  if(dragging) {
    drawRegion(dragStartPos,  adjustedCoords(event),  event);
  }
  return false;
}

function releaseWeek(){
  if(dragging){
    dragging = false;
    Element.hide($('select-rect'));
    selectRegion(dragStartElement,  dragEndElement);
  }
}

function drawRegion(start,  end,  event){
  if(outOfBounds(event)){ return; }
  dragEndElement = Event.element(event);
  Element.show($('select-rect'));

  $('select-rect').style.top = Math.min(start[1],  end[1]) + "px";
  $('select-rect').style.height = Math.abs(start[1] - end[1]) + "px";
  $('select-rect').style.left = Math.min(start[0],  end[0]) + "px";
  $('select-rect').style.width = Math.abs(start[0] - end[0]) + "px";
}

function selectRegion(start,  end){
  $R(Math.min(cellHour(start),  cellHour(end)),  Math.max(cellHour(start),  cellHour(end))).each(function(hour) {
      $R(Math.min(cellDay(start),  cellDay(end)),  Math.max(cellDay(start),  cellDay(end))).each(function(day) {
	  selectCell($('w' + cellWeek(start) + 'd' + day + 'h' + hour));
	})
	})
}

function selectCell(cell){
  new Effect.Highlight(cell);
  if(dragStartState){
    // Browser bug:  changing class does not always change color!
    cell.style.backgroundColor = deselectedColor;
//    if(cellCheckbox(cell).checked && cellCount(cell).innerHTML > '0') {cellCount(cell).innerHTML = parseInt(cellCount(cell).innerHTML) - 1;}
    }
  else{
    cell.style.backgroundColor = selectedColor;
//    if(!cellCheckbox(cell).checked) {cellCount(cell).innerHTML = parseInt(cellCount(cell).innerHTML) + 1;}
  }
  cellCheckbox(cell).checked = !dragStartState;
}


function adjustedCoords(event){ // get absolute coords rather than relative to scrolling
  return [Event.pointerX(event),  Event.pointerY(event)];
}

function outOfBounds(event) {
  if (!isCell(Event.element(event)) || !isCell(dragStartElement)) {return true;}
  if (cellWeek(dragStartElement) != cellWeek(Event.element(event))) { return true; }
}

function isCell(elem) {
  if(!elem) { return false; }
  return !! elem.id.match(/w\d+d\d+h\d+/);
}

function cellWeek(cell) {
  return parseInt(cell.id.match(/w(\d*)/)[1]);
}

function cellDay(cell) {
  return parseInt(cell.id.match(/d(\d*)/)[1]);
}

function cellHour(cell) {
  return parseInt(cell.id.match(/h(\d*)/)[1]);
}

function disableSelection(element) {
    element.onselectstart = function() {
        return false;
    };
    element.unselectable = "on";
    element.style.MozUserSelect = "none";
    element.style.cursor = "default";
}

function madrobbyDisableSelection() {
  if(/MSIE/.test(navigator.userAgent)) {
    document.onselectstart = function(event) {
      if(/td/i.test(Event.element(window.event).tagName))
	return false;
    };
  } else { // assume DOM
    document.onmousedown = function(event) {
      if(/td/i.test(Event.element(event).tagName))
	return false;
    };
  }
}

function fixColor(elem) {
  // this is necessary because a refresh will reset the colors but keep the checkboxes the same
  elem.style.backgroundColor = elem.childNodes[1].checked ? selectedColor :  deselectedColor;
}

function toggleCheckboxes() {
  $$('table input').each(function(c){Element.toggle(c)});
}

function cellCheckbox(cell) {
  return $$("#" + cell.id + " input")[0];
}

function cellCount(cell) {
  return $$("#" + cell.id + " span")[0];
}
//]]>
</script>

<p><b>Update</b>:  Aggregators seem to be stripping out the fancy JS, 
so if you see a bunch of checkboxes,  you're seeing the degraded
version. <a href='http://technomancy.us/66'>See the
original</a>.</p>

<p>Before this was implemented,  my poor users had to click a separate
checkbox for each hour they wanted to select. Clearly sub-optimal! Now
they can bask in the shininess of Javascript. <strike>Provided,  of course, 
that they're using a Gecko-based browser. Support for IE and KHTML is
still in the works</strike>.</p>

<p><b>Update</b>:  IE,  Konqueror,  and Safari are now supported.</p>

<p>Other than that, the remaining work is quite trivial. Several
people I've mentioned this to have responded with something along
the lines of, "Oh... I really need something that can do that!" This
provided the motivation for me to dust off the old repository and
get cracking.</p>

<p>The biggest thing about developing in Javascript that really annoys
me is that it's very difficult to do without using the mouse. Ever
since switching to <a href='http://sawmill.sf.net'>the Sawfish window
manager</a> I've been quite spoiled by my newfound ability to do
nearly everything from the keyboard&mdash;but Javascript wrecks this,  and
I've got an ache in my shoulder to prove it. Hopefully once I dig into
some <a
href='http://mir.aculo.us/2006/9/16/adventures-in-javascript-testing'>unit
testing for Javascript</a>,  things will improve.</p>

include(footer.html)
