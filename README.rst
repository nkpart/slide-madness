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

For Vim commands that should be executed in every slide, put them in
``default.vim`` alongside the slides.  ``default.vim`` is sourced
for each slide, *before* executing commands from the slides
themselves.

When each slide is displayed, *after* sourcing ``default.vim`` (if
it exists), slide-madness looks for lines beginning with ``-- :``,
writes the remainder of all such lines into a file and sources that
file, before deleting it.

Be aware that ``set`` will affect subsequent slides.  Use
``setlocal`` to apply settings to a single slide.


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
