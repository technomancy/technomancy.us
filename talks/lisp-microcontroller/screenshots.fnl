(local firefox (.. (os.getenv "HOME") "/bin/firefox-dev-edition/firefox-bin"))
(local in (. arg 1))
(local cmd (.. "~/bin/firefox-dev-edition/firefox -P headless "
               "--window-size=800,600 --screenshot screenshots/%02d.png \"%s\""))
(local out (io.open (. arg 2) "w"))
(: out :write "\\pagenumbering{gobble}\n")

(var n 0)
(each [url (io.lines in)]
  (set n (+ n 1))
  (print url)
  (if (: url :find "jpg")
      (do (os.execute (: "curl -o screenshots/%02d.jpg %s" :format n url))
          (: out :write (: "![](screenshots/%02d.jpg) \\newpage \n" :format n)))
      (: url :find "png")
      (do (os.execute (: "curl -o screenshots/%02d.png %s" :format n url))
          (: out :write (: "![](screenshots/%02d.png) \\newpage \n" :format n)))
      (do (os.execute (: cmd :format n url))
          (: out :write (: "![](screenshots/%02d.png) \\newpage \n" :format n)))))
