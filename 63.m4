<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2006-09-17T22:48:22Z)dnl
define(__title, `more rails testing help')dnl
define(__id, 63)dnl
include(header.html)
<p>Hi,  my name is Phil,  and I suck at testing my views.</p>

<p>You might argue that views aren't that crucial to functionality, 
  and that's not the job of the programmer&mdash;a designer will have to go
  over them anyway. If you're on a team with a designer,  it might not
  be your job to make sure everything is displayed properly. However, 
  there is something pretty functionally crucial about the
  views&mdash;forms. No amount of CSS and designer-fu will be able to fix a
  form that doesn't ask the right questions.</p>

<pre class='code'>
  <span class="keyword">def</span> <span class="function-name">post_form_check</span>(action,  params = <span class="variable-name">nil</span>,  session = <span class="variable-name">nil</span>,  flash = <span class="variable-name">nil</span>)
    get_action,  action = action <span class="keyword">if</span> action.is_a?(<span class="type">Array</span>) 
    get (get_action || action),  params.dup,  session,  flash
    assert_response <span class="constant">: success</span>

    assert_form_elements_present(params)

    post action,  params,  session,  flash
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">assert_form_elements_present</span>(params,  parents=[])
    params.each <span class="keyword">do</span> |id,  value|
      <span class="keyword">next</span> <span class="keyword">if</span> id.to_sym == <span class="constant">: id</span>
      <span class="keyword">if</span> value.is_a? <span class="type">Hash</span>
        assert_form_elements_present(value,  parents + [id])
      <span class="keyword">else</span>
        assert_select <span class="string">"input#</span><span class="variable-name">#{(parents + [id]).join('_')}</span><span class="string">"</span>
      <span class="keyword">end</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>
</pre>

<p>Generally when you have a page that people post data to,  users get
  a form from an action in the same controller&mdash;often even the same
  action. So why not have Rails check that the form has the right
  inputs anyway? You've already got a list of input parameters lined
  up in a hash there just asking to be used.</p>

<p><code>post_form_check : new,  { :name => 'Mead',  :description => 'A
    fermented beverage made of honey,  water,  and yeast,  often served
    mulled or with fruit',  :alcoholic => true }</code></p>

<p>The above line will act as a <code>post</code>,  on the <code>:new</code>
  action of your controller,  but will first <code>get</code> the same
  action and ensure that there are <code>&lt;input&gt;</code> tags
  named <code>name</code>,  <code>description</code>, 
  and <code>alcoholic</code>. If you need to <code>get</code> a different
  action than you are <code>post</code>ing to,  you can use an array rather
  than a symbol for the action: </p>

<p><code>post_form_check [:list,  :drink],  { :to_drink => 32 }</code></p>

<p>It still needs a bit of work to be able to support nested hashes, 
  but it should be helpful as it is.</p>

<p><b>Update</b>:  Now works with nested hashes.</p>

<p><a href='http://www.chatmag.com/news/091606_rob_levin.html'>R.I.P lilo</a>.</p>

include(footer.html)
