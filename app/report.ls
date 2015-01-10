$ document .ready ->

  # Response the cover section
  h = window.innerHeight
  w = window.innerWidth
  cover-h = (($ \#cover-section .css \height) / 'px').0
  header-h = (($ \#header .css \height) / 'px').0
  cover-pt = (($ \#cover-section .css \padding-top) / 'px').0
  cover-pb = (($ \#cover-section .css \padding-bottom) / 'px').0
  cover-mt = (($ \#cover-section .css \margin-top) / 'px').0
  cover-mb = (($ \#cover-section .css \margin-bottom) / 'px').0
  padding-shift = (h - header-h - cover-h - cover-mt - cover-mb) / 2
  $ \#cover-section .css \padding-top, padding-shift+\px
  $ \#cover-section .css \padding-bottom, padding-shift+\px

  $ \#photo-shoot-button .click ->


