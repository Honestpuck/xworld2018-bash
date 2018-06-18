# xworld2016

A repo for my workshop at X World 2018 "Beginning Bash"

It contains a bunch of example scripts and the Markdown source and reveal.js slideshow for the presentation.

The reveal.js slideshow is created using [pandoc](http://pandoc.org). The exact pandoc command can be found in `pandoc.sh`.

The `slides.pdf` file is generated by running the slideshow in  a browser with the query `?print-pdf` and then saving to PDF from the print dialog. As the background doesn't print properly in the normal slideshow the special version `print.html` has been created with the command line `pandoc-print.sh` that doesn't include the background. So to create the PDF the URL is `http://localhost:8000/print.html?print-pdf` if you run `python -m SimpleHTTPServer` in this directory. The `slides_notes.pdf` file is generated using `Marked 2` and `Export as, Save PDF`.

| File                 | Description                                |
| -------------------- | ------------------------------------------ |
| README.md            | This file |
| index.html           | The presentation slides |
| pandoc.sh            | command line to run Pandoc and create slideshow |
| pandoc-print.sh      | command line to create `print.html` |
| print.html           | special edition of slides without background |
| reveal.js/*          | Slideshow software |
| shell_bits/*         | Example bash scripts |
| slides.pdf           | a PDF of the presentation slides |
| slides_notes.pdf     | a PDF of the slides and my notes |
| bash_talk.md         | Markdown source for the slides |

