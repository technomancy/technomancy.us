dnl -*- html -*-
define(__title, `All posts')dnl
include(header.html)
define(`fordown',`ifelse($#,0,``$0'',`ifelse(eval($2>=$3),1,
    `pushdef(`$1',$2)$4`'popdef(`$1')$0(`$1',decr($2),$3,`$4')')')')dnl
define(`__year', esyscmd(`date -u --iso-8601 | head -c 4'))dnl
<div id="list">
  <h4>__year</h4>
<ul>
fordown(`__i',__latest,1,
  `undefine(`__title') undefine(`__timestamp') divert(-1) include(__i.m4) divert(1)dnl
  ifelse(__year, substr(__timestamp, 0, 4),,
                 `define(`__year', decr(__year))dnl
</ul>
<h4>__year</h4>
<ul>')dnl
  <li><a href="/__i">__title</a> &ndash; <span class="timestamp">__timestamp</span></li>
')
</ul>
</div>
include(footer.html)
