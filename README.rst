Installation
============

If you use NeoBundle, add to your ``~/.vimrc`` the following line::

  NeoBundle 'nkpart/slide-madness'

Then run ``:NeoBundleInstall`` within Vim.


Usage
=====

Slides must be in sequential numerical order of the form
``/\d+\.[^.]*\.slide\.hs/``, and are run in numerical order.


Navigation
----------

``==`` moves to the next slide, while ``--`` goes back to the
previous slide.


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
extracted into a file which is run via ``runghc`` and subsequently
deleted.

If the file ``Styles.hs`` exists, the first line of this file will
``import Styles``.

This facility could be used to do such things as send commands to
your terminal.

Currently, a ``main`` must be provided by each slide.
