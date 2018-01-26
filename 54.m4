dnl -*- html -*-
define(__timestamp, 2006-07-26T13:15:10Z)dnl
define(__title, `arorem hacks')dnl
define(__id, 54)dnl
include(header.html)
<a href="http://safetystate.com/ss.cgi?action=material&id=31"><img
		src="/i/patents.png" alt=
		"software patents - because extortionists are people
		too." /></a>

<p>I've been
  improving <a
	       href="http://dev.technomancy.us/phil/wiki/arorem">arorem</a>
  a bit these past few days,  and this little snippet has come in very
  handy: </p>

    <pre>
(<span class="keyword">defvar</span> <span class="variable-name">project-files-table</span> ())

(<span class="keyword">defun</span> <span class="function-name">populate-project-files-table</span> (file)
  (<span class="keyword">if</span> (file-directory-p file)
      (mapc 'populate-project-files-table (directory-files file t <span class="string">"^[</span><span class="string"><span class="negation-char">^</span></span><span class="string">\.]"</span>))
    (setq project-files-table (acons (file-name-nondirectory file) file project-files-table))))

(<span class="keyword">defun</span> <span class="function-name">find-file-in-project</span> (file)
  (interactive (list (completing-read <span class="string">"Find file in project:  "</span> (mapcar 'car (project-files)))))
  (find-file (cdr (assoc file project-files-table))))

(<span class="keyword">defun</span> <span class="function-name">project-files</span> ()
  (<span class="keyword">when</span> (or (not project-files-table) <span class="comment-delimiter">; </span><span class="comment">initial load
</span>            (not (string-match (rails-root) (cdar project-files-table)))) <span class="comment-delimiter">; </span><span class="comment">switched projects
</span>    (setq project-files-table nil)
    (populate-project-files-table (concat (rails-root) <span class="string">"/app"</span>)))
  project-files-table)


(<span class="keyword">defun</span> <span class="function-name">rails-root</span> (<span class="type">&amp;optional</span> dir)
  (or dir (setq dir default-directory))
  (<span class="keyword">if</span> (file-exists-p (concat dir <span class="string">"config/environment.rb"</span>))
      dir
    (<span class="keyword">if</span> (equal dir  <span class="string">"/"</span>)
        nil
      (rails-root (expand-file-name (concat dir <span class="string">"../"</span>))))))
</pre>

include(footer.html)
