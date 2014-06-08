Installation
============

If you use NeoBundle, add to your ``~/.vimrc`` the following line::

  NeoBundle 'nkpart/slide-madness'

Then run ``:NeoBundleInstall`` within Vim.


Usage
=====

A slide is any file with a name matching ``*.slide.*``.  Slides are
run in lexicographical order (you may need to zero-pad if your
slide filenames begin with numbers).


Navigation
----------

``==`` moves to the next slide, while ``--`` goes back to the
previous slide.  There are no smarts to automatically open the first
slide; you have to open a slide to start.


Executing Vim commands when entering a slide
--------------------------------------------

When each slide is displayed, slide-madness looks for lines
beginning with ``-- :``, writes the remainder of all such lines into
a file and sources the file, before deleting it.

This could be used to ``set nonumber``, change highlighting
configuration or many other things you might find useful during a
presentation.


Executing Haskell code when entering a slide
--------------------------------------------

When each slide is displayed, slide-madness looks for lines
beginning with ``-- >``.  The remainder of each such line is
extracted into a file that is executed via ``runghc`` and
subsequently deleted.  ``runghc`` is only invoked for files where
matching lines were found.

If the file ``Styles.hs`` exists, the first line of this file will
``import Styles``.

This facility could be used to do such things as send commands to
your terminal.

Currently, a ``main :: IO ()`` function must be provided by each
slide using this capability.
