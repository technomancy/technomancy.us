dnl -*- html -*-
define(__timestamp, 2013-04-01T20:42:59Z)dnl
define(__title, `in which we cater to those with an allergic reaction to parentheses')dnl
define(__id, 165)dnl
include(header.html)
<p><a href="https://groups.google.com/group/clojure/browse_thread/thread/1d97dff96dbc5430">A</a> <a href="https://gist.github.com/headius/5285216">lot</a>
  of <a href="http://www.smbc-comics.com/?id=2491">people</a> have
  been talking about how parentheses are such a big barrier to
  adoption of Clojure these days. Apparently they're pretty
  intimidating when you're used to a language with a lot of curly
  braces and things. While I can't do anything about Clojure itself,
  I realized we could make some changes to Leiningen that would
  allow newcomers to return to the comfort of XML. My latest plugin
  is
  called <a href="https://github.com/technomancy/lein-xml">lein-xml</a>,
  and it lets you write this:</p>

<pre class="code"><span class="nxml-processing-instruction-delimiter">&lt;?</span><span class="nxml-processing-instruction-target">xml</span> <span class="nxml-attribute-local-name">version</span>=<span class="nxml-attribute-value-delimiter">"</span><span class="nxml-attribute-value">1.0</span><span class="nxml-attribute-value-delimiter">"</span> <span class="nxml-attribute-local-name">encoding</span>=<span class="nxml-attribute-value-delimiter">"</span><span class="nxml-attribute-value">UTF-8</span><span class="nxml-attribute-value-delimiter">"</span><span class="nxml-processing-instruction-delimiter">?&gt;</span>
<span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">project</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">groupId</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">org.leiningen</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">groupId</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">artifactId</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">sample</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">artifactId</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">version</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">0.1.0-SNAPSHOT</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">version</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">description</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">Just some kind of sample thing</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">description</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">url</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">https://github.com/technomancy/lein-xml</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">url</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">licenses</span><span class="nxml-tag-delimiter">&gt;</span>
    <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">license</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">name</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">Eclipse Public License</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">name</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">url</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">http://www.eclipse.org/legal/epl-v10.html</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">url</span><span class="nxml-tag-delimiter">&gt;</span>
    <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">license</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">licenses</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">dependencies</span><span class="nxml-tag-delimiter">&gt;</span>
    <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">dependency</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">groupId</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">org.clojure</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">groupId</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">artifactId</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">clojure</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">artifactId</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">version</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">1.5.1</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">version</span><span class="nxml-tag-delimiter">&gt;</span>
    <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">dependency</span><span class="nxml-tag-delimiter">&gt;</span>
    <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">dependency</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">groupId</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">slamhound</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">groupId</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">artifactId</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">slamhound</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">artifactId</span><span class="nxml-tag-delimiter">&gt;</span>
      <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-element-local-name">version</span><span class="nxml-tag-delimiter">&gt;</span><span class="nxml-text">1.3.3</span><span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">version</span><span class="nxml-tag-delimiter">&gt;</span>
    <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">dependency</span><span class="nxml-tag-delimiter">&gt;</span>
  <span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">dependencies</span><span class="nxml-tag-delimiter">&gt;</span>
<span class="nxml-tag-delimiter">&lt;</span><span class="nxml-tag-slash">/</span><span class="nxml-element-local-name">project</span><span class="nxml-tag-delimiter">&gt;</span></pre>

<p>...instead of this bewildering, unfamiliar invocation:</p>

<pre class="code"><span class="esk-paren"><span class="hl-line">(</span></span><span class="keyword"><span class="hl-line">defproject</span></span><span class="hl-line"> </span><span class="function-name"><span class="hl-line">org.leiningen/sample</span></span><span class="hl-line"> </span><span class="string"><span class="hl-line">"0.1.0-SNAPSHOT"</span></span><span class="hl-line">
</span>  <span class="constant">:description</span> <span class="string">"Just some kind of sample thing"</span>
  <span class="constant">:url</span> <span class="string">"https://github.com/technomancy/lein-xml"</span>
  <span class="constant">:license</span> {<span class="constant">:name</span> <span class="string">"Eclipse Public License"</span>
            <span class="constant">:url</span> <span class="string">"http://www.eclipse.org/legal/epl-v10.html"</span>}
  <span class="constant">:dependencies</span> [[org.clojure/clojure <span class="string">"1.5.1"</span>]
                 [slamhound <span class="string">"1.3.3"</span>]]<span class="esk-paren">)</span></pre>

<p>I know it probably won't be used by anyone who has spent much
  time with Clojure, but for newcomers hopefully this will remove
  one of the big blockers for enterprise developers trying out
  Clojure.</p>
include(footer.html)
