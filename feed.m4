<?xml version="1.0" encoding="UTF-8"?>
<feed xml:lang="en-US" xmlns="http://www.w3.org/2005/Atom">
  <title>Technomancy</title>
  <id>tag:technomancy.us,2007:blog/</id>
  <link href="https://technomancy.us/atom" rel="self" type="application/atom+xml"/>
  <link href="https://technomancy.us/" rel="alternate" type="text/html"/>
  <updated>syscmd(date -Iseconds -u)Z</updated>

define(__feed)dnl
define(`fordown',`ifelse($#,0,``$0'',`ifelse(eval($2>=$3),1,
    `pushdef(`$1',$2)$4`'popdef(`$1')$0(`$1',decr($2),$3,`$4')')')')
dnl The obvious thing here would be to define <, >, and & as macros.
dnl Sadly those are not valid macro names according to m4.
fordown(`__i',__latest,eval(__latest-10),`
    syscmd(sed "s/\&/\&amp;/g;s/>/\&gt;/g;s/</\&lt;/g" __i.m4 | m4 -D__feed)')
</feed>
